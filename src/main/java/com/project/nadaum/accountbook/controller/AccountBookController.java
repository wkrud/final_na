package com.project.nadaum.accountbook.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

public class AccountBookController {
	
	@Controller
//	@Slf4j
	@RequestMapping("/accountbook")
	public class AccountBookCountroller {

		@GetMapping("/accountbookView.do")
		public void accountbookView() {}
	}

}
