package com.project.nadaum.websocket.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.nadaum.member.model.vo.Member;
import com.project.nadaum.websocket.model.vo.Message;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MessageController {

	@Autowired
	private SimpMessagingTemplate template;
	
	@GetMapping("/member/mypage/chat.do")
	public void chatMain(@AuthenticationPrincipal Member member, Model model, @RequestParam String room) {
		Message message = new Message();
		message.setMessage(member.getNickname() + "님이 입장하셨습니다.");
		template.convertAndSend("topic/" + room, message);
		model.addAttribute("room", room);
	}
	
	@MessageMapping("/chat/join")
	public Message sendMsg(String room, Message message) {
		log.debug("room = {}", room);
		log.debug("message = {}", message);
		template.convertAndSend("/topic/" + room, message);
		return message;
	}
		
	@MessageMapping("/chat/{room}")
	@SendTo("/topic/{room}")
	public Message showUsers(@Payload Message message) {
		log.debug("message = {}", message);
		return message;		
	}
	
}
