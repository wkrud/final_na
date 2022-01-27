<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판작성" name="title"/>
</jsp:include>
<style>
div, section, header, aside, footer {
     padding: 0px;
}
input#btn-add {
	float: right;
	margin: 0 0 15px;
}
div#board-container {
	width: 400px;
	margin: 0 auto;
	text-align: center;
}

div#board-container input {
	margin-bottom: 15px;
}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label {
	text-align: left;
}
</style>
<script>
function boardValidate(){
	var $content = $("[name=content]");
	if(/^(.|\n)+$/.test($content.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	return true;
}

$(() => {
	/**
	 * 파일명 표시하기
	 */
	$("[name=upFile]").change((e) => {
		const file = $(e.target).prop('files')[0];
		const $label = $(e.target).next();
		
		if(file != undefined)
			$label.html(file.name);
		else
			$label.html("파일을 선택하세요.");
		
	});
});
</script>
<body>

<section id="board-container" class="container">
	<div id="board-container">
	<form name="boardFrm"
		action="${pageContext.request.contextPath}/board/boardEnroll.do"
		method="post" enctype="multipart/form-data"
		onsubmit="return boardValidate();">
		<!--  -->
		<input type="hidden" name="id" id="id" value="${loginMember.id}" />
		<sec:authentication property="principal" var="loginMember"/>
		<input type="text" class="form-control" placeholder="제목" name="title"
			id="title" required> <input type="text" class="form-control"
			name="memberId" value="${loginMember.id}" readonly required>

		<!-- input:file소스 : https://getbootstrap.com/docs/4.1/components/input-group/#custom-file-input -->
		<div class="input-group mb-3" style="padding: 0px;">
			<div class="input-group-prepend" style="padding: 0px;">
				<span class="input-group-text">첨부파일1</span>
			</div>
			<div class="custom-file">
				<input type="file" class="custom-file-input" name="upFile"
					id="upFile1" multiple> <label class="custom-file-label"
					for="upFile1">파일을 선택하세요</label>
			</div>
		</div>
		<div class="input-group mb-3" style="padding: 0px;">
			<div class="input-group-prepend" style="padding: 0px;">
				<span class="input-group-text">첨부파일2</span>
			</div>
			<div class="custom-file">
				<input type="file" class="custom-file-input" name="upFile"
					id="upFile2"> <label class="custom-file-label"
					for="upFile2">파일을 선택하세요</label>
			</div>
		</div>

		<textarea class="form-control" name="content" placeholder="내용"
			required></textarea>
		<br /> <input type="submit" class="btn btn-outline-success"
			value="저장">
	</form>
</div>
</section> 
</body>
<script>

</script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
  <script src="https://pingendo.com/assets/bootstrap/bootstrap-4.0.0-alpha.6.min.js"></script>
</html>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>