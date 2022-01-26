package com.project.nadaum.accountbook.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import org.apache.tomcat.util.json.JSONParser;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.project.nadaum.accountbook.model.vo.AccountBookChart;

import lombok.extern.slf4j.Slf4j;

	
@Slf4j
@Controller
@RequestMapping("/accountbook")
public class AccountBookController {
	
	@Autowired
	private AccountBookService accountBookService;

	@RequestMapping(value="/accountbook.do")
	public void accountbook() { }
	
	@RequestMapping(value="/accountList.do")
	public void accountList() { }
	
	
	//전체 리스트 출력
	@ResponseBody
	@RequestMapping(value="/selectAllAccountList.do") 
	 public List<AccountBook> selectAllAccountList (String id, Model model) { 
		 List<AccountBook> accountList = accountBookService.selectAllAccountList(id);
		 model.addAttribute("accountList",accountList);
	 
	 return accountList; 
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
	 @ResponseBody 
	 @PostMapping(value="/incomeExpenseFilter.do") 
	 public List<AccountBook> incomeExpenseFilter(@RequestBody Map<String, Object> param, Model model) {
		 Map<String, Object> map = new HashMap<>();
		 map.put("id", param.get("id"));
		 map.put("income_expense", param.get("income_expense"));
		 
		 List<AccountBook> incomeList = accountBookService.incomeExpenseFilter(map); 
		 model.addAttribute(incomeList);
	  
		 return incomeList; 
	  }
	 
	 
	 //검색
	 @ResponseBody
	 @RequestMapping(value="/searchList.do", method=RequestMethod.POST )
	 public List<AccountBook> searchList(@RequestParam Map<String, Object> param, Model model) {
		 Map<String, Object> map = new HashMap<>();
		 map.put("income_expense", param.get("\"income_expense"));
		 map.put("category", param.get("category"));
		 map.put("detail", param.get("detail"));
		 map.put("id", param.get("id"));
			
		 List<AccountBook> list = accountBookService.searchList(map);
		 model.addAttribute(list); 
		 
		return list;
	 }
	 
	 //차트
	 @ResponseBody
	 @PostMapping("/incomeChart.do")
	 public void chartValue (@RequestBody Map<String, Object> param, Model model) {
		 Map<String, Object> map = new HashMap<>();
		 map.put("id", param.get("id"));
		 map.put("income_expense", param.get("income_expense"));
		 log.info("map={}", map);
		 HashMap<String, Object> chartValue = accountBookService.chartValue(map);
		 
		 log.debug("chart={}", chartValue);
		
		 
	 }
}

	


