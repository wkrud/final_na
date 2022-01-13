<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원정보" name="title"/>
</jsp:include>

<div class="section">
	<!-- 왼쪽 메뉴list -->
	<div class="absolute-left">
		<ul>
			<li>
				<a href="">마이페이지</a>
				<a href=""></a>
				<a href=""></a>
				<a href=""></a>
				<a href=""></a>
			</li>
		</ul>
		<!-- 메뉴리스트 하단 작게 -->
		<div class="out">
			<a href="">회원탈퇴</a>
		</div>
	</div>
	
	<!--  -->
	
	
	
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>