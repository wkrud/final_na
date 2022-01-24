/**
 * 
 */
 
 
 /* 검색 카테고리 js*/
 
/* $(() => {
	
	var category0 = ["수입", "지출"];
	var category1 = ["급여", "용돈", "기타"];
	var category2 = ["식비", "쇼핑", "유흥", "저축", "생활비", "자기계발", "기타"];
	
	var category = [category0, category1, category2];
	
	$.each(category0, (key, value) => {
		$('#mainCategory').append($("<option></option>").attr("value", key).text(value));
	});
	
	console.log(category[0]);
	
	$("#mainCategory").change((e) => {
		let $no = Number($("#mainCategory").val() + 1);
		$("subCategory").empty();
		
		const option = `<option hidden = "" selected disabled>소분류</option>`;
		for(let i = 0; i <= category.length; i++) {
			if($no == i) {
				$("#subCategory").append(option);
				$.each(category[i], (key, value) => {
					$('#subCategory').append($("<option></option>").attr("value", key).text(value));
				}); 
			};
		};
	});
	
});*/


/*버튼 테스트*/

$("#closeBtn").on('click', function(){
	$(".modal-background").fadeOut();
});
	
$("#btn1").on('click', function(){
	$(".modal-background").fadeIn();
});


/* id값 가져오는 ajax*/
	/*const csrfHeader = "${_csrf.headerName}";
    const csrfToken = "${_csrf.token}";
    const headers = {};
    headers[csrfHeader] = csrfToken;*/
  
    var $id = $("#id").val();
    console.log($id);
    
    
   //가계부 리스트 조회
 	$.ajax({
		url: "/nadaum/accountbook/selectAllAccountList.do",
		type: "GET",
		data: {
			id : $id
		},
		dataType : "json",
		contentType : "application/json; charset=UTF-8",
		success(list){
			
			//if조건으로 가계부 리스트 있/없 나눠주기
			
			$.each(list, function(i, account) {
			var result = `
				<tr>
					<td rowspan="2">${account.incomeExpense}</td>
					<td colspan="2">${account.regDate}</td>
					<td>${account.price}</td>
				</tr>		
				<tr>
					<td>${account.detail}</td>
					<td>${account.code}</td>

				`
			$('#account_list_table').append(result);
			})
			
			
		},
		error : function(data){
			console.log(data);
			console.log("어디가 문제일까,,,,,,,,,,,");
		}	
	});
	
	
	//수입 지출 조회
    $.ajax({
		url: "/nadaum/accountbook/monthlyTotalIncome.do",
		type: "GET",
		data: {
			id : $id
		},
		dataType : "json",
		contentType : "application/json; charset=UTF-8",
		success(income){
			console.log(income);
			}
		});
    
