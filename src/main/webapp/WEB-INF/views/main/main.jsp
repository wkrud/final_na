<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<link href='${pageContext.request.contextPath}/resources/css/main/main.css' rel='stylesheet' />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움" name="title"/>
</jsp:include>
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
<sec:authentication property="principal" var="loginMember"/>

<div class="wrapper">
	<div class="modal-background">
	<div class="insertTodoList">
		<form 
			action="${pageContext.request.contextPath}/main/insertTodoList.do"
			method="POST">
			<table>
				<tr>
					<th><input type="text" name="title" id="" placeholder="투두리스트 제목" /></th>
				</tr>
				<tr>
					<td><input type="text" name="content" id="" placeholder="일정 추가" /></td>
				</tr>
			</table>
			<input type="submit" class="defaultBtn addAccountBtn" value="등록" />
			<input type="hidden" name="id" id="id" value="${loginMember.id}" />
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		</form>
	</div>
	</div>
	<section class="m_center">
        <button>투두리스트 추가</button>
        <div class="todoList">
        	<table>
        		<tr>
        			<th>Today</th>
        		</tr>
        		<tr>
        			<td>Thu Feb 3 2022</td>
        		</tr>
        		<tr>
        			<td>
	        			<input type="checkbox" name="" id="test" />
	        			<label for="test">나다움 모임</label>
        			</td>
        		</tr>
        		<tr>
        			<td>
	        			<input type="checkbox" name="" id="test2" />
	        			<label for="test2">파이널...킵고잉...</label>
        			</td>
        		</tr>
        		<tr>
        			<td>
        			<input type="text" name="" id="" placeholder="+일정 추가하기" />
        			</td>
        		</tr>
        	</table>
		</div>
      </section>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />