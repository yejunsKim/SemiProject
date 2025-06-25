<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String ctxPath = request.getContextPath();
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>

<title>PerfumeArena</title> 

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="icon" type="image/png" sizes="32x32" href="<%= ctxPath%>/images/header/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="<%= ctxPath%>/images/header/favicon-16x16.png">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 

<!-- Font Awesome 6 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css">

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/common/common.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/main/main.css" />

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js"></script> 
<script type="text/javascript" src="<%= ctxPath%>/js/main/main.js"></script>

<%-- jQueryUI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>

<style>
  .dropdown-menu {
    width: 700px;
    padding: 0;
    border: none;
  }

  #commercialBanner img {
    max-width: 100%;
    height: 300px;
    object-fit: contain;
    display: block;
    margin: 0 auto;
  }

  #commercialBanner .carousel-caption h5 {
    font-weight: bold;
    font-size: 22px;
    text-shadow: 1px 1px 2px black;
  }
</style>

<script>
$(document).ready(function() {
  $('.nav-item.dropdown').hover(function() {
    $(this).addClass('show');
    $(this).find('.dropdown-menu').addClass('show');
  }, function() {
    $(this).removeClass('show');
    $(this).find('.dropdown-menu').removeClass('show');
  });
});
</script>

</head>
<body>
  <!-- 상단 네비게이션 시작 -->
   <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
      <a class="navbar-brand" href="<%= ctxPath %>/main.do" style="margin-right: 10%;"><img src="<%= ctxPath%>/images/header/favicon-32x32.png" /></a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
         <span class="navbar-toggler-icon"></span>
       </button>
      <div class="collapse navbar-collapse" id="collapsibleNavbar">
        <ul class="navbar-nav" style="font-size: 16pt;">
           <li class="nav-item active">
              <a class="nav-link menufont_size" href="<%= ctxPath %>/index.up">향수 둘러보기</a>
           </li>
           <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle menufont_size text-primary" href="#" id="navbarDropdown" data-toggle="dropdown">Dropdown</a>
              <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                <c:if test="${not empty requestScope.categoryList}">
                  <div id="commercialBanner" class="carousel slide" data-ride="carousel" data-interval="3000">
                    <div class="carousel-inner">
                      <c:forEach var="cvo" items="${categoryList}" varStatus="status">
                        <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                          <img src="<%= ctxPath %>${cvo.categoryImagePath}" alt="...">
                          <div class="carousel-caption d-none d-md-block">
                            <h5>${cvo.categoryName}</h5>
                          </div>
                        </div>
                      </c:forEach>
                    </div>
                  </div>
                </c:if>
                <a class="dropdown-item text-primary" href="#">Another action</a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item text-primary" href="#">Something else here</a>
              </div>
           </li>
        </ul>
      </div>
       <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" style="width:13%;">
   </nav>
   <!-- 상단 네비게이션 끝 -->

    <div class="container-fluid" id="container" style="position: relative;">
     
     
     <div class="row">
       <div class="col-md-3" id="sideinfo">
       	 <%-- 로그인 시작 --%>
         <div class="loginBox" style="height: 200px; text-align: left; padding: 11px;">

				<div class="loginTheme">
					<form name="loginFrm" action="<%=ctxPath%>/login/login.up"
						method="post">
						<table id="loginTbl">
							<thead>
								<tr>
									<th colspan="3">LOGIN</th>
								</tr>
							</thead>

							<tbody>
								<tr>
									<td>ID</td>
									<td></td>
									<td>
									   <input type="text" name="userid" id="loginUserid"
										size="20" autocomplete="off" />
									</td>
								</tr>
								<tr>
									<td>암호</td>
									<td></td>
									<td>
										<input type="password" name="pwd" id="loginPwd"
										size="20" />
									</td>
								</tr>

								<%-- ==== 아이디 찾기, 비밀번호 찾기 ==== --%>
								<tr>
									<td colspan="3" style="padding:3% 0.5%;font-size:13px;">
										<a href="<%= ctxPath %>/login/idFind.do" style="cursor: pointer;">아이디찾기</a> 
										/
										<a href="<%= ctxPath %>/login/passwordFind.do" style="cursor: pointer;">비밀번호찾기</a>
										<a href="<%= ctxPath %>/user/userRegister.do" style="margin-left:30px;">회원가입</a>
									</td>
								</tr>

								<tr>
									<td colspan="3">
									<input type="checkbox" id="saveid"
										name="saveid" />&nbsp;
										<label for="saveid">아이디저장</label>
										<button type="button" id="btnSubmit"
											class="btn btn-dark btn-sm ml-3">로그인
										</button>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
				</div>

				</div>
         <%-- 로그인 끝 --%>
         <div id="sidecontent" style="text-align: left; padding: 20px;"></div>
       </div>