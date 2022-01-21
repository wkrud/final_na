package com.project.nadaum.accountbook.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.nadaum.accountbook.model.service.AccountBookService;
import com.project.nadaum.accountbook.model.vo.AccountBook;

import lombok.extern.slf4j.Slf4j;

	
@Slf4j
@Controller
@RequestMapping("/accountbook")
public class AccountBookController {
	
	@Autowired
	private AccountBookService accountBookService;
	
	@GetMapping("/accountbook.do")
	public void accountbook() {}
	
	@RequestMapping(value="/accountInsert.do", method=RequestMethod.POST)
	public String insertAccount(AccountBook account) {
		 log.info("account={}", account); 
		 int result = accountBookService.insertAccount(account); 
		 String msg = result > 0 ? "등록 성공!" : "등록 실패!"; log.info("msg={}", msg);
		 
		return "redirect:/accountbook/accountbook.do";
	}
}

	


