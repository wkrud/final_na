<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>친구찾기</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">
</head>
<body>
	<sec:authentication property="principal" var="loginMember"/>
	<label for="find-friends">친구검색</label>
	<input type="text" list="all-friends" name="friend" id="find-friends" />
	<datalist id="all-friends">
		<c:forEach items="${memberList}" var="fr">
			<option value="${fr.nickname}"/>
		</c:forEach>
	</datalist>
	<div class="recommend-friends">
		
	</div>
	<div class="selected-friend"></div>
	
	<script>
	
	// 친구 검색시 친구추가 버튼 생성
	$("#find-friends").change(() => {
		let selected = '';
		
		<c:forEach items="${memberList}" var="fr">
			if('${fr.nickname}' == $("#find-friends").val()){
				selected = $("#find-friends").val();
				let button = `<span>\${selected}</span>
				<input type="checkbox" class="btn-check addFriend" id="btn-check-outlined" autocomplete="off" style="display:none;">
				<label class="btn btn-outline-primary" for="btn-check-outlined">친구추가</label>
				`;
				$(".selected-friend")
					.empty()
					.append(button);
				$(".selected-friend").change((e) => {
					console.log("1");
				});
			}else{
				selected = '';
			}
		</c:forEach>		
		
	});
	</script>

</body>
</html>