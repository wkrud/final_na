<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<body>
${perforList}
<script>
$(function() {
	$.ajax({
		url: "${pageContext.request.contextPath}/culture/xmlParser",
		method: "GET", 
		success(resp){
			console.log(resp);
		},
		error: console.log
	});
	
});
</script>
</body>
</html>