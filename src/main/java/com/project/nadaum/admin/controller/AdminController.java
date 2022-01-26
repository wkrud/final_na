package com.project.nadaum.admin.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.nadaum.admin.model.service.AdminService;
import com.project.nadaum.admin.model.vo.Help;
import com.project.nadaum.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member/admin")
public class AdminController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private AdminService adminService;
	
	@GetMapping("/adminAllHelp.do")
	public void adminAllHelp(Model model) {
		List<Help> listMap = adminService.selectAllHelp();
		log.debug("listMap = {}", listMap);
		model.addAttribute("listMap", listMap);
	}
	
	@GetMapping("/adminHelpAnswer.do")
	public void adminHelpAnswer(@RequestParam Map<String, Object> map, Model model) {
		log.debug("map = {}", map);
		Help help = adminService.selectOneHelp(map);
		model.addAttribute("help", help);
	}
	
	@PostMapping("/adminHelpAnswer.do")
	public String adminHelpAnswer(Help help) {
		log.debug("help = {}", help);
		int result = 0;
		if(help.getACode() != null) {
			result = adminService.updateHelpAnswer(help);
		}else {
			result = adminService.insertHelpAnswer(help);
		}
		return "redirect:/member/admin/adminAllHelp.do";
	}

}
