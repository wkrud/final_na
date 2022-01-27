package com.project.nadaum.board.model.service;

import java.util.List;

import com.project.nadaum.board.model.vo.Board;
import com.project.nadaum.common.vo.Attachment;

public interface BoardService {

	List<Board> selectBoardList();

	//게시판 등록
	int insertBoard(Board board);
	int insertAttachment(Attachment attach);

	Board selectOneBoard(String code);

}
