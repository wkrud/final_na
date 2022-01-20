<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="문화" name="title"/>
</jsp:include>
<body>

<div class="container">
      
      <div class="row" style = "display : flex; flex-wrap : wrap;">
        
              
        
        <div class = "col-md-4 col-sm-6">
          <div class = "thumbnail">
            <img src =                  "https://images.unsplash.com/photo-1434725039720-aaad6dd32dfe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=1561ecb2592830316c279b62f1cb75e5&w=1000&q=80">
            <div class = "caption">
              <h4>First image</h4>
              <p>Lorem ipsum venenatis suspendisse curabitur ac himenaeos vestibulum ultricies ut molestie ultrices posuere, volutpat justo platea tempor phasellus quam vehicula aenean viverra purus rutrum class curae pulvinar rhoncus nostra.</p>
            </div>
          </div>
        </div>
        
        <div class = "col-md-4 col-sm-6">
          <div class = "thumbnail">
            <img src =                  "https://images.unsplash.com/photo-1434725039720-aaad6dd32dfe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=1561ecb2592830316c279b62f1cb75e5&w=1000&q=80">
            <div class = "caption">
              <h4>Second image</h4>
              <p>Lorem ipsum venenatis suspendisse curabitur ac himenaeos vestibulum ultricies ut molestie ultrices posuere, volutpat justo platea tempor phasellus quam vehicula aenean viverra purus rutrum class curae pulvinar rhoncus nostra.</p>
            </div>
          </div>
        </div>
        
        <div class = "col-md-4 col-sm-6">
          <div class = "thumbnail">
            <img src =                  "https://images.unsplash.com/photo-1434725039720-aaad6dd32dfe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=1561ecb2592830316c279b62f1cb75e5&w=1000&q=80">
            <div class = "caption">
              <h4>Third Image</h4>
              <p>Lorem ipsum venenatis suspendisse curabitur ac himenaeos vestibulum ultricies ut molestie ultrices posuere, volutpat justo platea tempor phasellus quam vehicula aenean viverra purus rutrum class curae pulvinar rhoncus nostra.</p>
            </div>
          </div>
        </div>
        
        <div class = "col-md-4 col-sm-6">
          <div class = "thumbnail">
            <img src =                  "https://images.pexels.com/photos/414171/pexels-photo-414171.jpeg?auto=compress&cs=tinysrgb&h=350">
            <div class = "caption">
              <h4>Fourth image</h4>
              <p>Lorem ipsum venenatis suspendisse curabitur ac himenaeos vestibulum ultricies ut molestie ultrices posuere, volutpat justo platea tempor phasellus quam vehicula aenean viverra purus rutrum class curae pulvinar rhoncus nostra.</p>
            </div>
          </div>
        </div>
        
        <div class = "col-md-4 col-sm-6">
          <div class = "thumbnail">
            <img src =                  "https://images.pexels.com/photos/414171/pexels-photo-414171.jpeg?auto=compress&cs=tinysrgb&h=350">
            <div class = "caption">
              <h4>Fifth image</h4>
              <p>Lorem ipsum venenatis suspendisse curabitur ac himenaeos vestibulum ultricies ut molestie ultrices posuere, volutpat justo platea tempor phasellus quam vehicula aenean viverra purus rutrum class curae pulvinar rhoncus nostra.</p>
            </div>
          </div>
        </div>
        
        <div class = "col-md-4 col-sm-6">
          <div class = "thumbnail">
            <img src =                  "https://images.pexels.com/photos/414171/pexels-photo-414171.jpeg?auto=compress&cs=tinysrgb&h=350">
            <div class = "caption">
              <h4>Sixth image</h4>
              <p>Lorem ipsum venenatis suspendisse curabitur ac himenaeos vestibulum ultricies ut molestie ultrices posuere, volutpat justo platea tempor phasellus quam vehicula aenean viverra purus rutrum class curae pulvinar rhoncus nostra.</p>
            </div>
          </div>
        </div>
       
  </div>
</div>
 <c:forEach var="review" items="${list}">
 <div>
 	${review.code}
 	${review.title}
 	${review.content}
 	${review.category}
 	${review.readCount}
 	${review.regDate}
 	${review.id}
 </div>
 </c:forEach>
</body>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
</html>