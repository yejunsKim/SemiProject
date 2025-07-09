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

<script type="text/javascript">
function editInfo(id, ctxPath) {

	   const url = `<%=ctxPath%>/user/userEdit.do?id=${sessionScope.loginUser.id}`;
	   
	   // 너비 800, 높이 680 인 팝업창을 화면 가운데 위치시키기
	   const width = 800;
	   const height = 680;
	   
	   const left = Math.ceil((window.screen.width - width)/2);  // 정수로 만듬 
	   const top = Math.ceil((window.screen.height - height)/2); // 정수로 만듬
	   window.open(url, "editInfo", `left=${left}px, top=${top}px, 
			   width=${width}px, height=${height}px`);
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
    position:relative;
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
.headerNav {position:fixed;top:0;background-color:transparent;z-index:15;width:100%;padding:10px 25px;
-webkit-transition: background-color .3s ease-in;
transition: background-color .3s ease-in;}
.headerUl {display:flex;justify-content:space-between;align-items:center;}
.loginList {max-width:270px;width:100%;background-color:#fff;position:absolute;top:50%;left:50%;height:330px;padding:20px;box-shadow: 1px 3px 3px 2px #6f6363;border-radius:5px;transform:translate(-50%,-50%);z-index:15;}
.loginList .loginBoxx .loginBTN {width:100%;border:0;border-radius:30px;background-color:#2c59e5;padding:15px 25px;margin-top:5px;color:#000;}
.loginList .loginA {width:100%;display:flex;justify-content:space-between;align-items:center;margin:15px 0;}
.loginList .loginA input {width:150px;}
.form-outline {position:relative;}
.form-control {max-width:150px;width:100%;padding:0 35px;}
.loginBox {z-index:20;}
.trTab {padding:10px 0;display:flex;justify-content:space-between;align-items:center;}

.userTab-wrapper {position: relative;overflow: hidden;height: 880px;width: 250px;position: fixed;top: 63px;right: 0;z-index: 0;}
.userTab-wrapper.wrapperOpen {z-index:21;} 
.userTab {height: 100%;width: 250px;background: rgba(255, 255, 255, 0.6);position: absolute;right: -250px; top: 0;transition: right 0.9s ease;border-left: 1px solid #ddd;border-top:1px solid #ddd;z-index: 11;}
.userTab.userTab-open {right: 0;}

.userTab p a {padding:40px 13px;border-bottom:1px solid #ddd;cursor:pointer;display:block;text-align:center;}
.userTab p:hover, .userTab p:hover a {background-color:#000;color:#fff}
input#searchID {border-radius:30px;padding:5px 20px;border:1px solid #ddd;}
.fa-search {position:absolute;top:11px;right:20px;left:initial;} 
.btnSubmit {background-color:transparent;border:0;position:absolute;right:5px;top:7px;width:50px;height:21px;}

.pixel-crown {
    display: inline-block;
    width: 24px;
    height: 20px;
    position: relative;
    margin-left: 8px;
    image-rendering: pixelated;
}

.pixel-crown::before {
    content: "";
    position: absolute;
    width: 100%;
    height: 100%;
    background-size: 24px 20px;
    background-repeat: no-repeat;
}

.bronze::before {
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='20' viewBox='0 0 24 20'%3E%3Cpath fill='%23cd7f32' d='M12,0 L8,6 L0,4 L4,10 L0,16 L8,14 L12,20 L16,14 L24,16 L20,10 L24,4 L16,6 L12,0 Z'/%3E%3C/svg%3E");
}

.silver::before {
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='20' viewBox='0 0 24 20'%3E%3Cpath fill='%23c0c0c0' d='M12,0 L8,6 L0,4 L4,10 L0,16 L8,14 L12,20 L16,14 L24,16 L20,10 L24,4 L16,6 L12,0 Z'/%3E%3C/svg%3E");
}

.gold::before {
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='20' viewBox='0 0 24 20'%3E%3Cpath fill='%23ffd700' d='M12,0 L8,6 L0,4 L4,10 L0,16 L8,14 L12,20 L16,14 L24,16 L20,10 L24,4 L16,6 L12,0 Z'/%3E%3C/svg%3E");
}

.vip::before {
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='20' viewBox='0 0 24 20'%3E%3ClinearGradient id='grad' x1='0%25' y1='0%25' x2='100%25' y2='100%25'%3E%3Cstop offset='0%25' stop-color='%23ff00ff' /%3E%3Cstop offset='100%25' stop-color='%2300ffff' /%3E%3C/linearGradient%3E%3Cpath fill='url(%23grad)' d='M12,0 L8,6 L0,4 L4,10 L0,16 L8,14 L12,20 L16,14 L24,16 L20,10 L24,4 L16,6 L12,0 Z'/%3E%3C/svg%3E");
}
.grade-name {
    margin-top: 16px;
    padding: 8px 16px;
    border-radius: 9999px;
    text-align: center;
    font-size: 14px;
    font-weight: bold;
    color: white;
    width: fit-content;
}

/* 각 등급별 배경색상 */
.bronze-name {
    background-color: #cd7f32;
}
.silver-name {
    background-color: #c0c0c0;
}
.gold-name {
    background-color: #ffd700;
}
.vip-name {
    background: linear-gradient(45deg, #ff00ff, #00ffff);
}

</style>
<script type="text/javascript">
$(function () {
    $('div.loginBox').hide();

    const loginBox = $('div.loginBox');
    const adminTabWrapper = $('.adminTab-wrapper');
    const adminTab = $('.adminTab');
    const userTabWrapper = $('.userTab-wrapper');
    const userTab = $('.userTab');

    let openMenu = null; 
    let isTransitioning = false;

 
    function closeAllMenus(callback) {
        if (openMenu === "login") {
            loginBox.fadeOut(200, () => {
                openMenu = null;
                callback && callback();
            });
        } else if (openMenu === "admin") {
            adminTab.removeClass('adminTab-open');
            adminTab.one('transitionend', function () {
                adminTabWrapper.removeClass('wrapperOpen').css({ zIndex: 0, right: '-250px' });
                openMenu = null;
                callback && callback();
            });
        } else if (openMenu === "user") {
            userTab.removeClass('userTab-open');
            userTab.one('transitionend', function () {
                userTabWrapper.removeClass('wrapperOpen').css('z-index', 0);
                openMenu = null;
                callback && callback();
            });
        } else {
            callback && callback();
        }
    }

    // 로그인 박스 열기/닫기
    $(document).on("click", ".logins", function () {
        if (isTransitioning) return;
        isTransitioning = true;

        if (openMenu === "login") {
            loginBox.fadeOut(200, () => {
                openMenu = null;
                isTransitioning = false;
            });
        } else {
            closeAllMenus(() => {
                loginBox.fadeIn(200, () => {
                    openMenu = "login";
                    isTransitioning = false;
                });
            });
        }
    });

    const loginId = "${sessionScope.loginUser.id}";

    // === 관리자 메뉴 ===
    if (loginId === 'admin') {
        let isAdminOpen = false;
        $('.adminFunc').on('click', function () {
            if (isTransitioning) return;
            isTransitioning = true;

            if (openMenu === "admin") {
                adminTab.removeClass('adminTab-open');
                adminTab.one('transitionend', function () {
                    adminTabWrapper.removeClass('wrapperOpen').css({ zIndex: 0, right: '-250px' });
                    openMenu = null;
                    isTransitioning = false;
                });
            } else {
                closeAllMenus(() => {
                    adminTabWrapper.addClass('wrapperOpen').css({ zIndex: 21, right: '0' });
                    adminTab.addClass('adminTab-open');
                    openMenu = "admin";
                    isTransitioning = false;
                });
            }
        });
    }

    // === 일반 사용자 메뉴 ===
    else {
        $('.userFunc').on('click', function () {
            if (isTransitioning) return;
            isTransitioning = true;

            if (openMenu === "user") {
                userTab.removeClass('userTab-open');
                userTab.one('transitionend', function () {
                    userTabWrapper.removeClass('wrapperOpen').css('z-index', 0);
                    openMenu = null;
                    isTransitioning = false;
                });
            } else {
                closeAllMenus(() => {
                    userTabWrapper.addClass('wrapperOpen').css('z-index', 21);
                    userTab.addClass('userTab-open');
                    openMenu = "user";
                    isTransitioning = false;
                });
            }
        });
    }

    // 로그인 저장 아이디 복원
    if (${empty sessionScope.loginuser}) {
        const loginid = localStorage.getItem('saveid');
        if (loginid != null) {
            $('input:text[name="id"]').val(loginid);
            $('#saveid').prop("checked", true);
        }
    }

    // 스크롤 시 header 배경 조절
    $(window).scroll(function () {
        const scrollTop = $(window).scrollTop();
        if (scrollTop > 30) {
            $('.headerNav').css('backgroundColor', 'rgba(255,255,255,0.9)');
        } else {
            $('.headerNav').css('backgroundColor', 'transparent');
        }
    });
});

function SearchItems() {
    const searchID = $('input[name="searchID"]').val().trim();

    if (searchID === "") {
        alert("검색어를 입력하세요.");
        return false;
    }

    const frm = document.searchFrm;
    frm.action = "/SemiProject/item/searchResult.do";
    frm.method = "get";
    frm.submit();
    return false; // 폼 기본 제출 막기
}


</script>

</head>
	<body>
		<div class="userTab-wrapper">
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
		</div>
			<div class="loginBox" style="height: 200px; text-align: left; padding: 11px; border-radius: 15px">
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
										<input type="password" name="password" id="loginPwd" size="20" />
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
				        <th id="loginUserId" colspan="3" style="text-align:center; font-size:18px;padding-top:10px;"> 
				          <c:choose>
							  <c:when test="${sessionScope.loginUser.grade eq 'bronze'}">
							    <span id="loginUserId" class="grade-name bronze-name">${sessionScope.loginUser.id}</span>
							  </c:when>
							  <c:when test="${sessionScope.loginUser.grade eq 'silver'}">
							    <span id="loginUserId" class="grade-name silver-name">${sessionScope.loginUser.id}</span>
							  </c:when>
							  <c:when test="${sessionScope.loginUser.grade eq 'gold'}">
							    <span id="loginUserId" class="grade-name gold-name">${sessionScope.loginUser.id}</span>
							  </c:when>
							  <c:when test="${sessionScope.loginUser.grade eq 'vip'}">
							    <span id="loginUserId" class="grade-name vip-name">${sessionScope.loginUser.id}</span>
							  </c:when>
						  </c:choose>
				        </th>
				      </tr>
				    </thead>
				    <tbody>
				      <tr>
				        <td colspan="3" style="padding-top:20px;"> 
				          <span style="font-weight:bold;">${sessionScope.loginUser.name}님</span>
				          &nbsp;[<a href="javascript:editInfo('${sessionScope.loginUser.id}', '<%=ctxPath %>')" style="color: #f43cff;">나의정보변경</a>]
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
						    <span style="font-weight: bold;">등급&nbsp;:</span>
						    <span style="display: inline-flex; align-items: center;">
						      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${sessionScope.loginUser.grade}
						      <c:choose>
						        <c:when test="${sessionScope.loginUser.grade eq 'bronze'}">
						          <span class="pixel-crown bronze"></span>
						        </c:when> 
						        <c:when test="${sessionScope.loginUser.grade eq 'silver'}">
						          <span class="pixel-crown silver"></span>
						        </c:when>
						        <c:when test="${sessionScope.loginUser.grade eq 'gold'}">
						          <span class="pixel-crown gold"></span>
						        </c:when>
						        <c:when test="${sessionScope.loginUser.grade eq 'vip'}">
						          <span class="pixel-crown vip"></span>
						        </c:when>
						      </c:choose>
						    </span>
						  </td>
					  </tr>


				      <tr>
				        <td colspan="3" style="padding-top:10px;">
				          <c:if test="${sessionScope.loginUser.id ne 'admin'}">
				          <span style="font-weight: bold;"><a href="<%=ctxPath %>/item/orderList.do" style="color: #666363;">주문목록 보기</a></span>
				          </c:if>
				          &nbsp;&nbsp;&nbsp;&nbsp;<span><button type="button" class="btn btn-danger btn-sm" onclick="javascript:LogOut('<%=ctxPath%>')">Logout</button></span>
				        </td>
				      </tr>
				      <tr>
				        <td colspan="3" style="padding-top:10px;">
				          
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
		 		<div style="width:550px;display:flex;justify-content:space-between;align-items:center;">
			 		<li>
				 	  <div class="input-group">
						<form name="searchFrm" id="searchFrm" onsubmit="return SearchItems();" style="display:flex;">
						  <input type="text" name="searchID" id="searchID" placeholder="검색어를 입력하세요" />
						  <i class="fas fa-search"></i>
						   <button type="submit" class="btnSubmit"></button>
						</form>
					  </div>
					</li>
					<c:if test="${empty sessionScope.loginUser}">
					<li class="logins" style="border:1px solid #bbb;padding:10px 25px;border-radius:30px;background:#fff;color:#000;cursor:pointer;">로그인</li>
					</c:if>
					
					<c:if test="${not empty sessionScope.loginUser && sessionScope.loginUser.id == 'admin'}">
						<%-- header아이디에 따라 관리자 창 보이는곳 수정시작 --%>
						<jsp:include page="headerAdmin.jsp" />
				 	 	<%-- header아이디에 따라 관리자 창 보이는곳 수정 끝 --%>
			 	 	</c:if>
			 	 	
			 	 	<c:if test="${not empty sessionScope.loginUser && sessionScope.loginUser.id != 'admin'}">
						<%-- header아이디에 따라 관리자 창 보이는곳 수정시작 --%>
						<li><a href="<%= ctxPath%>/item/cartList.do"><img src="/SemiProject/images/header/cart.png" ></a></li>						

						<li class="logins" id="loginUser"style="font-size:19pt;cursor:pointer;"><i class="fas fa-user-circle mr-2"></i></li>
						<li class="userFunc" style="font-size:19pt;cursor:pointer;"><i class="fa-solid fa-bars"></i></li>
				 	 	<%-- header아이디에 따라 관리자 창 보이는곳 수정 끝 --%>
			 	 	</c:if>
			 	</div>
			</ul>
		 </nav> 
          
       </div>
	</div>