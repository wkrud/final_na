package com.project.nadaum.websocket.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.socket.TextMessage;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.project.nadaum.member.model.service.MemberService;
import com.project.nadaum.member.model.vo.Member;
import com.project.nadaum.websocket.model.service.WebsocketService;
import com.project.nadaum.websocket.model.vo.Alarm;
import com.project.nadaum.websocket.model.vo.Message;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MessageController {

	@Autowired
	private ServletContext application;
	
	@Autowired
	private WebsocketService websocketService;
	
	@Autowired
	private MemberService memberService;
	
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
	public Message sendMsg(@AuthenticationPrincipal Member member, String info, Message message) {
		log.debug("room = {}", info);
		log.debug("message = {}", message);
		log.debug("member = {}", member);
				
		Gson gson = new GsonBuilder().create();
		
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("HH.mm");
		String now = sdf.format(d);
		
		message.setMessage(member.getNickname() + "님이 입장했습니다.");
		message.setWriter(member.getNickname());
		message.setTime(now);
		message.setType("GREETING");
		gson.toJson(message);
		
		template.convertAndSend("/topic/" + message.getRoom(), gson.toJson(message));
		return message;
	}
		
	@MessageMapping("/chat/{room}")
	@SendTo("/topic/{room}")
	public void showUsers(@AuthenticationPrincipal Member member, Message message) {
		
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("a HH.mm", Locale.KOREA);
		String now = sdf.format(d);
				
		String profile = application.getContextPath() + "/resources/upload/member/profile/";
		log.debug("profile = {}", profile);
		log.debug("member = {}", member);
		Gson gson = new GsonBuilder().create();
		if("D".equals(member.getLoginType()) && "Y".equals(member.getProfileStatus())) {
			message.setProfile(profile + member.getProfile());
		}else if("D".equals(member.getLoginType()) && "N".equals(member.getProfileStatus())) {
			message.setProfile(profile + "default_profile_cat.png");
		}else if("K".equals(member.getLoginType())) {			
			message.setProfile(member.getProfile());
		}
		message.setTime(now);
		message.setType("CHAT_TYPE");
		
		log.debug("message = {}", message);
		
		template.convertAndSend("/topic/" + message.getRoom(), gson.toJson(message));
		
	}
	
	@MessageMapping("/chat/alarm/{friendNickname}")
	@SendTo("/topic/{friendNickname}")
	public void friendAlarm(@Payload Alarm alarm) {
		log.debug("alarm = {}", alarm);
		
//		Map<String, Object> param = new HashMap<>();
//		param.put("id", alarm.getSenderId());
//		Member sender = memberService.selectOneMember(param);
//		Member receiver = memberService.selectOneMemberNickname(alarm.getFriendNickname());
//		log.debug("sender = {}", sender);
//		log.debug("receiver = {}", receiver);
//		String msg = "";
//		if(("free".equals(alarm.getFlag()) || "follower".equals(alarm.getFlag()))) {
//			msg = sender.getNickname() + "님이 " + receiver + "님을 친구추가 했습니다.";						
//		}else if("friend".equals(alarm.getFlag())) {
//			msg = sender.getNickname() + "님이 " + receiver + "님을 친구삭제했습니다.";		
//		}else if("following".equals(alarm.getFlag())) {
//			msg = sender.getNickname() + "님이 팔로잉을 그만두었습니다.";			
//		}
//		alarm.setMessage(msg);
		Gson gson = new GsonBuilder().create();
		
		template.convertAndSend("/topic/" + alarm.getFriendNickname(), gson.toJson(alarm));
	}
	
}
