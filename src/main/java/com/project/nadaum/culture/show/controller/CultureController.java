package com.project.nadaum.culture.show.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/culture")
public class CultureController {

	@GetMapping("/cultureBoardList.do")
	public void boardList() {}
}
