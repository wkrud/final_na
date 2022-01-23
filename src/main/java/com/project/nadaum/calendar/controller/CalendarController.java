package com.project.nadaum.calendar.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.nadaum.calendar.model.service.CalendarService;
import com.project.nadaum.calendar.model.vo.Calendar;

import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONObject;

@Controller
@Slf4j
@RequestMapping("/calendar")
public class CalendarController {
	
	@Autowired(required = false)
	private CalendarService calendarService;

	@GetMapping("/calendarView.do")
	public void calendarView() {}
	
	// 달력데이터 조회 
	@ResponseBody
	@GetMapping("/calendarList.do")
	public List<Calendar> calendarList(
			HttpServletRequest resp, 
			Model model, 
			String id) {
		List<Calendar> list = calendarService.calendarList(id);
		log.debug("id = " + id);
		log.debug("list = {}", list);

		model.addAttribute("list", list);
		return list;
	}

	// 달력데이터 추가
	@ResponseBody
	@PostMapping("/addCalendar.do")
	public Map<String, Object> addCalendar(@RequestBody Map<String, Object> params) {
		log.debug("params = " + params);
		System.out.println(params.get("id"));
		System.out.println(params.get("title"));
//		int result = calendarService.addCalendar(params);
		return params;
	}
	
	
}
