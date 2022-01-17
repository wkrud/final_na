<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="문화" name="title"/>
</jsp:include>

<style>
div#culture-container{width:100%; margin:0 auto;text-align:center;}
.thumnail{width: 20%; }
</style>
<div id="culture-container">
    <br />
	<table class="table">
	    <tr>
	      <th>번호</th>
	      <th>제목</th>
	      <th>시작일</th>
	      <th>종료일</th>
	      <th>지역</th>
	      <th>장소</th>
	      <th>장르</th>
	      <th>썸네일</th>
	    </tr>
	    <c:forEach items="${list}" var="culture">
	    	<tr>
	    		<td>${culture.code}</td>
	    		<td>${culture.title}</td>
	    		<td><fmt:formatDate value="${culture.startDate}" pattern="yyyy/MM/dd"/></td>
	    		<td><fmt:formatDate value="${culture.endDate}" pattern="yyyy/MM/dd"/></td>
	    		<td>${culture.area}</td>
	    		<td>${culture.place}</td>
	    		<td>${culture.realmName}</td>
	    		<td><img class="thumnail" src="${culture.imgUrl}" alt="" /></td>
	    </c:forEach>
	</table>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
