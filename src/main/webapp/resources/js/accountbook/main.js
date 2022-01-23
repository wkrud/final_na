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
    
 	$.ajax({
		url: "/nadaum/accountbook/selectAllAccountList.do",
		type: "GET",
		data: {
			id : $id
		},
		dataType : "json",
		contentType : "application/json; charset=UTF-8",
		success : function(data){
			console.log(data);
		},
		error : function(data){
			console.log(data);
			console.log("어디가 문제일까,,,,,,,,,,,");
		}	
	});
	
	/*url : "/accountbook/selectAllAccountList.do",
	type : "GET",
	data : {
		id : id
		}
	}).done(function(accountList){
		console.log(accountList);
	});*/
    
    
