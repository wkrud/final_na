	
	
	//ajax 로딩시 필요한 값 변수 선언
	var $id = $("#id").val();
	var $income = $("#income").val();
	var $expense = $("#expense").val();
	var $contextPath = $("#contextPath").val(); //contextPath jsp에서 가져온 값(js파일에서 el을 못 씀)
	
	//페이징 관련
	let totalCount; //총 가계부 개수
	let dataPerPage; //한 페이지에 나타낼 글 수
	let pageCount = 5; //페이징에 나타낼 페이지 수
	let currentPage = 1; //현재 페이지
	
	//option 배열
	var income = ["급여","용돈","기타"];
	var expense = ["식비","쇼핑", "생활비", "자기계발", "저축", "유흥", "기타"];
	
	//csfr토큰 headers (post 전송시 필요)
	const csrfToken = $("meta[name='_csrf']").attr("content");
	const csrfHeader = $("meta[name='_csrf_header']").attr("content");
	const headers = {};
	headers[csrfHeader] = csrfToken;
	
	// 유닉스 시간 -> 타임스탬프 -> 기존 date 변환
	function timeConvert(t){
		var unixTime = Math.floor(t / 1000);
	    var date = new Date(unixTime*1000);
	    var year = date.getFullYear();
	    var month = "0" + (date.getMonth()+1);
	    var day = "0" + date.getDate();
	    return year + "-" + month.substr(-2) + "-" + day.substr(-2);
	}

	/*모달 버튼*/
	$("#modalCloseBtn").on('click', function(){
		$(".modal-background").fadeOut();
	});
		
	$("#btn1").on('click', function(){
		$(".modal-background").fadeIn();
	});
		
	//수입 지출 변환 함수
	function IE(x) {
		if(x == 'I')
			return "수입";
		else if(x == 'E')
			return "지출";
	}
	
	//페이지 처음 로딩시 실행 함수
	window.onload = function() {
		//가계부 전체리스트 출력
		AllList();
		//가계부 insert 모달창에 date 기본값 오늘 날짜로 뜨게 설정
		today = new Date();
		today = today.toISOString().slice(0, 10);
		bir = document.getElementById("regDate");
		bir.value = today;
	}

	//원화표시 정규식
	function numberWithCommas(n) {
    	return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	//대분류 선택에 따른 소분류 출력 - 검색
	$("#mainCategory").change(function() {
		const $mainCategory = $("#mainCategory").val();

		$('#subCategory').empty();
		$('#subCategory').append(`<option value="">카테고리</option>`);

		if($mainCategory == "I") {
			for (let i = 0; i < income.length; i++) {
				$('#subCategory').append(`<option value=`+income[i]+`>`+income[i]+`</option>`);
			}
		}
		else if($mainCategory == "E") {
			for (let i = 0; i < expense.length; i++) {
				$('#subCategory').append(`<option value=`+expense[i]+`>`+expense[i]+`</option>`);
			}
		} else {
		}
	});
	
	//대분류 선택에 따른 소분류 출력 - 모달
	$("#main").change(function() {
		const $mainCategory = $("#main").val();

		$('#sub').empty();
		/*$('#sub').append(`<option value="">카테고리</option>`);*/

		if($mainCategory == "I") {
			for (let i = 0; i < income.length; i++) {
				$('#sub').append(`<option value=`+income[i]+`>`+income[i]+`</option>`);
			}
		}
		else if($mainCategory == "E") {
			for (let i = 0; i < expense.length; i++) {
				$('#sub').append(`<option value=`+expense[i]+`>`+expense[i]+`</option>`);
			}
		} else {
		}
	});
	
   //가계부 전체 리스트 조회
  function AllList() {	
 	$.ajax({
		url: $contextPath+"/accountbook/selectAllAccountList.do",
		type: "GET",
		data: {
			id : $id
		},
		dataType : "json",
		contentType : "application/json; charset=UTF-8",
		success : function(accountList){
			$("#account_list").empty();

			$.each(accountList, function(i, account) {
			var result = `
				<tr>
					<td rowspan="2">`+IE(`${account.incomeExpense}`)+`</td>
					<td colspan="2">`+timeConvert(`${account.regDate}`)+`</td>
					<td>`+numberWithCommas(`${account.price}`)+`</td>
				</tr>		
				<tr>
					<td>${account.detail}</td>
					<td><button class="deleteBtn" onclick="deleteDetail('${account.code}')">[X]</button></td>
					<input type="hidden" name="code" value="${account.code}" />
				</tr>
				`
			$('#account_list').append(result);
			})
			
		},
		error(xhr, testStatus, err) {
				console.log("error", xhr, testStatus, err);
				alert("조회에 실패했습니다.");
			}	
	});
}
	//삭제
	function deleteDetail(code) {
		var code = {"code" : code};
  		$.ajax ({
			url : $contextPath+"/accountbook/accountDelete.do",
			type : "POST",
			data : JSON.stringify(code),
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			headers : headers,
			success(result) {
				location.reload();
			},
			error(xhr, testStatus, err) {
				console.log("error", xhr, testStatus, err);
				alert("조회에 실패했습니다.");
			}
		})
	};
		

	
	//수입 지출 금액 조회
    $.ajax({
		url: $contextPath+"/accountbook/monthlyTotalIncome.do",
		type: "GET",
		data: {
			id : $id
		},
		dataType : "json",
		contentType : "application/json; charset=UTF-8",
		success(incomeList){		
			var result = `
				<td><span style="color:green"> +`+numberWithCommas(incomeList[1].total)+`</span></td>
				<td><span style="color:red"> -`+numberWithCommas(incomeList[0].total)+`</span></td>`	
				
			$('.user_income_expense').append(result);
		},
		error(xhr, testStatus, err) {
				console.log("error", xhr, testStatus, err);
				alert("조회에 실패했습니다.");
			}
	});
	
    
    //이달의 총 자산
    $.ajax({
		url: $contextPath+"/accountbook/monthlyAccount.do",
		type: "GET",
		data: {
			id : $id
		},
		dataType : "json",
		contentType : "application/json; charset=UTF-8",
		success(monthlyAccount){
			var result = 
					`<td colspan="2" style="font-size:40px">`+numberWithCommas(monthlyAccount)+`원 </td>`
			$('#total_income').append(result);
		},
		error(xhr, testStatus, err) {
				console.log("error", xhr, testStatus, err);
				alert("조회에 실패했습니다.");
			}
	});

	
	//수입 필터링 -> 지출 필터링이랑 if문으로 var data의 값만 변경해주고 싶은데 어케 수정해야 하나,,,,
	$('#incomeFilterBtn').click(function() {
		var data = {"id" : $id, "income_expense" : $income};
		$.ajax({
			url : $contextPath+'/accountbook/incomeExpenseFilter.do',
			type : "POST",
			data : JSON.stringify(data),
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			headers : headers,
			success(incomeList) {
				$("#account_list").empty();
				$.each(incomeList, function(i, account) {
			var result = `
				<tr>
					<td rowspan="2">`+IE(`${account.incomeExpense}`)+`</td>
					<td colspan="2">`+timeConvert(`${account.regDate}`)+`</td>
					<td>`+numberWithCommas(`${account.price}`)+`</td>
				</tr>		
				<tr>
					<td>${account.detail}</td>
					<td><button class="deleteBtn" onclick="deleteDetail('${account.code}')">[X]</button></td>
					<input type="hidden" name="code" value="${account.code}" />
				</tr>
				`
				$('#account_list').append(result);
				})
				
			},
			error(xhr, testStatus, err) {
				console.log("error", xhr, testStatus, err);
				alert("조회에 실패했습니다.");
			}
		});
	});
	
	
	//지출
	$('#expenseFilterBtn').click(function() {
		var data = {"id" : $id, "income_expense" : $expense};
		$.ajax({
			url : '/nadaum/accountbook/incomeExpenseFilter.do',
			type : "POST",
			data : JSON.stringify(data),
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			headers : headers,
			success(incomeList) {
				$("#account_list").empty();
				$.each(incomeList, function(i, account) {
			var result = `
				<tr>
					<td rowspan="2">`+IE(`${account.incomeExpense}`)+`</td>
					<td colspan="2">`+timeConvert(`${account.regDate}`)+`</td>
					<td>`+numberWithCommas(`${account.price}`)+`</td>
				</tr>		
				<tr>
					<td>${account.detail}</td>
					<td><button class="deleteBtn" onclick="deleteDetail('${account.code}')">[X]</button></td>
					<input type="hidden" name="code" value="${account.code}" />
				</tr>
				`
				$('#account_list').append(result);
				})
			},
			error(xhr, testStatus, err) {
				console.log("error", xhr, testStatus, err);
				alert("조회에 실패했습니다.");
			}
		});
	});
	
	//검색
	$('#searchBtn').click(function() {
		var data = $("#searchFrm").serialize();
		$.ajax({
			url : $contextPath+'/accountbook/searchList.do',
			type : "POST",
			data : JSON.stringify(data),
			dataType : "json",
			headers : headers,
			success(list) {
				$("#account_list").empty();
				$.each(list, function(i, account) {
			var result = `
				<tr>
					<td rowspan="2">`+IE(`${account.incomeExpense}`)+`</td>
					<td colspan="2">`+timeConvert(`${account.regDate}`)+`</td>
					<td>`+numberWithCommas(`${account.price}`)+`</td>
				</tr>		
				<tr>
					<td>${account.detail}</td>
					<td><button class="deleteBtn" onclick="deleteDetail('${account.code}')">[X]</button></td>
					<input type="hidden" name="code" value="${account.code}" />
				</tr>
				`
				$('#account_list').append(result);
				})
			},
			error(xhr, testStatus, err) {
				console.log("error", xhr, testStatus, err);
				alert("조회에 실패했습니다.");
			}
			});
	});
	
	//차트
	//차트 로딩하는 메소드
	google.charts.load('visualization', '1', {'packages':['corechart']});
	//구글 시각화 api가 로딩되면 인자로 전달된 콜백함수를 내부적으로 호출해서 차트를 그림
	google.charts.setOnLoadCallback(drawExpenseChart);
/*	google.charts.setOnLoadCallback(drawIncomeChart);
*/	
	//차트 그리는 함수
	function drawExpenseChart() {
		var firstData = {"id" : $id, "income_expense" : $expense};
		//차트에 구성되는 데이터 [['', ''], ['','']] 타입으로 배열의 배열 형식. 
		//json 데이터 ajax로 받아오기
		$.ajax({
			url : $contextPath+'/accountbook/incomeChart.do',
			type : "POST",
			data : JSON.stringify(firstData),
			contentType : "application/json; charset=UTF-8",
			headers : headers,
			dataType : "json",
			async : false, //ajax는 비동기 통신이기 때문에 해당 옵션을 동기식으로 변경해서 차트가 그려지기 전에 다른 작업을 못하도록 막음
			success(data) {
				console.log(data);
			}
		}).responseText; //서버의 응답 텍스트
		
				
		var chartData = google.visualization.arrayToDataTable([
			['Category', 'Total'],
			data
		]);
		console.log(chartData);
		
		
		var options = { 
			//차트 상단의 제목
			title: '이달의 지출',
			 //차트 크기 설정
			 width : 500,
			 height : 300
			};
	
		var chart = new google.visualization.PieChart(document.getElementById('expenseChart'));
	
		chart.draw(chartData, options);
	};
	
	
	/*function drawIncomeChart() {
		var firstData = {"id" : $id, "income_expense" : $income};
		//json 데이터 ajax로 받아오기
		var jsonData = $.ajax({
			url : $contextPath+'/accountbook/incomeChart.do',
			type : "POST",
			data : JSON.stringify(firstData),
			contentType : "application/json; charset=UTF-8",
			headers : headers,
			dataType : "json",
			async : false, //ajax는 비동기 통신이기 때문에 해당 옵션을 동기식으로 변경해서 차트가 그려지기 전에 다른 작업을 못하도록 막음
		}).responseText; //서버의 응답 텍스트
		
		console.log(jsonData);
		
		var chartData = google.visualization.arrayToDataTable([		
			jsonData
		]);
		console.log(chartData);
		var options = { 
			//차트 상단의 제목
			title: '이달의 수입',
			 //차트 크기 설정
			 width : 500,
			 height : 300
			};
	
		var chart = new google.visualization.PieChart(document.getElementById('incomeChart'));
	
		chart.draw(chartData, options);
	};*/
	
	
	
	var ctx = document.getElementById('myChart').getContext('2d');
	var chart = new Chart(ctx, {
    //차트설정
    type: 'pie',

    //차트데이터
    data: {
        labels: ['급여', '용돈', '기타'],
        datasets: [{
            label: '이달의 수입',
            backgroundColor: [ 'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)' ],
/*            borderColor: 'rgb(255, 99, 132)',
*/            data: [10000, 30000, 200000]
        }]
    },
    options: {}
});
	
	
	
	
	
	
	
	
	
	
	