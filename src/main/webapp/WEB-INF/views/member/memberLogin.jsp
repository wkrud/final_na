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
<title>login</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script>
$(() => {
	$(loginModal)
		.modal()
		.on("hide.bs.modal", (e) => {
			location.href='${empty header.referer || header.referer.contains('/member/memberLogin.do') ? pageContext.request.contextPath : header.referer}';
		});
});
</script>
</head>
<body>

	<!-- Modal -->
	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form:form 
					action="${pageContext.request.contextPath}/member/memberLogin.do"
					method="post">
					<div class="modal-body">
						<c:if test="${param.error != null}">
							<span class="text-danger">아이디 또는 비밀번호가 일치하지 않습니다.</span>
						</c:if>
						<input
							type="text" class="form-control" name="id" value="honggd"
							placeholder="아이디" required>
						<br /> 
						<input
							type="password" class="form-control" name="password" value="1234"
							placeholder="비밀번호" required>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-primary">login</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">close</button>
					</div>
				</form:form>
			</div>
		</div>
	</div>


</body>
</html>