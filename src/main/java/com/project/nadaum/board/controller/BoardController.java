package com.project.nadaum.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;
import com.project.nadaum.board.model.service.BoardService;
import com.project.nadaum.board.model.vo.Board;
import com.project.nadaum.common.NadaumUtils;
import com.project.nadaum.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private ServletContext application;
	
	
	

	
//	@GetMapping("/boardDetail.do")
//	public void boardDetail(@RequestParam String code, Model model) {
//		Board board = boardService.selectOneBoard(code);
//		log.debug("board ={}", board);
//		model.addAttribute("board", board);
//	}
	
	
	@GetMapping("/boardList.do")
	public void boardList(Model model) {
		
		//리스트 보여주기
				List<Board> list = boardService.selectBoardList();
				log.debug("(boardList) list = {}", list);
				
				model.addAttribute("list", list);
	}
	
	
	// 썸머노트 게시물 등록
	@GetMapping("/boardEnroll.do")
	public void boardEnroll() {}
	
	@PostMapping("/boardEnroll.do")
	public String boardEnroll(
		@AuthenticationPrincipal Member member, 
		@RequestParam Map<String, Object> map) {
		
		map.put("id", member.getId());
		log.debug("map = {}", map);
		
		int result = boardService.insertBoard(map);
		return "redirect:/board/boardList.do";
	}
	
	@RequestMapping(value="/uploadSummernoteImageFile.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(
			@RequestParam("file") MultipartFile file, 
			HttpServletRequest request )  {
		
			JsonObject jsonObject = new JsonObject();
			
			String fileRoot = application.getRealPath("/resources/upload/board/img/");
			log.debug("fileRoot = {}", fileRoot);
			String originalFileName = file.getOriginalFilename();
			String renamedFileName = NadaumUtils.rename(originalFileName);
			
			File targetFile = new File(fileRoot, renamedFileName);	
			try {
				file.transferTo(targetFile);
			} catch (IllegalStateException | IOException e) {
				log.error(e.getMessage(), e);
			}
			
			jsonObject.addProperty("url", "/nadaum/resources/upload/board/img/" + renamedFileName);
			jsonObject.addProperty("responseCode", "success");
			log.debug("root = {}", jsonObject.toString());
		
		return jsonObject.toString();
	}
	
	@PostMapping(value="/deleteSummernoteImageFile.do")
	public ResponseEntity<?> deleteSummernoteImageFile(@RequestParam Map<String, Object> map)  {
		log.debug("map = {}", map);
		
			String fileRoot = application.getRealPath("/resources/upload/board/img");
			String url = (String) map.get("val");
			String[] strs = url.split("/");
			String filename = strs[strs.length - 1];
			
			String lastDest = url.substring(url.length() - 26, url.length());
			String allDest = fileRoot + lastDest;
			
			File img = new File(allDest);
			img.delete();
		
		return ResponseEntity.ok(1);
	}
	
}
