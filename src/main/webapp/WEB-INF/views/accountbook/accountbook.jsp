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

<link href='${pageContext.request.contextPath}/resources/css/accountbook/main.css' rel='stylesheet' />
<link href='https://use.fontawesome.com/releases/v5.0.6/css/all.css' rel='stylesheet'>

	<div class="modal-background">
	<div class="insertAccountModal">
		<h2>가계부 테스트</h2>
		<form 
			name="insertFrm" 
			method="POST"
			action="${pageContext.request.contextPath}/accountbook/accountInsert.do">
		<table>
			<tr>
				<td colspan="2">
					<input type="date" name="reg_date" id="reg_date" />
				</td>
			</tr>	
			<tr>
				<div class="btn-group btn-group-toggle" id="radio_btn" data-toggle="buttons">
					<label class="btn btn-success" id="income_box">
						<input type="radio" name="payment" id="jb-radio-1" value="cash"> 현금
					</label>
					<label class="btn btn-danger" id="expense_box">
						<input type="radio" name="payment" id="jb-radio-2" value="card"> 카드
					</label>
				</div>
			</tr>
			<tr>
				<td colspan="">
					
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<label for="detail">내역</label>
					<input type="text" name="detail" id="" placeholder="내역을 입력하세요." value="용돈" />
				</td>
			</tr>
			<tr>
				<td colspan="2"> 
					<label for="price">금액</label>
					<input type="text" name="price" id="" placeholder="금액을 입력하세요" value="300000" />
				</td>
			</tr>
			<tr>
				<input type="hidden" name="id" id="id" value="${loginMember.id}" />
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</tr>
		</table>
			<input type="submit" value="제출하기" />
		</form>
			<button id="closeBtn">닫기</button>
	</div>
	</div>

	<section class="box1">
		<div class="account_tip">
			<h3>1월의 소비 목표 : 500,000</h3>
			<p>목표로 설정한 소비 금액 진행률에 따른 멘트 변화
			<br>예시 : 건강한 소비 패턴을 지니고 계시군요! 이대로 목표 달성까지!
			<br>목표로 설정한 금액의 50%를 소비하셨어요! 성공을 위해서 남은 기간 절대 존버해
			<br>아무튼... 이런 랜덤 멘트...
		</div>

	</section>
	<section class="box2">
		<div class="search_box">
			<form 
				action=""
				id="serchFrm">
				<h3>검색</h3>
				<select name="income_expense" id="mainCategory">
					<option value="" selected>대분류</option>
					<option value="I">수입</option>
					<option value="E">지출</option>
				</select>
				<select name="category" id="subCategory">
					<option value="">소분류</option>
				</select>
				<input type="text" name="detail" id="search">
				<input type="submit" value="검색">
			</form>
		</div>

		<div id="account_list">
		
		</div>
	</section>
	<section class="box3">
		<div class="account">
			<table class="account-info">
				<tr>
					<td colspan="2">${loginMember.name}님의</td>
				</tr>
				<tr>
					<td colspan="2">1월 총 자산</td>
				</tr>
				<tr id="total_income">
				</tr>
				<tr>
					<td>수입</td>
					<td>지출</td>
				</tr>
				<tr class="user_income_expense">
				</tr>
			</table>
		</div>
		<div class="insertForm">
			<button id="btn1"><i class="fas fa-plus plus"></i><br />거래내역 입력하기</button>
		</div>
	</section>

<script src='${pageContext.request.contextPath}/resources/js/accountbook/main.js'></script>
<script>

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />