package com.project.nadaum.culture.show.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.nadaum.common.HelloSpringUtils;
import com.project.nadaum.culture.show.model.service.BoardService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/culture")
public class CultureController {

	@Autowired
	private BoardService boardService;
	
	/**
	 * pageContext - request - session - application
	 * 빈을 관리하는 스프링의 servlet-context가 아니다.
	 */
	@Autowired
	private ServletContext application;
	
	@GetMapping("/cultureBoardList.do")
	public void boardList() {}
	
	@GetMapping("/boardList.do")
	public void boardList(
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request, 
			Model model) {
		// 1.content영역
		int limit = 10;
		int offset = (cPage - 1) * limit;

		Map<String, Object> param = new HashMap<>();
		param.put("offset", offset);
		param.put("limit", limit);
		
//		List<Culture> list = boardService.selectBoardList(param);
//		log.debug("list = {}", list);
		
		// 2.pagebar영역
		int totalContent = boardService.selectTotalContent();
		String url = request.getRequestURI();
		String pagebar = HelloSpringUtils.getPagebar(cPage, limit, totalContent, url);
		
		model.addAttribute("totalContent", totalContent);
		model.addAttribute("pagebar", pagebar);
		
		
		
	}
	
	
}
