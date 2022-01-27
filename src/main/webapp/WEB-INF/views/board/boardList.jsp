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

<%-- <div class="container">
      <div class="row" style = "display : flex; flex-wrap : wrap;">
      <c:forEach var="board" items="${list}">
        <div class = "col-md-4 col-sm-6 card">
          <div class = "thumbnail">
            <img src = "https://images.unsplash.com/photo-1434725039720-aaad6dd32dfe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=1561ecb2592830316c279b62f1cb75e5&w=1000&q=80">
            <div class = "caption">
              <h3>${board.title}</h3>
              <span>${board.code}</span>
              <span>${board.category}</span>
              <span>${board.readCount}</span>
              <p>
              	<fmt:formatDate value="${board.regDate}" pattern="yyyy/MM/dd"/>
              </p>
          </div>
        </div>
        </div>
 		</c:forEach>
       
  </div>
</div> --%>

<section id="board-container" class="container">
	<input 
		type="button" value="글쓰기" id="btn-add" class="btn btn-outline-success" 
		onclick="goBoardForm();"/>
	<input type="hidden" name="id" id="id" value="${loginMember.id}" />
	<sec:authentication property="principal" var="loginMember"/>
	<table id="tbl-board" class="table table-striped table-hover">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>첨부파일</th> <!-- 첨부파일 있을 경우, /resources/images/file.png 표시 width: 16px-->
			<th>조회수</th>
		</tr>
		<c:forEach items="${list}" var="board">
			<tr class="card">
				<td>${board.code}</td>
				<td>${board.title}</td>
				<td>${board.memberId}</td>
				<td><fmt:formatDate value="${board.regDate}" pattern="yy/MM/dd HH:mm"/> </td>
				<td>
					<c:if test="${board.attachCount gt 0}">
						<img src="${pageContext.request.contextPath}/resources/images/file.png" alt="" width="16" />
					</c:if>
				</td>
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