	
	
	//ajax 로딩시 필요한 값 변수 선언
	var $id = $("#id").val();
	var $income = $("#income").val();
	var $expense = $("#expense").val();
	
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
	$("#closeBtn").on('click', function(){
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
	
	//거래내역 입력시 날짜 기본값 세팅
	window.onload = function() {
		today = new Date();
		today = today.toISOString().slice(0, 10);
		bir = document.getElementById("reg_date");
		bir.value = today;
	}

	//원화표시 정규식
	function numberWithCommas(n) {
    	return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	//대분류 선택에 따른 소분류 출력
	$("#mainCategory").change(function() {
		const $mainCategory = $("#mainCategory").val();

		$('#subCategory').empty();
		$('#subCategory').append(`<option value="">소분류</option>`);

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
	
	
    
   //가계부 리스트 조회
 	$.ajax({
		url: "/nadaum/accountbook/selectAllAccountList.do",
		type: "GET",
		data: {
			id : $id
		},
		dataType : "json",
		contentType : "application/json; charset=UTF-8",
		success : function(accountList){
			console.log(accountList);
			$.each(accountList, function(i, account) {
			var result = `
				<tr>
					<td rowspan="2">`+IE(`${account.incomeExpense}`)+`</td>
					<td colspan="2">`+timeConvert(`${account.regDate}`)+`</td>
					<td>`+numberWithCommas(`${account.price}`)+`</td>
				</tr>		
				<tr>
					<td>${account.detail}</td>
					<td><button id="deleteBtn" onclick="deleteDetail();">삭제하기</button></td>	
					<input type="hidden" name="code" value="${account.code}" />
				</tr>
				`
			$('#account_list').append(result);
			})
			
		},
		error : function(data){
			console.log(data);
			console.log("어디가 문제일까,,,,,,,,,,,");
		}	
	});
	
	//삭제
	
	//수입 지출 조회
    $.ajax({
		url: "/nadaum/accountbook/monthlyTotalIncome.do",
		type: "GET",
		data: {
			id : $id
		},
		dataType : "json",
		contentType : "application/json; charset=UTF-8",
		success(incomeList){		
			var result = `
				<td>\\<span style="color:green">`+numberWithCommas(incomeList[1].total)+`</span></td>
				<td>\\<span style="color:red">`+numberWithCommas(incomeList[0].total)+`</span></td>`	
				
			$('.user_income_expense').append(result);

		}
	});
	
    
    //이달의 총 자산
    $.ajax({
		url: "/nadaum/accountbook/monthlyAccount.do",
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

		}
	});

	
	//수입 필터링
	$('#income_filter_btn').click(function() {
		$.ajax({
			url : '/nadaum/accountbook/income_expense_filter.do',
			type : "POST",
			data : {
				"id" : $id,
				"income_expense" : $income
			},
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			headers : headers,
			success(incomeList) {
				console.log($id);
				console.log($income);
				console.log(incomeList);
			},
			error(xhr, testStatus, err) {
				console.log("error", xhr, testStatus, err);
				alert("조회에 실패했습니다.");
			}
		});
	});
	
	
	//지출
	$('#expense_filter_btn').click(function() {
		$.ajax({
			url : '/nadaum/accountbook/income_expense_filter.do',
			type : "POST",
			data : {
				"id" : $id,
				"income_expense" : $expense
			},
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			headers : headers,
			success(incomeList) {
				console.log(incomeList);
				$("#account_list").empty();
			},
			error(xhr, testStatus, err) {
				console.log("error", xhr, testStatus, err);
				alert("조회에 실패했습니다.");
			}
		});
	});
	
