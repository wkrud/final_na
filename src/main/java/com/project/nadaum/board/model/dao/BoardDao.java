package com.project.nadaum.board.model.dao;

import java.util.List;
import java.util.Map;

import com.project.nadaum.board.model.vo.Board;

public interface BoardDao {

	List<Board> selectBoardList();

//	int insertBoard(Board board);
//	int insertAttachment(Attachment attach);

//	Board selectOneBoard(String code);
//	List<Attachment> selectAttachmentListByBoardCode(String code);

	int insertBoard(Map<String, Object> map);

}
