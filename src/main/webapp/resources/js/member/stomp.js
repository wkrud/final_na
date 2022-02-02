function connect(){
	var socket = new SockJS("http://localhost:9090/nadaum/chat");
	stompClient = Stomp.over(socket);
	
	stompClient.connect({}, function(frame){
		stompClient.subscribe("/topic/" + dest, function(response){
			var resp = JSON.parse(response.body);
			console.log('resp = ', resp);
			
			if(resp.type == 'friend'){
				countBedge();
				console.log('count');
			}else if(resp.type == 'chat'){
				if(confirm(resp.host + '님이 채팅을 신청하셨습니다.')){
					let room = `http://localhost:9090/nadaum/member/mypage/chat.do?room=${resp.room}`;
					let chatRoomLink = `
			        <iframe id="nadaumChat" title="Nadaum Chat" src=${room}>
					</iframe>`;
					$(".chat-section").append(chatRoomLink);
					$("#chatwrap").css("display", "block");
					console.log(room);
				}
			}
		});
	});
};

function chatInvite(type, host, guest, room){
	var sendData = {
		'type':type,
		'host':host,
		'guest':guest,
		'room': room
	};
	stompClient.send("/nadaum/chat/invite/" + guest,{},JSON.stringify(sendData));
};