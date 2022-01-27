package com.project.nadaum.board.model.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.project.nadaum.common.vo.Attachment;
import com.project.nadaum.member.model.vo.Member;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString(callSuper=true)
@NoArgsConstructor
public class Board extends BoardEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private List<Attachment> attachments;
	private Member member;
	
	public Board(String code, String title, String id, String content, String category, int readCount, Date regDate,
			List<Attachment> attachments, Member member) {
		super(code, title, id, content, category, readCount, regDate);
		this.attachments = attachments;
		this.member = member;
	}
	
	
	
}
