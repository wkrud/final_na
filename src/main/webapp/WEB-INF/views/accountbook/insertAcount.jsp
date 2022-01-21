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
		<table>
			<tr>
				<td colspan="2">
					<input type="date" name="reg_date" id="reg_date" />
				</td>
			</tr>
			<tr>
				<td>
					<label for="income_expense">수입</label>
					<input type="radio" name="income_expense" id="" value="I"/>
				</td>
				<td>
					<label for="income_expense">지출</label>
					<input type="radio" name="income_expense" id="" value="E"/>
				</td>
			</tr>
			<tr>
				<td>
					<select name="payment" id=""></select>
					<option value="cash" name="payment">현금</option>
					<option value="card" name="payment">카드</option>
				</td>
				<td>
					<select name="" id=""></select>
					<option value="card">신한</option>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<label for="detail">내역</label>
					<input type="checkbox" name="" id="" placeholder="내역을 입력하세요." />
				</td>
			</tr>
			<tr>
				<td colspan="2"> 
					<label for="price">금액</label>
					<input type="text" name="price" id="" placeholder="금액을 입력하세요" />
				</td>
			</tr>
			<tr>
				<td><input type="submit" value="제출하기" /></td>
			</tr>
		</table>
	</div>


</body>
</html>