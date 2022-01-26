package com.project.nadaum.board.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Board implements Serializable {

	private String code;
	private String title;
	private String id;
	private String content;
	private String category;
	private int readCount;
	private Date regDate;
	
}
