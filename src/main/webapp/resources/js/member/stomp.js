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
			}
		});
	});
};