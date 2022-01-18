package com.project.nadaum.websocket.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.websocket.model.dao.WebsocketDao;

@Service
public class WebsocketServiceImpl implements WebsocketService {
	
	@Autowired
	private WebsocketDao websocketDao;

}
