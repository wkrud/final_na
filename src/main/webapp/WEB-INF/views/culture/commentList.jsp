<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>댓글</h1>
	<div class="insert-comment">
		<form action="/culture/insertComment.do" method="POST" name="insert-comment">
			<input type="hidden" name="boardNo" value="${apiCode}" />
            <input type="hidden" name="writer" value="${id}" />
            <input type="hidden" name="commentLevel" value="1" />
            <input type="hidden" name="commentRef" value="0" />    
			<textarea name="content" cols="60" rows="3"></textarea>
            <button type="submit" class="btn btn-light">등록</button>
		</form>
	
	</div>
	<table id="comment-table">
	 <c:forEach var="comment" items="${list}">
		<tr class="level1">
			<td>
				<sub class="comment-writer">${comment.id}</sub>
				<sub class="comment-date">
				<fmt:formatDate value="${comment.regDate}" pattern="yyyy/MM/dd"/>
				</sub>
				<sub class="star">${comment.star}</sub>
				<br />
				${comment.content}
			
			</td>		
		</tr>
		</c:forEach>
		</table>
</body>
</html>