<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 관리자페이지" name="title"/>
</jsp:include>
<div class="admin-body">
	<div class="admin-announcement-header">
	
	</div>
	<div class="admin-announcement-body">
		<div class="announcement-enroll">
			<button type="button" class="btn btn-primary">공지등록</button>
		</div>
		<div class="announcement-managing">
			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>조회수</th>
						<th>등록일</th>
						<th colspan="2">관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${announceList}" var="an" varStatus="vs">
						<tr>
							<td>${vs.count}</td>
							<td>${an.title}</td>
							<td>${an.readCount}</td>
							<td>${an.regDate}</td>
							<td><button type="button" class="btn btn-warning">수정</button></td>
							<td><button type="button" class="btn btn-danger">삭제</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			${pagebar}
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />