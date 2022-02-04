<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판" name="title" />
</jsp:include>
<style>
input#btn-add {
	float: right;
	margin: 0 0 15px;
}

.board-title {
	cursor: pointer;
}

#board-container {
	position: absolute;
	left: 400px;
	top: 100px;
	width : 3500px;
}


 a:link { color: black; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
 a:hover { color: blue; text-decoration: none;}

출처: https://it77.tistory.com/126 [시원한물냉의 사람사는 이야기]
</style>
<script>
function goBoardForm(){
	location.href = "${pageContext.request.contextPath}/board/boardEnroll.do";
}


$(() => {
	$(".board-title").click((e) => {
		console.log(e.target); // td
		const $tr = $(e.target).parent();
		console.log($tr);
		const code = ($tr).val();
		console.log(code);
		location.href = `${pageContext.request.contextPath}/board/boardDetail.do?code=\${code}`;
	
	});
});
</script>
<body>
	<section id="board-container" class="container">
	
			<table id="tbl-board" class="table table-striped table-hover">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>내용</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			<c:forEach items="${list}" var="board">
				<tr value="${board.code}">
					<td class="boardCode">${board.code}</td>
					<td>
						<a href="${pageContext.request.contextPath}/board/boardDetail.do?code=${board.code}">${board.title} </a>
						<%-- <c:if test="${board.commentCount gt 0 ? board.commentCount : ""}"></c:if>  --%>
					</td>
					<td>${board.id}</td>
					<td>${board.content}</td>
					<td><fmt:formatDate value="${board.regDate}" pattern="yy/MM/dd HH:mm" /></td>
					<td>${board.readCount}</td>
				</tr>
			</c:forEach>
			</table>
			<input type="hidden" name="id" id="id" value="${loginMember.id}" />
			<sec:authentication property="principal" var="loginMember" />
			<input type="button" value="글쓰기" id="btn-add"	class="btn btn-outline-success" onclick="goBoardForm();" /> 
		
		${pagebar}
	</section>
</body>
<script>

</script>
<%-- <jsp:include page="/WEB-INF/views/common/footer.jsp"/> --%>