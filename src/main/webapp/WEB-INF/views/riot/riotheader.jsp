<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Dev등록" name="title"/>
</jsp:include>
<h2>찾은사람의 정보는?</h2>
<input type="text" id="findsummer"/> <button type="button" id="findsummer-btn">전적검색</button>
 


<p>${summoner.name}</p>
<img alt="아이콘" src=${ imgURL}>


<script>
$(document).ready(function () {
	$('#findsummer-btn').click(function() {
		$.ajax({
			
			type: "GET",
			url: "${pageContext.request.contextPath}/riot/riotmain.do",
			data: {
					 "title" : $('#findsummer').val()},
					 success : function() {
						alert('성공');
						//location.reload();
						//window.location.href = "${pageContext.request.contextPath}/riot/riotmain.do";
						 
					 }, error: function() {
						 alert('실패');
					 }
				
				
					 
			});
			
			
	
		});

	});
	



</script>

