package com.project.nadaum.member.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.nadaum.member.model.service.MailSendService;
import com.project.nadaum.member.model.service.MemberService;
import com.project.nadaum.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member")
@Slf4j
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	private MailSendService mailSendService;
		
	@GetMapping("/memberLogin.do")
	public void memberLogin() {}

	@GetMapping("/memberDetail.do")
	public void memberDetail(Authentication authentication) {
		log.debug("authentication = {}", authentication);
	}
	
	@GetMapping("/memberEnroll.do")
	public void memberEnroll() {}
	
	@GetMapping("/checkIdDuplicate.do")
	public ResponseEntity<Map<String, Object>> checkIdDuplicate(@RequestParam String id){
		Member member = memberService.selectOneMember(id);
		boolean available = member == null;
		
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("available", available);		
		
		return ResponseEntity.ok(map);
	}
	
	@PostMapping("/memberEnroll.do")
	public String memberEnroll(Member member, RedirectAttributes redirectAttr) {
		log.debug("member = {}", member);
		String rawPassword = member.getPassword();
		String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
		member.setPassword(encodedPassword);
		
		String authKey = mailSendService.sendAuthMail(member.getEmail());
		member.setAuthKey(authKey);
		log.debug("authKey = {}", authKey);
		int result = memberService.insertMember(member);
		result = memberService.insertRole(member);
		
		redirectAttr.addFlashAttribute("result", result);
		return "redirect:/";
	}
	
	@GetMapping("/memberConfirm.do")
	public String memberConfirm(@RequestParam Map<String, String> map) {
		int result = memberService.confirmMember(map);
		
		if(result > 0) {
			return "member/memberLogin";
		}
		
		return "redirect:/";
	}
	
}
