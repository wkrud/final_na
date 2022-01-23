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
<sec:authentication property="principal" var="loginMember"/>

<link href='${pageContext.request.contextPath}/resources/css/accountbook/main.css' rel='stylesheet' />
<script src='${pageContext.request.contextPath}/resources/js/accountbook/main.js'></script>
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
				<td>
					<label for="income_expense">수입</label>
					<input type="radio" name="income_expense" id="" value="I" checked/>
				</td>
				<td>
					<label for="income_expense">지출</label>
					<input type="radio" name="income_expense" id="" value="E"/>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<select name="payment" id="">
						<option value="cash" name="payment">현금</option>
						<option value="card" name="payment">카드</option>
					</select>
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
				<input type="hidden" name="id" value="${loginMember.id}" />
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</tr>
		</table>
			<input type="submit" value="제출하기" />
			<button id="closeBtn">닫기</button>
		</form>
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
		<div class="chart box">
		</div>
	</section>
	<section class="box2">
		<div class="search_box">
			<form action="">
				<h3>검색</h3>
				<select name="mainCategory" id="mainCategory">
					<option value="">대분류</option>
				</select>
				<select name="subCategory" id="subCategory">
					<option value="">소분류</option>
				</select>
				<input type="text" name="search" id="search">
				<input type="submit" value="검색">
			</form>
		</div>
		<!-- 화면만 잡고 리스트 싹 불러오기 -->
		<div class="account_list">
				<c:forEach items="${accountList}" var="account">
				<form 
					action="${pageContext.request.contextPath}/accountbook/accountDelete.do"
					method="POST"
					name="deleteFrm">
					<hr>
					<table class="account_list_table">
						<tr>
							<td rowspan="2">${account.incomeExpense}</td>
							<td colspan="2">${account.regDate}</td>
							<td rowspan=>${account.price}</td>
						</tr>		
						<tr>
							<td>${account.detail}</td>
							<td><button id="deleteBtn">삭제하기</button></td>
						</tr>
						<tr>
							<input type="hidden" name="id" value="${loginMember.id}" />
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
							<input type="hidden" name="code" value="${account.code}" />
						</tr>
					</table>
				</form>
				</c:forEach>
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
				<tr>
					<td colspan="2">2,833,000원</td>
				</tr>
				<tr>
					<td>수입</td>
					<td>지출</td>
				</tr>
				<tr>
					<td><span class="income">3,018,000</span>원</td>
					<td><span class="expense">185,000</span>원</td>
				</tr>
			</table>
		</div>
		<div class="insertForm">
			<button id="btn1"><i class="fas fa-plus plus"></i><br />거래내역 입력하기</button>
		</div>
	</section>

	
	<script>
	/* $("#closeBtn").on('click', function(){
		$(".modal-background").fadeOut();
	});
	
	$("#btn1").on('click', function(){
		$(".modal-background").fadeIn();
	}); */
	
	$(deleteBtn).click((e) => {
		$.ajax({
			url : "${pageContext.request.contextPath}/accountbook/accountDelete.do",
			
		})
	})

	</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />