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

<c:forEach items="${accountList}" var = "account">
	<div class="accountListDiv">
	<table id="accountTable">
		<tr>
			<td><fmt:formatDate value="${account.regDate}" pattern="yyyy/MM/dd"/></td>
			<td rowspan="2"><fmt:formatNumber value="${account.price}" type="number"/></td>
		</tr>
		<tr>
			<td>${account.detail}</td>
		</tr>
		</table>
		<button class="deleteBtn" onclick="deleteDetail('${account.code}')">삭제</button>
	</div>
</c:forEach>

<style>
.accountListDiv {
  width : 450px;
  height: 80px;
  background : rgba(225, 225, 225, 0.1);
/*   box-shadow: 0 25px 45px rgba(0, 0, 0, 0.1); */
  border : 1px solid rgba(225, 225, 225, 0.5);
  border-radius: 10px;
  margin : 15px auto;
  position : relative;
  }
  
 .accountListDiv:hover {
  animation-name: slide;
  animation-duration: 0.5s;
  left : -20%;
 }
 
 @keyframes slide {
  from {
    left : 0%;
  }
  to {
    left : -20%;
  }
}

.deleteBtn{
	position : absolute;
	bottom : 30px;
	right : 0;
	border : none;
	background-color : lightgray;
	width : 80px;
	height : 30px;
	border-radius : 10px;
}

</style>
