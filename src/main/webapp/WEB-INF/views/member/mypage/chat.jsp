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
<title>나:다움 DM</title>
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
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/mypage/chat.css" />
</head>
<body>
	<div class="chat-body">
		<div class="chat-wrap">
			<div id="msgArea" class="col">
				<div class="guest-msg-wrap">
				
				</div>
				<div class="host-msg-wrap">
				
				</div>
			</div>
			<div class="chat-send-btn-wrap">
				<div class="input-group mb-3">
					<input type="text" id="chat-msg-input" class="form-control" aria-label="Recipient's username" aria-describedby="basic-addon2">
					<div class="input-group-append">
						<button class="btn btn-outline-secondary" id="chat-send-btn" type="button">전송</button>
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
const $msg = $("#chat-msg-input");

$msg.on('keyup', function(e) {
	if($msg.val() != ''){
		if(e.key === 'Enter' || e.keyCode === 13){
			$("#chat-send-btn").trigger('click');
		};		
	};
});

//전송 버튼 누르는 이벤트
$("#chat-send-btn").on("click", function(e) {	
	send();	
	$msg.val('');
});




var room = '1';


function connect() {
	var socket = new SockJS("http://localhost:9090/nadaum/chat");
	stompClient = Stomp.over(socket);
	
	stompClient.connect({}, function(frame){
		stompClient.send('/nadaum/chat/join', {}, JSON.stringify({
			'room':room,
			'nickname': '${loginMember.nickname}'
		}));
		stompClient.subscribe("/topic/" + room, function(response){
			console.log('response = ' + response);
			console.log(JSON.parse(response.body));
			var resp = JSON.parse(response.body);
			console.log('resp = ' + resp.writer);
			var msg = '';
			console.log('resp.map = ' + resp.nickname);
			if(resp.writer != '${loginMember.nickname}' && resp.type == 'GREETING'){
				msg = `<div class="greeting-msg-wrap">
				<div class="greeting-body">
				<div class="greeting-msg"><span>\${resp.message}</span></div>
				<div class="greeting-time">\${resp.time}</div>
				</div>
				</div>`;
			}else if(resp.writer == '${loginMember.nickname}' && resp.type != 'GREETING'){
				msg = `<div class='host-msg'>
				<div class="chat-time-wrap">
					<div class="chat-time">\${resp.time}</div>
				</div>
				<div class="chat-msg-wrap">\${resp.message}</div>
				</div>`;
			}else if(resp.type == 'CHAT_TYPE'){
				msg = `<div class='guest-msg'>
					<div class="profile-wrapper">
						<div class="chat-profile-wrap">
							<img class="chat-profile" src="\${resp.profile}" alt="" />			
						</div>
						<div class="profile-nickname">
							\${resp.writer}
							<div class="guest-chat-wrap">
								<div class="chat-msg-wrap"><p>\${resp.message}</p></div>
								<div class="chat-time-wrap">
									<div class="chat-time">\${resp.time}</div>
								</div>
							</div>
						</div>
					</div>
					
				</div>`;
			}
			showMsg(msg);
		});
	});
};

function send(){
	var msg = $msg.val();
	var joinData = {
			'room': room,
			'writer': '${loginMember.nickname}',
			'loginType' : '${loginMember.loginType}',
			'profileStatus' : '${loginMember.profileStatus}',
			'profile' : '${loginMember.profile}',
			'message' : msg
		};
	console.log('msg = ' + msg);
	stompClient.send("/nadaum/chat/" + room,{},JSON.stringify(joinData));
	
};

function showMsg(e){
	$msgArea.append(e);
	$msgArea.scrollTop($msgArea[0].scrollHeight);
};
</script>
</body>
</html>