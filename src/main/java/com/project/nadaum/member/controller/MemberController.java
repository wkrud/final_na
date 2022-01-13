package com.project.nadaum.member.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member")
@Slf4j
public class MemberController {
		
	@GetMapping("/memberLogin.do")
	public void memberLogin() {}

	@GetMapping("/memberDetail.do")
	public void memberDetail(Authentication authentication) {
		log.debug("authentication = {}", authentication);
	}
	
	
}
