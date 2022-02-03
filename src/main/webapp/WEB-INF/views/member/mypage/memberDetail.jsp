<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 회원정보" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<div class="member-body">
	<div class="section">
		<!-- 왼쪽 메뉴list -->
		<div class="absolute-left">
			<ul class="list-group">
				<li class="list-group-item"><a href="${pageContext.request.contextPath}/member/mypage/memberDetail.do?tPage=myPage">마이페이지</a></li>
				<li class="list-group-item"><a href="${pageContext.request.contextPath}/member/mypage/memberDetail.do?tPage=alarm">알림</a></li>
				<li class="list-group-item"><a href="${pageContext.request.contextPath}/member/mypage/memberMyHelp.do">내가 한 질문</a></li>
				<li class="list-group-item"><a href="${pageContext.request.contextPath}/member/mypage/memberFriends.do">친구관리</a></li>
				<li class="list-group-item"><a href="${pageContext.request.contextPath}/member/mypage/memberHelp.do">질문모음</a></li>
				<li class="list-group-item"><a href="${pageContext.request.contextPath}/member/mypage/memberAnnouncement.do">공지사항</a></li>
				<li class="list-group-item"><a href="${pageContext.request.contextPath}/member/mypage/changePassword.do">비밀번호 수정</a></li>
				<sec:authorize access="hasRole('ROLE_SUPER')">
					<li class="list-group-item"><a class="text-danger" href="${pageContext.request.contextPath}/member/admin/adminMain.do">관리자페이지</a></li>
				</sec:authorize>
			</ul>
			<!-- 메뉴리스트 하단 작게 -->
			<div class="phone-update-frm">
				<form action="${pageContext.request.contextPath}/member/mypage/enrollPhone.do">
					<div class="enroll-phone-wrap">
						<div class="enroll-phone-wrap-title">
							<span>핸드폰 등록</span>
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<button class="btn btn-outline-secondary" id="enrollPhone" type="submit">등록</button>
							</div>
							<input type="tel" name="ePhone" id="ePhone" placeholder="-없이 번호만 입력해주세요" class="form-control" placeholder="" aria-label="" aria-describedby="basic-addon1">
						</div>
					</div>
				</form>
			</div>
			<div class="out">
				<a href="${pageContext.request.contextPath}/member/mypage/membershipWithdrawal.do">회원탈퇴</a>
			</div>
		</div>
		
		<!-- 메인 -->
		<div class="main-section">
			<c:if test="${param.tPage eq 'myPage'}">
				<div class="info-profile-wrap">
					<div class="profile-div-wrap">
						<div class="profile-div">
							<c:if test="${loginMember.loginType eq 'K'}">
								<img src="${loginMember.profile}" alt="" />
							</c:if>
							<c:if test="${loginMember.loginType eq 'D'}">
								<c:if test="${loginMember.profileStatus eq 'N'}">							
									<img class="change-profile" src="${pageContext.request.contextPath}/resources/upload/member/profile/default_profile_cat.png" alt="" />
								</c:if>
								<c:if test="${loginMember.profileStatus eq 'Y'}">
									<img class="change-profile" src="${pageContext.request.contextPath}/resources/upload/member/profile/${loginMember.profile}" alt="" />
								</c:if>
							</c:if>
						</div>
						<div class="nickname-wrap">
							<p>
								별명 : <span>${loginMember.nickname}</span>
								<button type="button" id="modify-nickname-modal" class="btn btn-outline-warning">별명 수정</button>
							</p>
						</div>
					</div>
					<div class="info-form">
						<form id="memberUpdateFrm">
							<input type="text" class="form-control" name="id" id="id" value="${loginMember.id}" readonly required/>
							<input type="text" class="form-control" placeholder="이름" name="name" id="name" value="${loginMember.name}" readonly required/>
							<input type="text" class="form-control" placeholder="이메일" name="email" id="email" value="${loginMember.email}" readonly required/>
							<input type="text" class="form-control" placeholder="주소" name="address" id="address" value="${loginMember.address}" readonly required/>
							<input type="text" class="form-control" placeholder="전화번호" name="phone" id="phone" value="${loginMember.phone}" readonly required/>
												
							
							<div class="info-update-btn">
								<input type="submit" class="btn btn-outline-success" value="수정" >
							</div>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
						</form>
						
					</div>				
				</div>
				<div class="hobby-wrap">
					<div class="my-hobby-wrap-title">
						<span>내 취미</span>
					</div>
					<div class="my-hobby-wrap">
					
					</div>
					<div class="hobby-wrap-title">
						<span>취미</span>
					</div>
					<div class="hobby-select-form">
						<form action="">
							<label for="lol">롤</label>
							<input type="checkbox" name="lol" id="lol" />
							<label for="game">게임</label>
							<input type="checkbox" name="game" id="game" />
							<label for="book">독서</label>
							<input type="checkbox" name="book" id="book" />
							<label for="write">글쓰기</label>
							<input type="checkbox" name="write" id="write" />
							<label for="coding">코딩</label>
							<input type="checkbox" name="coding" id="coding" />
							<label for="bowling">볼링</label>
							<input type="checkbox" name="bowling" id="bowling" />
							<label for="basketball">농구</label>
							<input type="checkbox" name="basketball" id="basketball" />
							<label for="goodrestaurant">맛집탐방</label>
							<input type="checkbox" name="goodrestaurant" id="goodrestaurant" />
							<label for="etc">직접입력</label>
							<input type="text" name="etc" id="etc"/>
						</form>
					</div>
				</div>
				
				
			
				<script>
				$("#enrollPhone").click((e) => {
					if(!/01[016789][^0][0-9]{2,3}[0-9]{3,4}/.test($("#ePhone").val())){
						alert('유효하지 않은 번호입니다.');
						return false;
					}
					return true;
				});
				
				const changePw = () => {
					location.href="${pageContext.request.contextPath}/member/mypage/changePassword.do";
				};
				
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
				
				$("#modify-nickname-modal").click((e) => {
					location.href="${pageContext.request.contextPath}/member/mypage/memberModifyNickname.do";
				});
				</script>
			</c:if>
			<c:if test="${param.tPage eq 'alarm'}">
				<div class="alarm-wrap">
					<ul >
						<%-- <c:forEach items="${alarmList}" var="al">
							<c:if test="${al.status eq 'F'}">
								<li class="list-group-item">${al.content}</li>
							</c:if>
							<c:if test="${al.status eq 'T'}">
								<li class="list-group-item list-group-item-secondary">${al.content}</li>
							</c:if>
						</c:forEach> --%>
					</ul>
				</div>
	  			<div class="more-alarm-btn-wrap">
	  				<button type="button" id="more-alarm-btn" class="btn btn-primary">더보기</button>
	  			</div>
			</c:if>
		</div>
		
	</div>
</div>
<script>
var cPage = 1;
$(() => {
	moreAlarm();
});
$("#more-alarm-btn").click((e) => {
	moreAlarm();
});
const moreAlarm = () => {
	
	$.ajax({
		url: "${pageContext.request.contextPath}/member/mypage/memberAlarm.do",
		data: {'cPage':cPage},
		success(resp){
			
			const $alarmUl = $(".alarm-wrap ul");
			
			$(resp).each((i, v) => {
				const {no, code, id, status, content, reg_date} = v;
				console.log(code);
				
				let alarmLi = '';					
				
				if(code.substring(0,2) == 'he' && status == 'F'){
					alarmLi = `<li ><a href="${pageContext.request.contextPath}/member/mypage/memberHelpDetail.do?code=\${code}">\${content}</a></li>`;
				}else if(code.substring(0,2) == 'he' && status == 'T'){
					alarmLi = `<li ><a href="${pageContext.request.contextPath}/member/mypage/memberHelpDetail.do?code=\${code}">\${content}</a></li>`;
				}else if(code.substring(0,2) == 'fr' && status == 'F'){
					alarmLi = `<li >${al.content}</li>`;
				}else if(code.substring(0,2) == 'fr' && status == 'T'){
					alarmLi = `<li >${al.content}</li>`;
				}else{
					alarmLi = `<li >${al.content}</li>`;
				}
				console.log(alarmLi);
				$alarmUl.append(alarmLi);
			});
		},
		error: console.log
	});
	cPage++;
};

$(".change-profile").click((e) => {
	if(confirm('프사를 바꾸시게요?')){
		location.href="${pageContext.request.contextPath}/member/mypage/memberChangeProfile.do";
	}
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>