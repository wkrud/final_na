package com.project.nadaum.accountbook.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.nadaum.accountbook.model.service.AccountBookService;
import com.project.nadaum.accountbook.model.vo.AccountBook;

import lombok.extern.slf4j.Slf4j;

	
@Slf4j
@Controller
@RequestMapping("/accountbook")
public class AccountBookController {
	
	@Autowired
	private AccountBookService accountBookService;

	@RequestMapping(value="/accountbook.do")
	public void accountbook() { }
	
	@GetMapping(value="/selectAllAccountList.do")
	public String selectAllAccountList (@RequestBody String id, Model model) { 
		log.info("id={}", id);
		List<AccountBook> accountList = accountBookService.selectAllAccountList(id); 
		log.info("accountList={}",accountList);
		model.addAttribute("accountList",accountList); 
		
		return "/accountbook.do"; }
	
	@RequestMapping(value="/accountInsert.do", method=RequestMethod.POST)
	public String insertAccount(AccountBook account) {
		 log.info("account={}", account); 
		 int result = accountBookService.insertAccount(account); 
		 
		return "redirect:/accountbook/accountbook.do";
	}
	
	@RequestMapping(value="/accountDelete.do", method=RequestMethod.POST)
	public String deleteAccount(@RequestParam("code") String code) {
		int result = accountBookService.deleteAccount(code);
		
		return "redirect:/accountbook/accountbook.do";
	}
	
	
	
}

	


