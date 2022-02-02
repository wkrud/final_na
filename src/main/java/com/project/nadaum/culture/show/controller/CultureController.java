package com.project.nadaum.culture.show.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.project.nadaum.culture.comment.model.service.CommentService;
import com.project.nadaum.culture.comment.model.vo.Comment;
import com.project.nadaum.culture.show.model.service.CultureService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/culture")
public class CultureController {
	
	@Autowired
	private CultureService cultureService;
	
	@Autowired
	private CommentService commentService;

		
	 // tag값의 정보를 가져오는 메소드
		private static String getTagValue(String tag, Element eElement) {
			//
		    NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
		    Node nValue = (Node) nlList.item(0);
		    if(nValue == null) 
		        return null;
		    return nValue.getNodeValue();
		}
		
	@GetMapping("/board/{page}")
	public  ModelAndView getCultureApi(@PathVariable int page, Model model){
		
		List<Object> list = new ArrayList<>();
			try {
				
			while(true){
				// parsing할 url 지정(API 키 포함해서)
				String url = "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/period"
						+ "?serviceKey=p%2B16HHPYFEvCkanGQCoGc9CAAG7x66tc5u3xrBmJpM8avVLTGiJ%2FjJaIvItRCggk79J9k%2Byn47IjYUHr%2FdzlgA%3D%3D"
						+ "&rows=9"
						+ "&cPage="+page;
				
				DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
				DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
				Document doc = dBuilder.parse(url);
				
				// root tag 
				doc.getDocumentElement().normalize();
				//response - comMsgHeader/msgBody - perforList
				//response - comMsgHeader/msgBody - seq/perforInfo
				
				// 파싱할 tag
				NodeList nList = doc.getElementsByTagName("perforList");
				
				for(int temp = 0; temp < nList.getLength(); temp++){
					Node nNode = nList.item(temp);
					if(nNode.getNodeType() == Node.ELEMENT_NODE){
						
						Element eElement = (Element) nNode;
						System.out.println("######################");
						
//						System.out.println(eElement.getTextContent());
						String seq = getTagValue("seq", eElement);
						String title = getTagValue("title", eElement);
						String startDate = getTagValue("startDate", eElement);
						String endDate = getTagValue("endDate", eElement);
						String area = getTagValue("area", eElement);
						String place = getTagValue("place", eElement);
						String thumbnail = getTagValue("thumbnail", eElement);
						String realmName = getTagValue("realmName", eElement);
						
						Map<String, Object> map = new HashMap<>();
						map.put("seq", seq);
						map.put("title", title);
						map.put("startDate", startDate);
						map.put("endDate", endDate);
						map.put("area", area);
						map.put("place", place);
						map.put("thumbnail", thumbnail);
						map.put("realmName", realmName);
						
						list.add(map);
						
						System.out.println(list);
					}	// for end
					
				}	// if end
				model.addAttribute("list",list);
				page += 1;
				System.out.println("page number : "+page);
	
				if(page > 1){	
					break;
				}
			}	// while end
			
			} catch (Exception e){	
			e.printStackTrace();
		}	// try~catch end
			return new ModelAndView("/culture/cultureBoardList","list",list);
	}
	
	//문화 상세정보API
		@GetMapping("/board/view/{apiCode}")
		public ModelAndView getCultureDetailApi(@PathVariable String apiCode, Model model) {
			
			List<Object> list = new ArrayList<>();
				try {
					
					// parsing할 url 지정(API 키 포함해서)
					String url = "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/d/"
							+ "?serviceKey=p%2B16HHPYFEvCkanGQCoGc9CAAG7x66tc5u3xrBmJpM8avVLTGiJ%2FjJaIvItRCggk79J9k%2Byn47IjYUHr%2FdzlgA%3D%3D"
							+ "&seq="+apiCode ;
					
					DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
					DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
					Document doc = dBuilder.parse(url);
					
					  doc.getDocumentElement().normalize();
					  
					  NodeList nList = doc.getElementsByTagName("perforInfo");
					
					     Node nNode = nList.item(0);
					     if (nNode.getNodeType() == Node.ELEMENT_NODE) {
					 
					        Element eElement = (Element) nNode;
					 

					       String title = getTagValue("title", eElement);
							String startDate = getTagValue("startDate", eElement);
							String endDate = getTagValue("endDate", eElement);
							String area = getTagValue("area", eElement);
							String place = getTagValue("place", eElement);
							String placeAddr = getTagValue("placeAddr", eElement);
							String realmName = getTagValue("realmName", eElement);
							String price = getTagValue("price", eElement);
							String phone = getTagValue("phone", eElement);
							String imgUrl = getTagValue("imgUrl", eElement);
							String placeUrl = getTagValue("placeUrl", eElement);
							String contents1 = getTagValue("contents1", eElement);
							String contents2 = getTagValue("contents2", eElement);

							Map<String, Object> map = new HashMap<>();
							
							map.put("title", title);
							map.put("startDate", startDate);
							map.put("endDate", endDate);
							map.put("area", area);
							map.put("place", place);
							map.put("placeAddr", placeAddr);
							map.put("realmName", realmName);
							map.put("price", price);
							map.put("phone", phone);
							map.put("imgUrl", imgUrl);
							map.put("placeUrl", placeUrl);
							map.put("contents1", contents1);
							map.put("contents2", contents2);
							
							list.add(map);
							
					     }//if end
					     List<Comment> commentList = commentService.selectCultureCommentList(apiCode);
					     System.out.println(list);
					     model.addAttribute("list", list);
					     model.addAttribute("commentList", commentList);
				} catch (Exception e) {
					  e.printStackTrace();
			}		  
			return new ModelAndView("/culture/cultureView","list",list);
		}
		

	//============================= 좋 아 요 ==========================================
		
	@PostMapping("/board/view/{apiCode}/likes")
	public ResponseEntity<?> insertLikes(@RequestParam Map<String,Object> map){
		
		log.debug("map = {}", map);
		
		try{
			int result = cultureService.insertCultureLike(map);
			
			System.out.println(result);
			String msg = (result > 0) ? "좋아요 성공" : "좋아요 실패";	
			
			map.put("result", result);
			map.put("msg", msg);

			System.out.println(map);
				if(result == 1) {
		            return ResponseEntity.ok(map);
		        } 
		        else {
		        	return ResponseEntity.status(404).build();
		        }
		
			}catch (Exception e) {
				log.error(e.getMessage(), e);
				return ResponseEntity.badRequest().build();
			}
	}
	
	@DeleteMapping("/board/view/{apiCode}/likes")
	public ResponseEntity<?> deleteLikes(@PathVariable String apiCode){
		
		try{
			int result = cultureService.deleteCultureLike(apiCode);
			String msg = (result > 0) ? "좋아요삭제 완료" : "좋아요삭제 실패";	
			
			Map<String, Object> map = new HashMap<>();
			map.put("result", result);
			map.put("msg", msg);
			
				if(result == 1) {
		            return ResponseEntity.ok(map);
		        } 
		        else {
		        	return ResponseEntity.status(404).build();
		        }
		
			}catch (Exception e) {
				log.error(e.getMessage(), e);
				return ResponseEntity.badRequest().build();
			}
	}
}
	

