package com.project.nadaum.board.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString(callSuper=true)
@NoArgsConstructor
public class Board extends BoardEntity implements Serializable {/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int commentCount;

	public Board(String code, String title, String id, String content, String category, int readCount, Date regDate,
			int commentCount) {
		super(code, title, id, content, category, readCount, regDate);
		this.commentCount = commentCount;
	}
	
	
	
	
	
}
