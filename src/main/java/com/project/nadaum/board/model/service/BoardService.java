package com.project.nadaum.board.model.service;

import java.util.List;
import java.util.Map;

import com.project.nadaum.board.model.vo.Board;
import com.project.nadaum.board.model.vo.BoardComment;
import com.project.nadaum.board.model.vo.BoardEntity;

public interface BoardService {

	//게시판 목록
	List<Board> selectBoardList(Map<String, Object> param);

	//pagebar
	int selectTotalContent();
	
	
	//게시판 등록
//	int insertBoard(Board board);
//	int insertAttachment(Attachment attach);
	int insertBoard(Map<String, Object> map);

	int updateBoard(Board board);

	int deleteBoard(String code);

	Board selectOneBoard(String code);

	Board selectOneBoardCollection(String code);
	
	//조회수
	int updateBoardReadCount(String code);

	//댓글
	List<BoardComment> selectBoardCommentList(String code);

	int insertBoareComment(BoardComment bc);

	int boardCommentDelete(String commentCode);





}
