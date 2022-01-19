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

<link href='${pageContext.request.contextPath}/resources/css/accountbook/main.css' rel='stylesheet' />

<div class="wrap_box">
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
				<select name="" id="">
					<option value="">대분류</option>
					<option value="income">수입</option>
					<option value="expense">지출</option>
				</select>
				<select name="" id="">
					<option value="">소분류</option>
					<option value="">급여</option>
					<option value="">용돈</option>
					<option value="">기타</option>
					<option value="">-------</option>
					<option value="">생활비</option>
					<option value="">식비</option>
					<option value="">쇼핑</option>
					<option value="">저축</option>
					<option value="">유흥</option>
					<option value="">자기계발</option>
					<option value="">기타</option>
				</select>
				<input type="text" name="search" id="search">
				<input type="submit" value="검색">
			</form>
		</div>
		<!-- 화면만 잡고 리스트 싹 불러오기 -->
		<div class="account_list">
			<table class="account_list_table">
			<hr>
				<tr>
					<td rowspan="2">용돈</td>
					<td colspan="2">2022-01-17</td>
					<td rowspan="2" class="income">+18,000</td>
				</tr>
				<tr>
					<td>용돈 받았음</td>
				</tr>
			</table>
			<hr>
			<table class="account_list_table">
				<tr>
					<td rowspan="2">식비</td>
					<td colspan="2">2022-01-15</td>
					<td rowspan="2" class="expense">-20,000</td>
				</tr>
				<tr>
					<td>배달 음식</td>
				</tr>
			</table>
			<hr>
			<table class="account_list_table">
				<tr>
					<td rowspan="2">생활비</td>
					<td colspan="2">2022-01-13</td>
					<td rowspan="2" class="expense">-66,000</td>
				</tr>
				<tr>
					<td>교통비</td>
				</tr>
			</table>
			<hr>
			<table class="account_list_table">
				<tr>
					<td rowspan="2">급여</td>
					<td colspan="2">2022-01-10</td>
					<td rowspan="2" class="income">+3,000,000</td>
				</tr>
				<tr>
					<td>월급</td>
				</tr>
			</table>
			<hr>
			<table class="account_list_table">
				<tr>
					<td rowspan="2">쇼핑</td>
					<td colspan="2">2022-01-04</td>
					<td rowspan="2" class="expense">-99,000</td>
				</tr>
				<tr>
					<td>신발</td>
				</tr>
			</table>
			<hr>
		</div>
	</section>
	<section class="box3">
		<div class="account">
			<table class="account-info">
				<tr>
					<td colspan="2">ㅇㅇ님의</td>
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
			<form action="insertForm" method="">
				<p>거래내역 추가하기<br>누르면 모달로 입력</p>
			</form>
		</div>
	</section>
</div>




<jsp:include page="/WEB-INF/views/common/footer.jsp" />