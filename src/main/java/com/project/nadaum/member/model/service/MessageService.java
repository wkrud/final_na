package com.project.nadaum.member.model.service;

import java.util.Map;

import org.springframework.web.bind.annotation.PostMapping;

import lombok.extern.slf4j.Slf4j;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Slf4j
public class MessageService {
	
	private DefaultMessageService messageService;
	
	public MessageService() {
		this.messageService = NurigoApp.INSTANCE.initialize("api-key", "api-secret-key", "https://api.coolsms.co.kr");
	}
	
	@PostMapping("/send-one")
	public SingleMessageSentResponse sendMessage(Map<String, String> param) {
		Message message = new Message();
		message.setFrom(param.get("from"));
		message.setTo(param.get("to"));
		message.setText(param.get("text"));
		
		SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
		log.debug("response = {}", response);
		
		return response;
	}

}
