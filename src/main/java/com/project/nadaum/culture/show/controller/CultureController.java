package com.project.nadaum.culture.show.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.nadaum.culture.show.model.service.CultureService;
import com.project.nadaum.culture.show.model.vo.Culture;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/culture")
public class CultureController {

	@Autowired
	private CultureService cultureService;
	
	@GetMapping("/cultureBoardList.do")
	public void boardList() {}
	
	@GetMapping("/culture.do")
	public void culture(Model model) {
		List<Culture> list = cultureService.selectCultureList();
		model.addAttribute("list", list);
	}
	
}
