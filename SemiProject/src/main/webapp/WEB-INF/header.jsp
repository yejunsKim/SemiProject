<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
%>
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
});
</script>

</head>
	<body>
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
								<tr class="trTab">
									<td>ID</td>
									<td></td>
									<td>
									   <input type="text" name="userid" id="loginUserid"
										size="20" autocomplete="off" />
									</td>
								</tr>
								<tr class="trTab">
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

				<%-- 로그인 끝 --%>
				<div id="sidecontent" style="text-align: left; padding: 20px;"></div>
			</div>