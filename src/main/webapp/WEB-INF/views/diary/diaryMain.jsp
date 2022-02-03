<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나:다움 Diary" name="title"/>
</jsp:include>
<style>
#diaryPreview-container {
	padding-top: 15px;
    display: flex;
    justify-content: center;
    background-color: cornsilk;
    padding: 50px;
}
#diaryMain-container {
    display: flex;
    padding-top: 90px;
    /* padding-bottom: 7px; */
    flex-direction: column;
    align-items: center;
    margin: 10px;
}
#diaryMonth{padding: 30px;}
#diaryPreviewContent {    
	display: flex;
    flex-direction: row;
}
#diarySearch-container { padding-bottom: 15px; }
[type=radio] { 
	position: absolute;
	opacity: 0;
	width: 0;
	height: 0;
} 
[type=radio] + div { cursor: pointer; }
[type=radio]:checked + div { height:160px; }
.form-group { 
	text-align: center; display: flex;
    flex-direction: column;
    align-items: center;
}
.badge-warning {
    color: #212529;
    font-size: 23px;
    background-color: #ffc107;
    height: 35px;
    width: 41px;
    cursor: pointer;
}

.emotionChoose { 
	display: flex;
    flex-wrap: wrap;
    justify-content: center;
}
.blanket{
    content:url("${pageContext.request.contextPath}/resources/images/diary/emotion/blanket.png");
    height:130px;
}
.daechoong{
    content:url("${pageContext.request.contextPath}/resources/images/diary/emotion/daechoong.png");
    height:130px;
}
.gogo{
    content:url("${pageContext.request.contextPath}/resources/images/diary/emotion/gogo.png");
    height:130px;
}
.happy{
    content:url("${pageContext.request.contextPath}/resources/images/diary/emotion/happy.png");
    height:130px;
}
.trash{
    content:url("${pageContext.request.contextPath}/resources/images/diary/emotion/trash.png");
    height:130px;
}
.eat{
    content:url("${pageContext.request.contextPath}/resources/images/diary/emotion/eat.png");
    height:130px;
}
.col-8 {width: 600px; /* place-self: center; 일기내용 중앙정렬*/}
#list-tab {
	width: 287px;
    height: 376px;
    overflow: auto;
    scroll-snap-type: y proximity;
}
.list-group-item {scroll-snap-align: start;}
</style>

<div id="diaryMain-container">
	<div id="diaryMonth">	
		<span class="badge badge-pill badge-warning">1</span>
		<span class="badge badge-pill badge-warning">2</span>
		<span class="badge badge-pill badge-warning">3</span>
		<span class="badge badge-pill badge-warning">4</span>
		<span class="badge badge-pill badge-warning">5</span>
		<span class="badge badge-pill badge-warning">6</span>
		<span class="badge badge-pill badge-warning">7</span>
		<span class="badge badge-pill badge-warning">8</span>
		<span class="badge badge-pill badge-warning">9</span>
		<span class="badge badge-pill badge-warning">10</span>
		<span class="badge badge-pill badge-warning">11</span>
		<span class="badge badge-pill badge-warning">12</span>
	</div>
	<div id="diaryPreview-container">
		<div id="diaryPreviewContent">
			<div id="diaryPreview">
				<div id="diarySearch-container">
				<input type="text" class="diarySearch" name="diarySearch" id="diarySearch" placeholder="검색">
				<button type="button" class="searchBtn" id="searchBtn">검색</button>		
				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo">+</button>
				<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h4 class="modal-title" id="exampleModalLabel">New Diary</h4>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				      </div>
				      <!-- 모달 -->
				      <div class="modal-body">
				        <form action="${pageContext.request.contextPath}/diary/diaryEnroll.do">			     
				          <div class="form-group">
				            <label for="recipient-name" id="emotionTitle" class="control-label">오늘의 감정을 골라보세요</label>
				            <input type="date" name="regDate" id="reg_date" />
				          </div>
				          <div class="emotionChoose">
				          	<label><input type= "radio" name="emotion" value="blanket"><div class="blanket"></div></input></label>
				          	<label><input type= "radio" name="emotion" value="daechoong"><div class="daechoong"></div></input></label>
				          	<label><input type= "radio" name="emotion" value="gogo"><div class="gogo"></div></input></label>
				          	<label><input type= "radio" name="emotion" value="happy"><div class="happy"></div></input></label>
				          	<label><input type= "radio" name="emotion" value="trash"><div class="trash"></div></input></label>
				          	<label><input type= "radio" name="emotion" value="eat"><div class="eat"></div></input></label>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				          </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					        <input type="submit" class="btn btn-primary" value="전송">
					      </div>
				        </form>
				      </div>
				      
				    </div>
				  </div>
				</div>
			</div>			
			<!-- 일기 목록 -->
			<div class="row">
			  <div class="col-4">
			    <div class="list-group" id="list-tab" role="tablist">
			    <c:forEach items="${diaryList}" var="diary" varStatus="vs">
			    	<c:choose>
			    		<c:when test="${vs.first}">
					      <a class="list-group-item list-group-item-action active" id="${diary.code}-list" data-toggle="list" href="#${diary.code}" role="tab" aria-controls="${diary.code}">
					      <h4><fmt:formatDate value="${diary.regDate}" pattern="dd일 E"/>요일</h4><h5>${diary.title}</h5></a>
			    		</c:when>
			    		<c:otherwise>
					      <a class="list-group-item list-group-item-action" id="${diary.code}-list" data-toggle="list" href="#${diary.code}" role="tab" aria-controls="${diary.code}">
					      <h4><fmt:formatDate value="${diary.regDate}" pattern="dd일 E"/>요일</h4><h5>${diary.title}</h5></a>
			    		</c:otherwise>
			    	</c:choose>
				   </c:forEach>
			    </div>
			  </div>
			  <div class="col-8">
			    <div class="tab-content" id="nav-tabContent">
			    	<c:forEach items="${diaryList}" var="diary" varStatus="vs">
				    	<c:choose>
				    		<c:when test="${vs.first}">
						      <div class="tab-pane fade show active" id="${diary.code}" role="tabpanel" aria-labelledby="${diary.code}-list">
						      	<h4><fmt:formatDate value="${diary.regDate}" pattern="dd일 E"/>요일</h4>
						      	<h5>${diary.title}</h5>
						      	${diary.content}
						      </div>
				    		</c:when>
				    		<c:otherwise>
						      <div class="tab-pane fade show" id="${diary.code}" role="tabpanel" aria-labelledby="${diary.code}-list">
						      	<h4><fmt:formatDate value="${diary.regDate}" pattern="dd일 E"/>요일</h4>
						      	<h5>${diary.title}</h5>
						      	${diary.content}
						      </div>
				    		</c:otherwise>
				    	</c:choose>
			    	</c:forEach>
			      <div class="tab-pane fade" id="list-profile" role="tabpanel" aria-labelledby="list-profile-list">proooooooooooo</div>
			      <div class="tab-pane fade" id="list-messages" role="tabpanel" aria-labelledby="list-messages-list">meeeeeeeeeeeeee</div>
			      <div class="tab-pane fade" id="list-settings" role="tabpanel" aria-labelledby="list-settings-list">settttpppptttttttttt</div>
			    </div>
			  </div>
			</div>
		</div>		
				
			</div>
		</div>
	</div>


<script>
window.onload = function() {
	today = new Date();
	today = today.toISOString().slice(0, 10);
	bir = document.getElementById("reg_date");
	bir.value = today;
}


</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />