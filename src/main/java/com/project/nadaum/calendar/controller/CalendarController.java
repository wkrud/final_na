package com.project.nadaum.calendar.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.tomcat.util.json.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	public Map<String, Object> addCalendar(@RequestBody Map<String, Object> eventData) {
		Map<String, Object> map = new HashMap<String, Object>();	
		map.put("id", eventData.get("id"));
		map.put("title", eventData.get("title"));
		map.put("startDate", eventData.get("start"));
		map.put("endDate", eventData.get("end"));
		map.put("content", eventData.get("description"));
		map.put("type", eventData.get("type"));
		map.put("backgroundColor", eventData.get("backgroundColor"));
		map.put("textColor", eventData.get("textColor"));
		map.put("allDay", eventData.get("allDay"));
		System.out.println(map);
		int result = calendarService.addCalendar(map);
		return map;
		
	}
	
	
}
