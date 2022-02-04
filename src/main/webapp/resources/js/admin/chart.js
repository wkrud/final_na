window.onload = function colData(){
	$.ajax({
		url:'http://localhost:9090/nadaum/member/admin/chart.do',
		success(resp){
			console.log(resp);
			let count = '';
			let day = '';
			var cols = [];
			let title = ['월', '명'];
			cols.push(title);
			$(resp).each((i, {REGDATE, CNT}) => {
				count = CNT;
				day = REGDATE;
				let col = [day, count];
				console.log(col);
				cols.push(col);
			});
			console.log(cols);
			google.charts.load('current', {'packages':['corechart']});
			google.charts.setOnLoadCallback(drawChart);
			function drawChart(){
				var data = new google.visualization.arrayToDataTable(cols);
				
				var options = {'title':'월 별 가입 회원 수',
								'width':400,
								'height':300};
				
				var chart = new google.visualization.ColumnChart(document.getElementById('member-enroll-chart'));
				chart.draw(data, options);
			};
		},
		error:console.log
	});
};
