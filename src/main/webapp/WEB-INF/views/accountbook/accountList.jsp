<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="가계부" name="title"/>
</jsp:include>
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
<sec:authentication property="principal" var="loginMember"/>

<table id="accountTable">
<c:forEach items="${accountList}" var = "account">
	<tr>
		<td><fmt:formatDate value="${account.regDate}" pattern="yyyy/MM/dd"/></td>
		<td rowspan="2"><fmt:formatNumber value="${account.price}" type="number"/></td>
	</tr>
	<tr>
		<td>${account.detail}</td>
		<td><button class="deleteBtn" onclick="deleteDetail('${account.code}')">[X]</button></td>
	</tr>
</c:forEach>
</table>
