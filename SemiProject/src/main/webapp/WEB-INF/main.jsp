<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%
    String ctxPath = request.getContextPath();
 	%>
    
       <jsp:include page="header.jsp" />
    
       <div class="col-md-9" id="maininfo" align="center">

         <div id="maincontent">

					<%-- 캐러셀 시작 --%>
					<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
						<div class="carousel-indicators">
							<button type="button" data-bs-target="#carouselExampleIndicators"
								data-bs-slide-to="0" class="active" aria-current="true"
								aria-label="Slide 1"></button>
							<button type="button" data-bs-target="#carouselExampleIndicators"
								data-bs-slide-to="1" aria-label="Slide 2"></button>
							<button type="button" data-bs-target="#carouselExampleIndicators"
								data-bs-slide-to="2" aria-label="Slide 3"></button>
						</div>
						<div class="carousel-inner">
							<div class="carousel-item active">
								<img src="<%= ctxPath%>/images/main/a001.jpg" class="d-block w-100" alt="향수1">
							</div>
							<div class="carousel-item">
								<img src="<%= ctxPath%>/images/main/a002.jpg" class="d-block w-100" alt="향수2">
							</div>
							<div class="carousel-item">
								<img src="<%= ctxPath%>/images/main/a003.jpg" class="d-block w-100" alt="향수3">
							</div>
						</div>
						<button class="carousel-control-prev" type="button"
							data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="visually-hidden"></span>
						</button>
						<button class="carousel-control-next" type="button"
							data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="visually-hidden"></span>
						</button>
					</div>
					<%-- 캐러셀 끝 --%>
         </div>
       </div>
     </div>
      
     <jsp:include page="footer.jsp" />
   