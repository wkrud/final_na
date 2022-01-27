package com.project.nadaum.board.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BoardComment implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String CommentCode;
	private String id;
	private String code; //보드 고유코드
	private String content;
	private int commentLevel;
	private String commentRef;
	private Date regDate;

}
