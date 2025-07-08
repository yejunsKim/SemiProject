<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
  
<%
	String ctxPath = request.getContextPath();
%> 

<%-- 직접 만든 css --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/Commercials/Commercials.css" />
<!-- Bootstrap 4 CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
 
<!--  jQuery (먼저) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>

<!-- Popper.js (중간) -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!--  Bootstrap JS (마지막) -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
$(document).ready(function() {
	  // 로고 페이드 인 > 2초간 유지 > 페이드 아웃
	  $('#footerLogo').fadeTo(2000, 1, function() {
	    setTimeout(function() {
	      $('#splashScreen').fadeOut(800, function() {
	        $('#mainContent').fadeIn(300); // 메인 내용 보여줌
	      });
	    }, 1000); // fadeIn 후 1초 대기
	  });
	});
</script>

 <%-- 250627 헤더테스트로인한 수정 --%>
 <jsp:include page="header.jsp" />
 <!-- Commercials.jsp의 header.jsp 바로 아래 -->
<style>
    #leftSide {
        display: none !important;
    }
    
   #splashScreen {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: #000; /* 또는 원하는 배경 */
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 9999;
}

#splashScreen img#footerLogo {
  width: 300px; /* 원하는 초기 로고 크기 */
  height: auto;
  opacity: 0;
}
    
</style>

<%--
  <div id="splashScreen">
    <img src="/SemiProject/images/footer/footerLogo.png" id="footerLogo" />
  </div>

  <!-- 원래 페이지 내용 시작 -->
  <div id="mainContent" style="display: none;">
    <!-- 여기에 원래 있던 메인 내용들 -->
  </div>
   --%>
  
<div class="col-md-12" style="padding:0;">
	<div class="container-fluid">		
		<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" style="height:100%;">
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
		    	<c:forEach var="cvo" items="${requestScope.categoryList}" varStatus="status">
		    	  <c:if test="${status.index ==0 }">
			    	  <div class="carousel-item active">
			    	  
			    	  <%-- 수정사항-rdg7203 --%>
			    	  <a href="<%= ctxPath%>/item/mallHome.do?categoryNo=${cvo.categoryNo}">
				      <img src="<%= ctxPath%>${cvo.categoryImagePath}" class="d-block w-100" alt="...">
				      </a>
				      <div class="carousel-caption d-none d-md-block">
					    <h5 style="font-size: 18px;">${cvo.categoryName }</h5>
					  </div>
				    </div>
			     </c:if>
			    
			     <c:if test="${status.index >0 }">
				    <div class="carousel-item">
				    
				      <%-- 수정사항-rdg7203 --%>
				      <a href="<%= ctxPath%>/item/mallHome.do?categoryNo=${cvo.categoryNo}">
				      <img src="<%= ctxPath%>${cvo.categoryImagePath}" class="d-block w-100" alt="...">
				      </a>
				      <div class="carousel-caption d-none d-md-block">
					    <h5 style="font-size: 18px;">${cvo.categoryName}</h5>
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
 
     <jsp:include page="footer.jsp" /> 