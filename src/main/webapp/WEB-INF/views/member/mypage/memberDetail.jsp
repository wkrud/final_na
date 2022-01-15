<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원정보" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<div class="section">
	<!-- 왼쪽 메뉴list -->
	<div class="absolute-left">
		<ul class="list-group">
			<li class="list-group-item">마이페이지</li>
			<li class="list-group-item">알림</li>
			<li class="list-group-item">내가 한 질문</li>
			<li class="list-group-item">고객센터</li>
			<li class="list-group-item">Vestibulum at eros</li>
		</ul>
		<!-- 메뉴리스트 하단 작게 -->
		<div class="out">
			<a href="">회원탈퇴</a>
		</div>
	</div>
	
	<!-- 메인 -->
	<div class="main-section">
		<c:if test="${param.tPage eq 'mypage'}">
			<div class="info-form">
				<form id="memberUpdateFrm">
					<input type="text" class="form-control" name="id" id="id" value="${loginMember.id}" readonly required/>
					<input type="text" class="form-control" placeholder="이름" name="name" id="name" value="${loginMember.name}" readonly required/>
					<input type="text" class="form-control" placeholder="별명" name="nickname" id="nickname" value="${loginMember.nickname}" required/>
					<input type="text" class="form-control" placeholder="이메일" name="email" id="email" value="${loginMember.email}" readonly required/>
					<input type="text" class="form-control" placeholder="주소" name="address" id="address" value="${loginMember.address}" readonly required/>
					<input type="text" class="form-control" placeholder="전화번호" name="phone" id="phone" value="${loginMember.phone}" readonly required/>
					
					
					
					
					
					<input type="submit" class="btn btn-outline-success" value="수정" >
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				</form>
			</div>
		
			<script>
			$(memberUpdateFrm).submit((e) => {
				e.preventDefault();
				
				const csrfHeader = "${_csrf.headerName}";
				const csrfToken = "${_csrf.token}";
				const headers = {};
				headers[csrfHeader] = csrfToken;
				
				$.ajax({
					url: "${pageContext.request.contextPath}/member/memberUpdate.do",
					data: $(e.target).serialize(),
					headers: headers,
					method: "POST",
					success(resp){
						console.log(resp);
					},
					error:console.log
				});
			});
			</script>
		</c:if>
		<c:if test="${param.tPage eq 'alarm'}">
			<div class="alarm-wrap">
				<ul class="list-group"></ul>
			</div>
  			
  			<script>
  			$(() => {
  				alarmList();
  			});
  			const alarmList = () => {
  				
  				$.ajax({
  					url: "${pageContext.request.contextPath}/member/memberAlarm.do",
  					method: "GET",
  					success(resp){
  						console.log(resp);
  						const $list = $(".alarm-wrap ul");
  						$list.empty();
  						
  						$(resp).each((i, v) => {
  							console.log(i, v);
  							
  							let date = new Date(v.regDate);
  							let value = `\${date.getFullYear()}.\${(date.getMonth() + 1)}.\${(date.getDate())}`;
  							
  							let code = v.code;
  							let category = code.substring(0,2);
  							console.log(category);
  							
  							let alarms = '';
  							if(v.status == 'F')
  								alarms = `<li class="list-group-item">\${v.code}\${value}</li>`;
  							else
  								alarms = `<li class="list-group-item list-group-item-secondary">\${v.code}\${value}</li>`;
	  						
  							$list.append(alarms);
  						});
  						
  						$(".alarm-wrap").click((e) => {
  							$(e.target).attr("class", "list-group-item list-group-item-secondary");
  						});
  						
  						
  					},
  					error:console.log
  				});
  			};
  			</script>
		</c:if>
		<c:if test="${param.tPage eq 'question'}">
			<!-- Modal -->
			<div class="modal fade" id="myQuestions" tabindex="-1" role="dialog"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">내가 한 질문</h5>
						</div>
						<hr />
						<div class="modal-body myQ">
							<ul class="list-group list-group-flush"></ul>
						</div>
					</div>
				</div>
			</div>
			<script>
			
			
			
			// modal on
			$(() => {
				$(myQuestions)
				.modal()
				.on("hide.bs.modal", (e) => {
					location.href='${empty header.referer ? pageContext.request.contextPath : header.referer}';
				});
				
				$.ajax({
					url: "${pageContext.request.contextPath}/member/myQList.do",
					success(resp){
						console.log(resp);
						const $mBody = $(".modal-body.myQ ul");
						
						$(resp).each((i, v) => {
							let questions = `
			  					<li class="list-group-item">\${v.title}</li>
							`;
							$mBody.append(questions);
						});
											
						
					},
					error:console.log
				});
			});
			</script>
		</c:if>
	</div>
	
</div>
<div class="customer-page-wrap">
	<c:if test="${param.tPage eq 'forCustomer'}">
		<div class="question-list-wrap">
			<div class="question-list-head">
				<h1>질문 모음</h1>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<button class="btn btn-outline-secondary" type="button">검색</button>
					</div>
					<input type="text" class="form-control" placeholder="" aria-label="" aria-describedby="basic-addon1">
				</div>
			</div>
			<div class="question-list-body">
				<div class="me"><ul class="list-group list-group-flush"></ul></div>
				<div class="dy"><ul class="list-group list-group-flush"></ul></div>
				<div class="ab"><ul class="list-group list-group-flush"></ul></div>
				<div class="cu"><ul class="list-group list-group-flush"></ul></div>
			</div>
		</div>
		
		<script>
		$(() => {
			allQuestionsList();
		});
		
		const allQuestionsList = () => {
			const $me = $(".me");
			const $dy = $(".dy");
			const $ab = $(".ab");
			const $cu = $(".cu");
			
			$.ajax({
				url: "${pageContext.request.contextPath}/member/selectAllMembersQuestions.do",
				success(resp){
					console.log(resp);
					
					$(resp).each((i, v) => {
						
						let queList = `<li class="list-group-item">\${v.title}</li>`;
						
						if(v.category == 'cu'){							
							$cu.append(queList);
						}else if(v.category == 'me'){
							$me.append(queList);
						}else if(v.category == 'dy'){
							$dy.append(queList);
						}else if(v.category == 'ab'){
							$ab.append(queList);
						}
							
					});
					
				},
				error: console.log
			});
		};
		</script>
	</c:if>
</div>
<script>


// 페이지 이동
$(".absolute-left").click((e) => {
	const $pageName = $(e.target).text();
	let $tPage = '';
	console.log($tPage);
	if($pageName == '마이페이지')
		$tPage = 'mypage';
	else if($pageName == '알림')
		$tPage = 'alarm';
	else if($pageName == '내가 한 질문')
		$tPage = 'question';
	else if($pageName == '고객센터')
		$tPage = 'forCustomer';
	location.href=`${pageContext.request.contextPath}/member/mypage/memberDetail.do?tPage=\${$tPage}`;	
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>