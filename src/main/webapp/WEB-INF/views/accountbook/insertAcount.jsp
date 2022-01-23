<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="가계부 입력" name="title"/>
</jsp:include>
<link href='${pageContext.request.contextPath}/resources/css/accountbook/main.css' rel='stylesheet' />
<script src='${pageContext.request.contextPath}/resources/js/accountbook/main.js'></script>

<div class="insertAccount box">
		
		
	</div>


</body>
</html>