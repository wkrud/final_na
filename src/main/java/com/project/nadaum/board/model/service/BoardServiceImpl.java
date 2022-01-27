package com.project.nadaum.board.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.nadaum.board.model.dao.BoardDao;
import com.project.nadaum.board.model.vo.Board;
import com.project.nadaum.common.vo.Attachment;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;

	@Override
	public List<Board> selectBoardList() {
		return boardDao.selectBoardList();
	}

	//게시물 등록
//	@Transactional(
//		propagation=Propagation.REQUIRED,
//		isolation = Isolation.READ_COMMITTED,
//		rollbackFor = Exception.class
//			)
	@Override
	public int insertBoard(Board board) {
		int result = boardDao.insertBoard(board); //boardEntity에 있는 보드정보들은 board테이블에 들어감. 
		log.debug("boardCode = {}", board.getCode());
		List<Attachment> attachments = board.getAttachments();
		if(attachments != null) { //attachments가 null이 아니라면 반복문을 통해 insert
			for(Attachment attach : attachments) {
				// fk컬럼 boardNo값 설정
		//list에서 첨부파일을 하나씩 꺼낸다음에 insertattachment 메소드를 호출함. 즉 첨부파일있는 개수만큼 insertattachment 메소드를 호출할꺼임.
				//즉 한건 씩 처리가 됨.
				attach.setCode(board.getCode());
				result = insertAttachment(attach);
			}
		}
		
		return result;  //정수하나를 돌려줘야하기 때문에 result return
	}

	//게시물의 파일첨부건 등록
//	@Transactional(rollbackFor = Exception.class)
	public int insertAttachment(Attachment attach) {
		return boardDao.insertAttachment(attach);
	}

	//게시물 상세보기
	@Override
	public Board selectOneBoard(String code) {
		Board board = boardDao.selectOneBoard(code);
		
		List<Attachment> attachments = boardDao.selectAttachmentListByBoardCode(code);
		
		board.setAttachments(attachments);
		
		return board;
	}
	
	
}
