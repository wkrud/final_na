<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판상세보기" name="title" />
</jsp:include>
<style>
div#board-container {
	position: absolute;
	height: 669px;
	left: 400px;
	top: 100px;
	width: 1000px;
}

input, button, textarea {
	margin-bottom: 15px;
}

button {
	overflow: hidden;
}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label {
	text-align: left;
}
</style>
<!-- 게시글 상세보기 -->

<div id="board-container" class="mx-auto text-center">
	<div id="detail-container">

		<div id="detailcontent-container" class="form-horizontal">
			<!-- 넘겨주어야하는 값 -->
			<input type="hidden" name="code" value="${board.code }" /> 
			<input type="hidden" name="id" id="id" value="${loginMember.id}" />
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

			<label for="title" class="col-sm-2 control-label">제목</label> 
			<input type="text" class="form-control" name="boardTitle" id="title" value="${board.title}" readonly> 
			<label for="writer" class="col-sm-2 control-label">작성자</label> 
			<input type="text" class="form-control" id="writer" name="id" value="${board.id}" readonly> 
			<label for="regDate" class="col-sm-2 control-label">등록일자</label> 
			<input type="datetime-local" class="form-control" name="regDate" id="regDate"
				value='<fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd'T'HH:mm"/>'	readonly> 
			<label for="readCount"	class="col-sm-2 control-label">조회수</label> 
			<input type="number" class="form-control" id="readCount" name="readCount" title="조회수"	value="${board.readCount}" readonly>

			<!-- 나중에 꼭 삭제하기 -->
			<%-- <input type="text" class="form-control" name="memberId" value="${member.name} (${member.id})" readonly required> --%>

			<label for="content" class="col-sm-2 control-label">내용</label>
			<textarea class="form-control mt-3" name="content" placeholder="내용" id="content" readonly>
				<c:out value="${board.content}" />
			</textarea>


		</div>
		<div id="btn-container">
			<%-- 작성자와 마지막행 수정/삭제버튼이 보일수 있게 할 것 --%>
			<%-- <c:if test="${loginMember.id == board.id}"> --%>

			<input type="button" class="btn btn-warning" id="listbtn" value="목록 "
				onclick="location.href ='${pageContext.request.contextPath}/board/boardList.do'">
			<input type="button" class="btn btn-warning" id=" updatebtn" value="수정"
				onclick="location.href ='${pageContext.request.contextPath}/board/boardUpdateView.do?code=${board.code}'">
			<input type="button" class="btn btn-warning" id="deletebtn" value="삭제" onclick="deleteBoard()">

			<%-- </c:if> --%>
		</div>

	</div>
	<hr style="margin-top: 30px;" />

	<!-- 댓글 -->
	<div class="comment-container">
		<div class="comment-editor">
			<form
				<%-- action="${pageContext.request.contextPath}/board/boardCommentEnroll.do" --%>
				method="post" name="boardCommentFrm" id="commentForm">

				<input type="hidden" name="code" value="${board.code}" />
				<!-- 현재게시글 코드 -->
				<input type="hidden" name="id" value="${loginMember.id}" />
				<%-- <input type="hidden" name="writer" value="<c:if test="${loginMember ne null loginMember.id }"/>" /> --%>
				<!-- 댓글인 경우 1 -->
				<input type="hidden" name="commentLevel" value="1" />
				<!-- 대댓글인 경우 써여져야함 -->
				<input type="hidden" name="commentRef" value="" />

				<textarea name="content" cols="60" rows="3" id="content"></textarea>
				<button type="submit" id="btn-comment-enroll1" class="btn btn-warning" onClick="fn_comment('${board.code }')">등록</button>

				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</form>
		</div>

		<div class="comment-list">
			<!-- 댓글이 하나가 되었다면 if구문으로 들어올꺼임 for문 돌면서 level1, ldecel2 태그를 고르고 출력-->
			<%-- <c:if test="${commentList ne null && !empty commentList} }"> --%>
				<!-- table#tbl-comment -->
				<table id="tbl-comment">
					<c:forEach items="${commentList}" var="comment">
						<c:choose>
							<c:when test="${comment.commentLevel eq 1 }">
								<tr class="level1">
									<td>
									<%-- <input type="hidden" name="commentCode" value="${comment.commentCode}"/> --%>
									<sub class="comment-writer">${comment.id}</sub> 
									<sub class="comment-date"><fmt:formatDate value="${board.regDate}" pattern="yy/MM/dd HH:mm" /></sub> 
									<br /> 
									<!-- 댓글내용 -->
										${comment.content}</td>
									<td>
										<button class="btn-reply" value="${comment.code}">답글</button>
										
										<button class="btn-delete" value="${comment.code}">삭제</button>
									</td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr class="level2">
									<td>
								<tr class="level1">
									<td><sub class="comment-writer">${comment.id}</sub> 
									<sub class="comment-date">${comment.regDate}</sub>
									<br /> 
									<!-- 댓글내용 -->
										${comment.content} <!-- e댓글내용 --></td>
									<td>
										<button class="btn-delete" value="${comment.code}">삭제</button>
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</table>
			<%-- </c:if> --%>

		</div>
	</div>


</div>
</body>
<form name="boardDelFrm" method="POST"
	action="${pageContext.request.contextPath}/board/boardDelete.do">
	<input type="hidden" name="code" value="${board.code}" /> <input
		type="hidden" name="id" id="id" value="${loginMember.id}" /> <input
		type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
<form
	action="${pageContext.request.contextPath}/board/boardCommentDelete.do"
	name="boardCommentDelFrm" method="POST">
	<input type="hidden" name="commentCode" value="${comment.commentCode}" />
	<input type="hidden" name="code" value="${board.code}" /> 
	<input type="hidden" name="id" id="id" value="${loginMember.id}" /> 
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
<script>
	//회원아이디와 글쓴이 아이디와 같은때 보임.
	//삭제 버튼을 눌렀을 때 처리
const deleteBoard = () => {
	if(confirm("이 게시물을 정말 삭제하시겠습니까?")){
		$(document.boardDelFrm).submit();		
	}
};
	//수정 버튼을 눌렀을 때 처리
const updateBoard = () => {
	location.href = "${pageContext.request.contextPath}/board/boardUpdateView.do?code=${board.code}";
};

$(".btn-delete").click(function(){
	if(confirm("해당 댓글을 삭제하시겠습니까?")){
		var $frm = $(document.boardCommentDelFrm);
		var no = $(this).val();
		$frm.find("[name=no]").val(no);
		$frm.submit();
	}
});	

/* ajax 비동기로 처리 */
function fn_comment(code){
    $.ajax({
        type:'POST',
        url : "<c:url value='/board/boardCommentEnroll.do'/>",
        data:$("#commentForm").serialize(),
        success : function(data){
            if(data=="success")
            {
                getCommentList();
                $("#content").val("");
            }
        },
        error:function(request,status,error){
            //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
       }  
    });
}

/**
 * 초기 페이지 로딩시 댓글 불러오기
 */
$(function(){    
    getCommentList();  
});



</script>
</html>
<%-- <jsp:include page="/WEB-INF/views/common/footer.jsp"/> --%>