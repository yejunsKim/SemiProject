<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
<%
	String ctxPath = request.getContextPath();

%>

<%-- 직접 만든 css --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/main/main.css" />
<!-- Bootstrap 4 CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />

<!--  jQuery (먼저) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>

<!-- Popper.js (중간) -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!--  Bootstrap JS (마지막) -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<%-- <jsp:include page="header.jsp" />     --%>
    
    <div class="container">
		
		<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
		  <ol class="carousel-indicators">
		 
		    <c:if test="${not empty requestScope.categoryList}">
		    	<c:forEach items="${requestScope.categoryList}" varStatus="status">
		    		<c:if test="${status.index==0}">
    			    	<li data-target="#carouselExampleIndicators" data-slide-to="${status.index}" class="active"></li>
    			    </c:if>
    			    
    			    <c:if test="${status.index>0}">
    			    	<li data-target="#carouselExampleIndicators" data-slide-to="${status.index}"></li>
		    		</c:if>
		    	</c:forEach>
		    </c:if>
		    
		   </ol>
		  <div class="carousel-inner">
		
		    <c:if test="${not empty requestScope.categoryList}">
		    	<c:forEach var="cvo" items="${ requestScope.categoryList}" varStatus="status">
		    	  <c:if test="${status.index ==0 }">
			    	  <div class="carousel-item active">
				      <img src="<%= ctxPath%>${cvo.categoryImagePath}" class="d-block w-100" alt="...">
				      <div class="carousel-caption d-none d-md-block">
					    <h5>${cvo.categoryName }</h5>
					  </div>		      
				    </div>
			     </c:if>
			    
			     <c:if test="${status.index >0 }">
				    <div class="carousel-item">
				      <img src="<%= ctxPath%>${cvo.categoryImagePath}" class="d-block w-100" alt="...">
				      <div class="carousel-caption d-none d-md-block">
					    <h5>${cvo.categoryName }</h5>
					  </div>		      
				    </div>
			     </c:if>
		    	</c:forEach>
		    </c:if>
		  </div>
		  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="sr-only">Previous</span>
		  </a>
		  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="sr-only">Next</span>
		  </a>
		</div>
		
		<br><br>
		
			
	</div>
 
    
 <%--  <jsp:include page="footer1.jsp" />     --%>
<%--     <script type="text/javascript" src="<%= ctxPath %>/js/login/login.js"></script>
 --%>    