package com.project.nadaum.culture.show.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.culture.show.model.vo.Culture;

@Repository
public class BoardDaoImpl implements BoardDao {

	@Autowired
	private SqlSessionTemplate session;
	

	@Override
	public int selectTotalContent() {
		return session.selectOne("board.selectTotalContent");
	}

	@Override
	public Culture selectOneBoard(int no) {
		return session.selectOne("board.selectOneBoard", no);
	}

}
