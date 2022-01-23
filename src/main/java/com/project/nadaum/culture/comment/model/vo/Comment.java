package com.project.nadaum.culture.comment.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Comment implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int commentNo;
	private int commentLevel;
	private String conent;
	private Date regDate;
	private int commentRef;
	private String code;
}
