package com.project.nadaum.audiobook.controller;

import java.io.IOException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.nadaum.audiobook.service.AudioBookService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AudioBookController {

	@Autowired
	private AudioBookService audioBookService;
	
	//사용자가 크롤링할 url을 post나 get으로 받아서 html요소를 받아오기
	//public String urlGetter(@RequestBody UrlParser url) {}
	
	@PostMapping("/parser/parsedata")
	public String urlGetter() {
		log.info("/parser/parsedata가 호출됨");
		try {		
			String url= "https://audioclip.naver.com/panels/rank#8";
			Document doc =  Jsoup.connect(url).get();
			Elements body = doc.body().getAllElements();
			System.out.println(doc);					
		} catch (IOException e) {
			log.error(e.getMessage(), e);
		}
		return "audiobook/api_test";
	}
}
