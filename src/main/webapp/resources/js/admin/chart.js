



/* 취미 pie chart */ 
google.charts.load('current', {'packages':['corechart']});	
google.charts.setOnLoadCallback(draws);
function draws(){
	var data = google.visualization.arrayToDataTable([
		['Hobby', 'Count'],
		['coding', 4],
		['eat', 4],
		['basketball', 8],
		['sleep', 2]
	]);
	
	var options = {
		title: '회원 취미'
	};
	
	var chart = new google.visualization.PieChart(document.getElementById('member-hobby-chart'));
	
	chart.draw(data, options);
}


/* 월별 가입자 수 */
window.onload = function colData(){
	$.ajax({
		url:'http://localhost:9090/nadaum/member/admin/chart.do',
		success(resp){
			console.log(resp);
			
			const {list, hi} = resp;
			
			let count = '';
			let day = '';
			var cols = [];
			let title = ['월', '명'];
			cols.push(title);
			$(list).each((i, {REGDATE, CNT}) => {
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
								'width':500,
								'height':300};
				
				var chart = new google.visualization.ColumnChart(document.getElementById('member-enroll-chart'));
				chart.draw(data, options);
			};
		},
		error:console.log
	});
};
