<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="가계부" name="title"/>
</jsp:include>
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
<sec:authentication property="principal" var="loginMember"/>
<link href='${pageContext.request.contextPath}/resources/css/accountbook/main.css' rel='stylesheet' />
<link href='https://use.fontawesome.com/releases/v5.0.6/css/all.css' rel='stylesheet'>

<div class="wrapper">
<section class="search_list_section">
		<!-- 검색창 -->
		<div class="search_box">
			<form 
				action="${pageContext.request.contextPath}/accountbook/searchList.do"
				method="POST"
				name = "searchFrm"
				id="searchFrm">
				<select name="incomeExpense" id="mainCategory">
					<option value="" selected>대분류</option>
					<option value="I">수입</option>
					<option value="E">지출</option>
				</select>
				<select name="category" id="subCategory">
					<option value="">소분류</option>
				</select>
				<input type="text" name="detail" id="search"/>
				<input type="hidden" name="id" value="${loginMember.id}" />
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<!-- <input type="button" id="searchBtn" value="검색" /> -->
 				<button id="searchBtn" class="defaultBtn"><i class="fas fa-search"></i></button>
			</form>
		</div>
		<!-- 필터링 -->
		<div class="fillterSection">
			<button id="AllListBtn" class="FilterBtn defaultBtn" onclick="getList()">전체보기</button>
			<button class="FilterBtn defaultBtn" id="incomeFilterBtn" onclick="getList(I)">수입</button>
			<button class="FilterBtn defaultBtn" id="expenseFilterBtn" onclick="getList(E)">지출</button>
			<a href="${pageContext.request.contextPath}/accountbook/excel">엑셀 다운로드</a>
		</div>
<c:forEach items="${accountList}" var = "account">
	<div class="accountListDiv">
	<table class="accountTable">
		<tr class="account_side_column">
			<td><span class="accountRegDate"><fmt:formatDate value="${account.regDate}" pattern="yyyy/MM/dd"/></span></td>
			<td rowspan="2" class="accountPrice">
				<c:choose>
					<c:when test="${account.incomeExpense eq 'I' }">
						<span class="income"><fmt:formatNumber value="${account.price}" type="number"/></span>
					</c:when>
					<c:when test="${account.incomeExpense eq 'E' }">
						<span class="expense"><fmt:formatNumber value="-${account.price}" type="number"/></span>
					</c:when>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td class="accountDetail">${account.detail}</td>
		</tr>
		</table>
	</div>
	<div class="accountUpdate">
		<button class="deleteBtn" onclick="deleteDetail('${account.code}')">삭제</button>
	</div>
</c:forEach>
</section>
</div>

<script>
//대분류 선택에 따른 소분류 출력 - 검색
$("#mainCategory").change(function() {
	const $mainCategory = $("#mainCategory").val();

	$('#subCategory').empty();
	$('#subCategory').append(`<option value="">카테고리</option>`);

	if($mainCategory == "I") {
		for (let i = 0; i < income.length; i++) {
			$('#subCategory').append(`<option value=`+income[i]+`>`+income[i]+`</option>`);
		}
	}
	else if($mainCategory == "E") {
		for (let i = 0; i < expense.length; i++) {
			$('#subCategory').append(`<option value=`+expense[i]+`>`+expense[i]+`</option>`);
		}
	} else {
	}
});

//option 배열
var income = ["급여","용돈","기타"];
var expense = ["식비","쇼핑", "생활비", "자기계발", "저축", "유흥", "기타"];

//csfr토큰 headers (post 전송시 필요)
const csrfToken = $("meta[name='_csrf']").attr("content");
const csrfHeader = $("meta[name='_csrf_header']").attr("content");
const headers = {};
headers[csrfHeader] = csrfToken;

$('.accountListDiv').click(function() {
	$('.accountUpdate').slideToggle();
})

let I = "I";
let E = "E";

function getList(n) {
	let incomeExpense = n;
	console.log(incomeExpense);
}

</script>
