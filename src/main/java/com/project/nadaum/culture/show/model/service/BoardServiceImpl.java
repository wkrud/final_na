package com.project.nadaum.culture.show.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.nadaum.culture.show.model.dao.BoardDao;
import com.project.nadaum.culture.show.model.vo.Culture;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;
	
	@Override
	public int selectTotalContent() {
		return boardDao.selectTotalContent();
	}
	
	@Override
	public Culture selectOneBoard(int no) {
		// 1.board테이블 조회
		Culture board = boardDao.selectOneBoard(no);
		
		return board;
	}

	

}
