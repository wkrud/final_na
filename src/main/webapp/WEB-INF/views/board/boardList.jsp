<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
tr[data-value] {cursor: pointer;}
</style>
<script>
function goBoardForm(){
	location.href = "${pageContext.request.contextPath}/board/boardEnroll.do";
}


$(() => {
	$("tr[data-value]").click((e) => {
		// console.log(e.target); // td
		const $tr = $(e.target).parent();
		const code = $tr.data("code").val();
		console.log("$tr");
		console.log("code");
		location.href = `${pageContext.request.contextPath}/board/boardDetail.do?code=\${code}`;
	});
});
</script>
<body>
<section id="board-container" class="container">
	<input 
		type="button" value="글쓰기" id="btn-add" class="btn btn-outline-success" onclick="goBoardForm();"/>
	<input type="hidden" name="id" id="id" value="${loginMember.id}" />
	<sec:authentication property="principal" var="loginMember"/>
	<table id="tbl-board" class="table table-striped table-hover">
		<tr >
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>내용</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<c:forEach items="${list}" var="board">

			<tr data-value="${board.code}" >
				<input type="hidden" value="${board.code}" class="board-code" name="code"/>
				<td>${board.code}</td>
				<td class="board-title">${board.title}</td>
				<td>${board.id}</td>
				<td>${board.content}</td>
				<td><fmt:formatDate value="${board.regDate}" pattern="yy/MM/dd HH:mm"/> </td>
				<td>${board.readCount}</td>
			</tr>

		</c:forEach>
	</table>
	
	${pagebar}
</section> 
</body>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
  <script src="https://pingendo.com/assets/bootstrap/bootstrap-4.0.0-alpha.6.min.js"></script>
</html>