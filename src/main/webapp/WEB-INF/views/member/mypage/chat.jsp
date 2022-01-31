<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<sec:authentication property="principal" var="loginMember"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/mypage/chat.css" />
</head>
<body>
	<div class="container">
		<div class="col-6">
			<label><b>채팅방</b></label>
		</div>
		<div class="chat-wrap">
			<div id="msgArea" class="col">
				<div class="guest-msg-wrap">
				
				</div>
				<div class="host-msg-wrap">
				
				</div>
			</div>
			<div class="col-6">
				<div class="input-group mb-3">
					<input type="text" id="msg" class="form-control" aria-label="Recipient's username" aria-describedby="button-addon2">
					<div class="input-group-append">
						<button class="btn btn-outline-secondary" type="button" id="button-send">전송</button>
					</div>
				</div>
			</div>
		</div>
	</div>
<script>
$(() => {
	connect();
});
const $msgArea = $("#msgArea");

//전송 버튼 누르는 이벤트
$("#button-send").on("click", function(e) {	
	send();	
	$("#msg").val('');
});

var room = '1';
function connect() {
	var socket = new SockJS("${pageContext.request.contextPath}/chat");
	stompClient = Stomp.over(socket);
	
	stompClient.connect({}, function(frame){
		stompClient.send('/nadaum/chat/join', {}, JSON.stringify({
			'room':room,
			nickname: '${loginMember.nickname}'
		}));
		stompClient.subscribe("/topic/" + room, function(response){
			console.log('response = ' + response);
			console.log(JSON.parse(response.body));
			var resp = JSON.parse(response.body);
			console.log('resp = ' + resp.writer);
			var msg = '';
			if(resp.writer == '${loginMember.nickname}'){
				msg = `<div class='host-msg'>
				<c:if test="${loginMember.loginType eq 'K'}">
					<img src="${loginMember.profile}" alt="" />
				</c:if>
				<c:if test="${loginMember.loginType eq 'D'}">
					<c:if test="${loginMember.profileStatus eq 'N'}">
						<img src="${pageContext.request.contextPath}/resources/upload/member/profile/default_profile_cat.png" alt="" />
					</c:if>
					<c:if test="${loginMember.profileStatus eq 'Y'}">
						<img src="${pageContext.request.contextPath}" alt="" />
					</c:if>
				</c:if>
				\${resp.writer}님이 보냄 : \${resp.message}
				</div>`;
			}else{
				msg = `<div class='guest-msg'>\${resp.writer}님이 보냄 : \${resp.message}</div>`;
			}
			showMsg(msg);
		});
	});
};

function send(){
	var msg = $('#msg').val();
	var data = {'writer':'${loginMember.nickname}', 'message':msg, 'profile':'${loginMember.profile}'};
	console.log('msg = ' + msg);
	stompClient.send("/nadaum/chat/" + room,{},JSON.stringify(data));
	
};

function showMsg(e){
	/* var msg = `<div>'${message.writer}'님이 보냄 : '${message.message}'</div>`; */
	$msgArea.append(e);
	$msgArea.scrollTop($msgArea[0].scrollHeight);
}

/*
var sock = new SockJS("<c:url value='/echo'/>");
sock.onmessage = onMessage;
sock.onclose = onClose;
sock.onopen = onOpen;

function sendMessage() {
	sock.send($("#msg").val());
}
//서버에서 메시지를 받았을 때
function onMessage(msg) {
	
	var data = msg.data;
	var sessionId = null; //데이터를 보낸 사람
	var message = null;
	
	var arr = data.split(":");
	
	for(var i=0; i<arr.length; i++){
		console.log('arr[' + i + ']: ' + arr[i]);
	}
	
	var cur_session = '${userid}'; //현재 세션에 로그인 한 사람
	console.log("cur_session : " + cur_session);
	
	sessionId = arr[0];
	message = arr[1];
	
    //로그인 한 클라이언트와 타 클라이언트를 분류하기 위함
	if(sessionId == cur_session){
		
		var str = "<div class='col-6'>";
		str += "<div class='alert alert-secondary'>";
		str += "<b>" + sessionId + " : " + message + "</b>";
		str += "</div></div>";
		
		$("#msgArea").append(str);
	}
	else{
		
		var str = "<div class='col-6'>";
		str += "<div class='alert alert-warning'>";
		str += "<h1>" + sessionId + " : " + message + "</h1>";
		str += "</div></div>";
		
		$("#msgArea").append(str);
	}
	
}
//채팅창에서 나갔을 때
function onClose(evt) {
	
	var user = '${pr.username}';
	var str = user + " 님이 퇴장하셨습니다.";
	
	$("#msgArea").append(str);
}
//채팅창에 들어왔을 때
function onOpen(evt) {
	
	var user = '${pr.username}';
	var str = user + "님이 입장하셨습니다.";
	
	$("#msgArea").append(str);
}
*/
</script>
</body>
</html>