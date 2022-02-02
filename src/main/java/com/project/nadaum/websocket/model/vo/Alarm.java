package com.project.nadaum.websocket.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Alarm implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String type;
	private String flag;
	private String senderId;
	private String friendNickname;
	private String message;
	private String host;
	private String guest;
	private String room;

}
