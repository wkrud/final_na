package com.project.nadaum.board.model.dao;

import java.util.List;

import com.project.nadaum.board.model.vo.Board;
import com.project.nadaum.common.vo.Attachment;

public interface BoardDao {

	List<Board> selectBoardList();

	int insertBoard(Board board);

	int insertAttachment(Attachment attach);

	Board selectOneBoard(String code);

	List<Attachment> selectAttachmentListByBoardCode(String code);

}
