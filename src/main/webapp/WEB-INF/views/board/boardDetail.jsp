<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판상세보기" name="title"/>
</jsp:include>
<style>
div#board-container{width:400px;}
input, button, textarea {margin-bottom:15px;}
button { overflow: hidden; }
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label{text-align:left;}
</style>

<!-- 게시글 상세보기 -->
<div id="board-container" class="mx-auto text-center">
	<input type="text" class="form-control" placeholder="제목" name="boardTitle" id="title" value="${board.title}" required>
	<input type="text" class="form-control" name="id" value="${board.id}" readonly required>
	
    <textarea class="form-control mt-3" name="content" placeholder="내용" required><c:out value="${board.content}" /></textarea>
    <input type="number" class="form-control" name="readCount" title="조회수" value="${board.readCount}" readonly>
	<input type="datetime-local" class="form-control" name="regDate" value='<fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd'T'HH:mm"/>'>
</div>
	
		<tr>
			<%-- 작성자와 관리자만 마지막행 수정/삭제버튼이 보일수 있게 할 것 --%>
			<th colspan="2">
				<input type="button" value="수정하기" onclick="updateBoard()">
				<input type="button" value="삭제하기" onclick="deleteBoard()">
			</th>
		</tr>
		
	<hr style="margin-top:30px;" />	
	
	<!-- 댓글 -->
    <div class="comment-container">
        <div class="comment-editor">
            <form 
            	action="${request.getContextPath()}/board/boardCommentEnroll" 
            	method="post" 
            	name="boardCommentFrm">
                <input type="hidden" name="code" value="${board.code}" /> <!-- 현재게시글 코드 -->
                <input type="hidden" name="id" id="id" value="${loginMember.id}" />
                <input type="hidden" name="writer" value="${comment.id}" />
                <input type="hidden" name="commentLevel" value="1" /> <!-- 댓글인 경우 1 -->
                <input type="hidden" name="commentRef" value="0" /> <!-- 대댓글인 경우 써여져야함 -->   
				<textarea name="content" cols="60" rows="3"></textarea>
                <button type="submit" id="btn-comment-enroll1">등록</button>
            </form>
        </div>
      
      <!-- 댓글이 하나가 되었다면 if구문으로 들어올꺼임 for문 돌면서 level1, ldecel2 태그를 고르고 출력-->
      <c:if test="${commentList != null && !empty commentList} }">  
        <!-- table#tbl-comment -->
        <table id="tbl-comment">
      <c:forEach items="${commentList }" var="comment">  
      	<c:choose>
      	<c:when test="${comment.commentLivel eq 1 }">
        	<tr class="level1">
        		<td>
        			<sub class="comment-writer">${comment.id}</sub>
        			<sub class="comment-date">%{comment.regDate}</sub>
        			<br />
        			<!-- 댓글내용 -->
        			${comment.content}
        		</td>
        		<td>
        			<button class="btn-reply" value="${comment.code }">답글</button>
        		</td>
        	</tr>
        	</c:when>
        	<c:otherwise>	
        	<tr class="level2">
        		<td>
        			<tr class="level1">
        		<td>
        			<sub class="comment-writer">${comment.id}</sub>
        			<sub class="comment-date">%{comment.regDate}</sub>
        			<br />
        			<!-- 댓글내용 -->
        			${comment.content}
        			<!-- e댓글내용 -->
        		</td>
        		<td></td>
        	</tr>
        	</c:otherwise>
        	</c:choose>
       </c:forEach>
        </table>
        </c:if>
	</div>

</body>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
  <script src="https://pingendo.com/assets/bootstrap/bootstrap-4.0.0-alpha.6.min.js"></script>
</html>