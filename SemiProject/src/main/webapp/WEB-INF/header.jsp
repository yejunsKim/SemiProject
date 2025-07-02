<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<!--  로그인 part js -->
<script type="text/javascript" src="<%=ctxPath%>/js/login/login.js"></script>

<%-- jQueryUI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>

<script>
function editInfo(id, ctxPath) {


	   const url = `${ctxPath}/user/userEdit.do?id=${id}`;
	   
	   // 너비 800, 높이 680 인 팝업창을 화면 가운데 위치시키기
	   const width = 800;
	   const height = 680;
	   
	   const left = Math.ceil((window.screen.width - width)/2);  // 정수로 만듬 
	   const top = Math.ceil((window.screen.height - height)/2); // 정수로 만듬
	   window.open(url, "editInfo", 
	               `left=${left}, top=${top}, 
				    width=${width}, height=${height}`);
	
}

</script>

<style>
	/* reset.css */
html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td,
article, aside, canvas, details, embed, 
figure, figcaption, footer, header, hgroup, 
menu, nav, output, ruby, section, summary,
time, mark, audio, video {
    margin: 0;
    padding: 0;
    border: 0;
    font-size: 100%;
    font: inherit;
    vertical-align: baseline;
}
/* HTML5 display-role reset for older browsers */
article, aside, details, figcaption, figure, 
footer, header, hgroup, menu, nav, section {
    display: block;
}
body {
    line-height: 1;
}
ol, ul {
    list-style: none;
}
blockquote, q {
    quotes: none;
}
blockquote:before, blockquote:after,
q:before, q:after {
    content: '';
    content: none;
}
table {
    border-collapse: collapse;
    border-spacing: 0;
}

.container-fluid {padding:0;}
.headerNav {position:fixed;top:0;background-color:#ddd;z-index:15;width:100%;padding:10px 25px;box-shadow:2px 2px 2px #000;}
.headerUl {display:flex;justify-content:space-between;align-items:center;}
.loginList {max-width:270px;width:100%;background-color:#fff;position:absolute;top:50%;left:50%;height:330px;padding:20px;box-shadow: 1px 3px 3px 2px #6f6363;border-radius:5px;transform:translate(-50%,-50%);z-index:15;}
.loginList .loginBoxx .loginBTN {width:100%;border:0;border-radius:20px;background-color:#2c59e5;padding:15px 0;margin-top:5px;color:#fff;}
.loginList .loginA {width:100%;display:flex;justify-content:space-between;align-items:center;margin:15px 0;}
.loginList .loginA input {width:150px;}
.form-outline {position:relative;}
.form-control {max-width:150px;width:100%;padding:0 35px;}
.fa-search {position:absolute;top:12px;left:10px;} 
.loginBox {z-index:20;}
.trTab {padding:10px 0;display:flex;justify-content:space-between;align-items:center;}

.userFunc {border: 1px solid #bbb;padding: 10px 15px;border-radius: 15px;background: #8444e9;color: #fff;cursor: pointer}
.userTab {position: fixed;right:0;height:860px;background:#fff;top:65px;width:150px;border-left:1px solid #ddd;z-index:20;}
.userTab p a {padding:40px 13px;border-bottom:1px solid #ddd;cursor:pointer;display:block;text-align:center;}
.userTab p:hover, .userTab p:hover a {background-color:#000;color:#fff}

</style>
<script type="text/javascript">
$(function() {
	
	
	$('div.loginBox').hide();
    let isMenuOpen = false;
    
    $(document).on("click",".logins", function(){
    	 if (isMenuOpen) {
    		 /* $('i.fa-solid').css('transform', 'rotate(0deg)'); */
             $('div.loginBox').hide();
         } else {
        	 /* $('i.fa-solid').css('transform', 'rotate(90deg)'); */
             $('div.loginBox').show();
         }
         isMenuOpen = !isMenuOpen;
    });
    
    if( ${empty sessionScope.loginuser} ) {
		// 세션에 남겨놓은 유저가 있다면, 로컬로 남기겠다는 것.
		const loginid = localStorage.getItem('saveid');
		
		if(loginid != null) { // 만약 세션 유저의 아이디가 있다면, 
			$('input:text[name="id"]').val(loginid); //아이디 넣어주고,
			$('input#saveid').prop("checked", true); //아이디저장 체크박스는 체크로 해두기
		}
	};
	
	<%-- 유저가 로그인 후 카테고리 메뉴버튼 클릭시 메뉴 나타나도록 추가--%>
	let userOpen = sessionStorage.getItem("userOpen") === "true";

	if (userOpen) {
		$('.userTab').show();
	} else {
		$('.userTab').hide();
	}

	$(document).on("click", ".userFunc", function() {
		userOpen = !userOpen;

		if (userOpen) {
			$('.userTab').show();
		} else {
			$('.userTab').hide();
		}

		// 세션에 상태 저장입니당
		
		sessionStorage.setItem("userOpen", userOpen);
	});
	
	
	const pageurl = window.location.search
	console.log(pageurl);
	
});
</script>

</head>
	<body>
			<div class="userTab">
				<p><a href="${pageContext.request.contextPath}/item/mallHome.do">전체</a></p>
				<c:forEach var="cvo" items="${applicationScope.categoryList}" varStatus="status">
					<p class="categoryNo=${cvo.categoryNo}">
						<a href="${pageContext.request.contextPath}/item/mallHome.do?categoryNo=${cvo.categoryNo}">
						${cvo.categoryName}
						</a>
					</p>
				</c:forEach>
			</div>
			<div class="loginBox" style="height: 200px; text-align: left; padding: 11px;">
				<div class="loginTheme">
				  <c:if test="${empty sessionScope.loginUser}">
					<form name="loginForm" action="<%=ctxPath%>/login/login.do"
						method="post">
						<table id="loginTbl">
						
							<thead>
								<tr>
									<th colspan="3">LOGIN</th>
								</tr>
							</thead>

							<tbody>
								<tr class="trTab">
									<td>ID</td>
									<td></td>
									<td>
									   <input type="text" name="id" id="loginid" size="20" autocomplete="off" />
									</td>
								</tr>
								<tr class="trTab">
									<td>암호</td>
									<td></td>
									<td>
										<input type="password" name="password" id="loginPwd"
										size="20" />
									</td>
								</tr>

								
								<tr>
									<td colspan="3" style="padding:3% 0.5%;font-size:13px;">
										<a href="/SemiProject/login/idFind.do" style="cursor: pointer;">아이디찾기</a> 
										/
										<a href="/SemiProject/login/passwordFind.do" style="cursor: pointer;">비밀번호찾기</a>
										<a href="/SemiProject/user/userRegister.do" style="margin-left:30px;">회원가입</a>
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
				 </c:if>
 				 <c:if test="${not empty sessionScope.loginUser}">
				  <table id="isLogin" style="width:100%;">
				    <thead>
				      <tr>
				        <th colspan="3" style="text-align:center; font-size:18px;">
				          ${sessionScope.loginUser.id}
				        </th>
				      </tr>
				    </thead>
				    <tbody>
				      <tr>
				        <td colspan="3" style="padding-top:10px;">
				          <span style="font-weight:bold;">${sessionScope.loginUser.name}님</span>
				          &nbsp;
				          [<a href="javascript:editInfo('${sessionScope.loginUser.id}', '<%=ctxPath %>')">나의정보변경</a>]
				        </td>
				      </tr>
				      <tr>
				        <td colspan="3" style="padding-top:10px;">
				          <span style="font-weight: bold;">포인트&nbsp;:</span>
				          &nbsp;<fmt:formatNumber value="${sessionScope.loginUser.point}" pattern="###,###"/> POINT  
				        </td>
				      </tr>
				      <tr>
				        <td colspan="3" style="padding-top:10px;">
				          <button type="button" class="btn btn-danger btn-sm" onclick="javascript:LogOut('<%=ctxPath%>')">Logout</button>
				        </td>
				      </tr>
				    </tbody>
				  </table>
				</c:if>

				 
				</div>

				</div>
		 <nav class="headerNav">
		 	<ul class="headerUl">
		 		<li><a class="navbar-brand" href="/SemiProject/main.do" style="margin-right: 10%;"><img src="/SemiProject/images/header/favicon-32x32.png" /></a></li>
		 		<div style="width:420px;display:flex;justify-content:space-between;align-items:center;">
			 		<li>
				 	  <div class="input-group">
						    <div class="form-outline">
						      <i class="fas fa-search"></i>
						      <input type="search" id="form1" class="form-control" />
						   </div>
					  </div>
					</li>
					<c:if test="${empty sessionScope.loginUser}">
					<li class="logins" style="border:1px solid #bbb;padding:10px 15px;border-radius:15px;background:#6b6bf7;color:#fff;cursor:pointer;">로그인</li>
					</c:if>
					
					<c:if test="${not empty sessionScope.loginUser && sessionScope.loginUser.id == 'admin'}">
						<%-- header아이디에 따라 관리자 창 보이는곳 수정시작 --%>
						<jsp:include page="headerAdmin.jsp" />
				 	 	<%-- header아이디에 따라 관리자 창 보이는곳 수정 끝 --%>
			 	 	</c:if>

					  </div>
					</li>
					<il><img src="/SemiProject/images/header/cart.png" ></il>
 					 <c:if test="${empty sessionScope.loginUser}">
			 			<li class="logins" style="border:1px solid #bbb;padding:10px 15px;border-radius:15px;background:#6b6bf7;color:#fff;cursor:pointer;">로그인</li>
			 		</c:if>
 					 <c:if test="${not empty sessionScope.loginUser}">
			 			<li class="logins" style="border:1px solid #bbb;padding:10px 15px;border-radius:15px;background:#6b6bf7;color:#fff;cursor:pointer;">내 정보</li>
			 		</c:if>
			 	</div>
			</ul>
		 </nav> 
          
       </div>
	</div>
	
	