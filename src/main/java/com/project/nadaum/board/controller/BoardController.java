package com.project.nadaum.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.nadaum.board.model.service.BoardService;
import com.project.nadaum.board.model.vo.Board;
import com.project.nadaum.common.NadaumUtils;
import com.project.nadaum.common.vo.Attachment;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private ServletContext application;
	
	
	
	@GetMapping("/boardForm.do")
	public void boardForm() {}
	
	@GetMapping("/boardDetail.do")
	public void boardDetail(@RequestParam String code, Model model) {
		Board board = boardService.selectOneBoard(code);
		log.debug("board ={}", board);
		model.addAttribute("board", board);
	}
	
	@PostMapping("/boardEnroll.do")
	public String boardEnroll(
			Board board, 
			@RequestParam(name="upFile", required=false) MultipartFile[] upFiles, 
			RedirectAttributes redirectAttr) throws IllegalStateException, IOException {
		
	String saveDirectory = application.getRealPath("/resources/upload/board");
		
		List<Attachment> attachments = new ArrayList<>();
		
		// 1. 첨부파일을 서버컴퓨터 저장 : rename 
		// 2. 저장된 파일의 정보 -> Attachment객체 -> attachment insert
		for(int i = 0; i < upFiles.length; i++) {
			MultipartFile upFile = upFiles[i];
			if(!upFile.isEmpty()) {
				// 1. 저장경로 | renamedFilename
				String originalFilename = upFile.getOriginalFilename();
				String renamedFilename = NadaumUtils.rename(originalFilename);
				File dest = new File(saveDirectory, renamedFilename);
				upFile.transferTo(dest);
				
				// 2
				Attachment attach = new Attachment();
				attach.setOriginalFilename(originalFilename);
				attach.setRenamedFilename(renamedFilename);
				attachments.add(attach);
			}
		}

		if(!attachments.isEmpty())
			board.setAttachments(attachments);
		log.debug("board = {}", board);
		
		int result = boardService.insertBoard(board);
		String msg = "게시물 등록 성공!";
		redirectAttr.addFlashAttribute("msg", msg);
		
		return "redirect:/board/boardList.do";
	}
	
	@GetMapping("/boardList.do")
	public void boardList(Model model) {
		
		//리스트 보여주기
				List<Board> list = boardService.selectBoardList();
				log.debug("list = {}", list);
				
				model.addAttribute("list", list);
	}
}
