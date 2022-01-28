package com.project.nadaum.board.model.service;

import java.util.List;
import java.util.Map;

import com.project.nadaum.board.model.vo.Board;
import com.project.nadaum.board.model.vo.BoardComment;
import com.project.nadaum.board.model.vo.BoardEntity;

public interface BoardService {

	List<BoardEntity> selectBoardList();

	//게시판 등록
//	int insertBoard(Board board);
//	int insertAttachment(Attachment attach);

//	Board selectOneBoard(String code);

	int insertBoard(Map<String, Object> map);

	Board selectOneBoardCollection(String code);

	List<BoardComment> selectBoardCommentList(String code);

}
