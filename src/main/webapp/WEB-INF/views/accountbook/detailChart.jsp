<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="가계부 차트" name="title"/>
</jsp:include>
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
<sec:authentication property="principal" var="loginMember"/>
<link href='${pageContext.request.contextPath}/resources/css/accountbook/chart.css' rel='stylesheet' />
<link href='https://use.fontawesome.com/releases/v5.0.6/css/all.css' rel='stylesheet'>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>

<%
	Date date = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 M월");
	SimpleDateFormat sdf2 = new SimpleDateFormat("M월");
	String today = sdf.format(date);
	String today_m = sdf2.format(date);
%>

<div class=wrapper>
	<div class="box yearly_total">
		<button type="button" onclick='count("minus")'>지난달 테스트</button>
		<c:forEach items="${countList}" var="list" >
		<div><p>${loginMember.name}님의 <%= today %> 총 거래내역 : <span>${list.count}</span>건</p></div>
		<div><p>누적 거래 금액 : <span><fmt:formatNumber value="${list.sum}" type="number"/></span>원</p></div>
		</c:forEach>
		<button type="button" onclick='count("plus")'>담달 테스트</button>
	</div>
	<div id="yearly_chart" class="box">
	</div>
	<div class="category-chart category-income box"></div>
	<div class="category-chart category-expense box"></div>
</div>
<input type="hidden" id="contextPath" value="${pageContext.request.contextPath}" />
<script src='${pageContext.request.contextPath}/resources/js/accountbook/chart.js'></script>