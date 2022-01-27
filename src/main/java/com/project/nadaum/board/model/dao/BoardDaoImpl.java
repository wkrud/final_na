package com.project.nadaum.board.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.board.model.vo.Board;

@Repository
public class BoardDaoImpl implements BoardDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Board> selectBoardList() {
		
		return session.selectList("board.selectBoardList");
	}

//	@Override
//	public int insertBoard(Board board) {
//		return session.insert("board.insertBoard", board);
//	}
	
//	@Override
//	public int insertAttachment(Attachment attach) {
//		return session.insert("board.insertAttachment", attach);
//	}
	
	//게시물한건조회
//	@Override
//	public Board selectOneBoard(String code) {
//		return session.selectOne("board.selectOneBoard", code);
//	}
//
//	//여러건조회
//	@Override
//	public List<Attachment> selectAttachmentListByBoardCode(String code) {
//		return session.selectList("board.selectAttachmentListByBoardCode", code);
//	}

	@Override
	public int insertBoard(Map<String, Object> map) {
		return session.insert("board.insertBoard", map);
	}
	
}
