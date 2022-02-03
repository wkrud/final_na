package com.project.nadaum.accountbook.controller;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.nadaum.accountbook.model.service.AccountBookService;
import com.project.nadaum.accountbook.model.vo.AccountBook;
import com.project.nadaum.common.NadaumUtils;
import com.project.nadaum.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

	
@Slf4j
@Controller
@RequestMapping("/accountbook")
public class AccountBookController {
	
	@Autowired
	private AccountBookService accountBookService;

	@RequestMapping(value="/accountbook.do")
	public void accountbook() {}
	
	@RequestMapping(value="/detailChart.do")
	public void detailChart(@RequestParam(defaultValue="0") int monthly, @AuthenticationPrincipal Member member, Model model) {
		Map<String, Object> param = new HashMap<>();
		param.put("monthly", monthly);
		param.put("id", member.getId());
		
		List<AccountBook> countList = accountBookService.monthlyCountList(param);
		log.info("countList={}",countList);
		model.addAttribute("countList", countList);	
		}
	
	
	 //전체 리스트 출력
	 @RequestMapping(value="/selectAllAccountList.do") 
	 public String selectAllAccountList (@AuthenticationPrincipal Member member, Model model) {
		String id = member.getId(); 
		List<AccountBook> accountList = accountBookService.selectAllAccountList(id);
		model.addAttribute("accountList",accountList);
	 
		return "/accountbook/accountList";

	 }
	
	 // 가계부 추가
	@RequestMapping(value="/accountInsert.do", method=RequestMethod.POST)
	public String insertAccount(AccountBook account) {
		 int result = accountBookService.insertAccount(account); 
		 
		return "redirect:/accountbook/accountbook.do";
	}
	
	// 가계부 삭제
	@ResponseBody
	@RequestMapping(value="/accountDelete.do", method=RequestMethod.POST)
	public Map<String, Object> deleteAccount(@RequestBody Map <String, Object> code) {		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", code.get("code"));	
		int result = accountBookService.deleteAccount(map);
		return map;
	}
	
	//월간 수입, 지출 금액
	@ResponseBody
	@GetMapping(value="/monthlyTotalIncome.do")
	public List<AccountBook> monthlyTotalIncome(String id, Model model) {
		List<AccountBook> incomeList = accountBookService.monthlyTotalIncome(id);
		
		return incomeList;
	}
	
	//월간 총 합계 금액
	@ResponseBody
	@GetMapping(value="/monthlyAccount.do")
	public String monthlyAccount(String id, Model model) {
		String monthlyAccount = accountBookService.monthlyAccount(id);
		log.info("monthlyAccount={}", monthlyAccount);
		//만약 사용자 입력값이 없어서 monthlyAccount합계가 null값이 넘어온다면 해당 변수에 0 대입
		if (monthlyAccount == null) {
			monthlyAccount = "0";
		}
		model.addAttribute(monthlyAccount);
		
		return monthlyAccount;
	}
	
	// 수입, 지출별 정렬
	 @PostMapping(value="/incomeExpenseFilter.do") 
	 public String incomeExpenseFilter(@RequestBody Map<String, Object> param,  Model model) {
		 Map<String, Object> map = new HashMap<>();
		 map.put("id", param.get("id"));
		 map.put("incomeExpense", param.get("incomeExpense"));
		 log.debug("map= {}",map);
		 
		 List<AccountBook> accountList = accountBookService.incomeExpenseFilter(map); 
		 model.addAttribute("accountList", accountList);	  
		 
		 return "/accountbook/accountList";
	  }
	 
	 
	 //검색
	 @RequestMapping(value="/searchList.do", method=RequestMethod.POST)
	 public String searchList(@RequestParam Map<String, Object> param, Model model) {
		 Map<String, Object> map = new HashMap<>();
		 map.put("incomeExpense", param.get("\"incomeExpense"));
		 map.put("category", param.get("category"));
		 map.put("detail", param.get("detail"));
		 map.put("id", param.get("id"));
		 log.info("map={}", map);
			
		 List<AccountBook> accountList = accountBookService.searchList(map);
		 log.info("list={}", accountList);
		 
		 model.addAttribute("accountList", accountList); 
		 
		 return "/accountbook/accountList";
	 }
	 	
	 	//차트
		@ResponseBody
		@PostMapping(value="/incomeChart.do", produces="application/json; charset=UTF-8") 
		public List<Map<String, Object>> chartValue (@RequestBody Map<String, Object> param, Model model) {
		Map<String, Object> map = new HashMap<>(); 
		map.put("id", param.get("id"));
		map.put("incomeExpense", param.get("incomeExpense")); 
		List<Map<String, Object>> chartValue = accountBookService.chartValue(map);
		log.debug("chartValue={}", chartValue);
			  
		return chartValue ;
	}
		
		//detailChart
		@ResponseBody
		@PostMapping(value="/detailMonthlyChart.do", produces="application/json; charset=UTF-8")
		public List<Map<String, Object>> detailMonthlyChart(@AuthenticationPrincipal Member member, Model model) {
			Map<String, Object> map = new HashMap<>(); 
			map.put("id", member.getId());		
			List<Map<String, Object>> list = accountBookService.detailMonthlyChart(map);
			log.debug("list={}", list);
			return list;
			
		}
			  
		//엑셀
		@GetMapping("/excel")
		public void downloadExcel(HttpServletResponse resp, @AuthenticationPrincipal Member member) throws IOException{
			//엑셀에 담을 리스트 조회
			String id = member.getId();
			List<AccountBook> list = accountBookService.selectAllAccountList(id);
			log.debug("list={}",list);
			
				//엑셀 파일 생성
				Workbook workbook = new XSSFWorkbook();
				//엑셀 제목
				String fileName = "나다움-" + member.getName()+"님의 가계부 내역";
				//엑셀 내부의 시트 생성
				Sheet sheet = workbook.createSheet("나다움-" + member.getName()+"님의 가계부 내역");
				//rowNum 카운팅 변수
				int rowNo = 0;
				
				//엑셀 헤더 컬러/폰트
				CellStyle headStyle = workbook.createCellStyle();
				headStyle.setFillForegroundColor(HSSFColor.HSSFColorPredefined.LIGHT_BLUE.getIndex());
				headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
				Font font = workbook.createFont();
				font.setColor(HSSFColor.HSSFColorPredefined.WHITE.getIndex());
				font.setFontHeightInPoints((short) 13);
				headStyle.setFont(font);
				
				//헤더 내용
				Row headerRow = sheet.createRow(rowNo++);
				headerRow.createCell(0).setCellValue("날짜");
				headerRow.createCell(1).setCellValue("결제수단");			
				headerRow.createCell(2).setCellValue("대분류");
				headerRow.createCell(3).setCellValue("소분류");
				headerRow.createCell(4).setCellValue("내역");
				headerRow.createCell(5).setCellValue("금액");
					
				//헤더에 스타일 입히기
				for(int i = 0; i <= 5; i++) {
					headerRow.getCell(i).setCellStyle(headStyle);
				}
				
				//엑셀에 담을 내용 포맷 변환용 코드
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				DecimalFormat df = new DecimalFormat("#,###");

				//엑셀에 담을 리스트 for문으로 한 줄씩 담아주기
				for(AccountBook accountbook : list) {
					Row row = sheet.createRow(rowNo++);
					row.createCell(0).setCellValue(format.format(accountbook.getRegDate()));
					row.createCell(1).setCellValue(accountbook.getPayment().equals("card") ? "카드" : "현금");
					row.createCell(2).setCellValue(accountbook.getIncomeExpense().equals("I") ? "수입" : "지출");
					row.createCell(3).setCellValue(accountbook.getCategory());
					row.createCell(4).setCellValue(accountbook.getDetail());
					row.createCell(5).setCellValue(df.format(accountbook.getPrice()));
			}
			
			//셀 크기 설정
			sheet.setColumnWidth(0, 3000);
			sheet.setColumnWidth(1, 3000);
			sheet.setColumnWidth(2, 2000);
			sheet.setColumnWidth(3, 3000);
			sheet.setColumnWidth(4, 8000);
			sheet.setColumnWidth(5, 3000);
			
			//타입 지정
			resp.setContentType("application/vnd.ms-excel");
			//파일 저장명 -> 이게 지금 안 먹음 ㅠㅠ
			resp.setHeader("content-Disposition", "attachment; filename="+fileName);
			
			try {
				workbook.write(resp.getOutputStream());
			} catch(Exception e) {
				e.printStackTrace();
			
			}
		
		}

}
	 

	


