<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판" name="title"/>
</jsp:include>
<style>
div, section, header, aside, footer {
     padding: 0px;
}
input#btn-add {
	float: right;
	margin: 0 0 15px;
}
div#board-container{width:400px;}
input, button, textarea {margin-bottom:15px;}
button { overflow: hidden; }
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label{text-align:left;}
</style>
<script>
function goBoardForm(){
	location.href = "${pageContext.request.contextPath}/board/boardForm.do";
}


$(() => {
	$(".card").click((e) => {
		 //console.log(e.target);
		const $card = $(e.target).parent().parent();
		const code = $card.data("code");
		location.href = `${pageContext.request.contextPath}/board/boardDetail.do?code=\${code}`;
	});
});
</script>
<body>

<div id="board-container" class="mx-auto text-center">
	<input type="text" class="form-control" 
		   placeholder="제목" name="boardTitle" id="title" 
		   value="${board.title}" required>
	<input type="text" class="form-control" 
		   name="memberId" 
		   value="${board.member.name} (${board.member.id})" readonly required>
	
	<c:forEach items="${board.attachments}" var="attach" varStatus="vs">
	<%-- 		
		<a href="${pageContext.request.contextPath}/resources/upload/board/${attach.renamedFilename}"
			role="button" 
			class="btn btn-outline-success btn-block"
			download="${attach.originalFilename}">
			첨부파일${vs.count} - ${attach.originalFilename}
		</a> 
	--%>
		<a href="${pageContext.request.contextPath}/board/fileDownload.do?no=${attach.no}"
			role="button" 
			class="btn btn-outline-success btn-block">
			첨부파일${vs.count} - ${attach.originalFilename}
		</a>
	</c:forEach>
	<a href="${pageContext.request.contextPath}/board/urlResource.do"
		role="button" 
		class="btn btn-outline-success btn-block">
		UrlResource 확인 
	</a>
	
    <textarea class="form-control mt-3" name="content" 
    		  placeholder="내용" required>${board.content}</textarea>
    <input type="number" class="form-control" name="readCount" title="조회수"
		   value="${board.readCount}" readonly>
	<input type="datetime-local" class="form-control" name="regDate" 
		   value='<fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd'T'HH:mm"/>'>
</div>

<!-- 댓글 -->
<div id="comment-container">
    <form action="${pageContext.request.contextPath}/board/insertComment.do" class="form-inline" method="post">
    	<input type="text" class="form-control col-sm-8" name="memberId" value="${loginMember.id}" readonly required>
        <input type="text" class="form-control col-sm-8" name="content" placeholder="댓글" required/>&nbsp;
        <button class="btn btn-outline-success" type="submit" >저장</button>
    </form>

    <br />
    <!-- 메모목록 -->
	<table class="table">
	    <tr>
	      <th>번호</th>
	      <th>내용</th>
	      <th>날짜</th>
	      <th>삭제</th>
	    </tr>
	    <c:forEach items="${list}" var="comment">
	    	<tr>
	    		<td>${comments.no}</td>
	    		<td>${comment.content}</td>
	    		<td><fmt:formatDate value="${comment.regDate}" pattern="yyyy/MM/dd HH:mm"/></td>
	    		<td>
	    			 <button class="btn btn-outline-danger btn-memo-delete" data-no="${comment.no}" type="button">삭제</button>
	    		</td>
	    	</tr>
	    </c:forEach>
	</table>
</div>


</body>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
  <script src="https://pingendo.com/assets/bootstrap/bootstrap-4.0.0-alpha.6.min.js"></script>
</html>