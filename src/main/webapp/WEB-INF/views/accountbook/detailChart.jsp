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

<div class=wrapper>
	<div class="box yearly_total">
		<div>${loginMember.name}님의 연간 총 거래내역 : <span></span>건</div>
		<div>누적 거래 금액</div>
	</div>
	<div class="yearly_income">
		${loginMember.name}님의 연간 총 수입
	</div>
	<div class="yearly_expense">
		${loginMember.name}님의 연간 총 지출
	</div>
	<div id="yearly_chart">
	</div>
</div>
<input type="hidden" id="contextPath" value="${pageContext.request.contextPath}" />
<script src='${pageContext.request.contextPath}/resources/js/accountbook/chart.js'></script>