<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<!DOCTYPE html>

<html>
<!-- Required meta tags -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 

<!-- Font Awesome 6 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css">

<!-- 직접 만든 CSS -->
<%-- <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/template.css" />
 --%>
<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

<%-- jQueryUI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<%-- user폴더 내부의 js --%>
<script type="text/javascript" src="<%= ctxPath%>/js/user/register.js"></script>

<%-- css 주기 --%>

<head>
<style type="text/css">
@charset "UTF-8";

div.container {width:100%;max-width:initial;}
form[name="registerForm"]{max-width:1200px;margin:0 auto;}
div#registerForm {
	text-align: center;
}

table#tblUserRegister {
 /*	border: solid 1px red; */ 
	width: 93%;
	margin: 1% auto;
}

table#tblUserRegister th {
    border: solid 1px gray; 
}
table#tblUserRegister th {
	height: 60px;
	background-color: silver;
	font-size: 14pt;
}

table#tblUserRegister td {
	line-height: 200%;
	padding: 1.2% 0;
	color: white;
}

span.star {
	color: red;
	font-weight: bold;
	font-size: 13pt;
}

table#tblUserRegister > tbody > tr > td:first-child {
	width: 20%;
	font-weight: bold;
	text-align: left;
}

table#tblUserRegister > tbody > tr > td:nth-child(2) {
	width: 80%;
	text-align: left;
}

img#postcodeSearch {
	border: solid 1px gray;
	border-radius: 5px;
	font-size: 8pt;
	display: inline-block;
	text-align: center;
	margin-left: 10px;
	cursor: pointer;
}

span#idCheck, #emailCheck {
	border: solid 1px gray;
	border-radius: 5px;
	font-size: 8pt;
	display: inline-block;
	width: 80px;
	height: 30px;
	text-align: center;
	margin-left: 10px;
	cursor: pointer;
}
</style>
</head>
<jsp:include page="../header2.jsp" />

<div class="container" id="registerDiv" style="background: black;margin-top: 3%">
	<form name="registerForm">
		<table id="tblUserRegister">
				<thead>
					<tr>
					<br>
						<th colspan="2" style="text-align: center; color: #b1ab40; size: 20px; background: none; border: 0px; font-family: italic">
							Perfume Arena 에 오신 걸 환영합니다
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="3" style="line-height: 100%"></td>
					<tr>
					
					<tr>
						<td>성명&nbsp; <span class="star">*</span> </td>
						<td>
							<input type="text" id="name" name='name' maxlength="30" class="requiredInfo">
							<span class="error">필수 입력 사항입니다</span>
						</td>
					<tr>
					<tr>
						<td>아이디&nbsp; <span class="star">*</span> </td>
						<td>
					 		<input type="text" id="id" name='id' maxlength="30" class="requiredInfo">
							<%-- 아이디 중복체크 --%>
							<span id="idCheck">아이디중복확인</span>
	                        <span id="idCheckResult"></span>
							<span class="error">필수 입력 사항입니다</span>
					</td>
					<tr>
						<td>비밀번호&nbsp; <span class="star">*</span></td>
						<td>
							<input type="password" id="password" name='password' maxlength="30" class="requiredInfo">
							<span class="error">영문자,숫자,특수기호가 혼합된 8~15 비밀번호를 입력해주세요</span>
					</td>
					</tr>
						<td>비밀번호 확인&nbsp;  <span class="star">*</span></td>
						<td>
							<input type="password" id="passwordCheck" maxlength="30" class="requiredInfo">
							<span class="error">비밀번호가 일치하지 않습니다</span>
					</td>
					<tr>
						<td>이메일&nbsp; <span class="star">*</span></td>
						<td>
							<input type="text" id="email" name='email' maxlength="30" class="requiredInfo">
							<%-- 이메일 중복체크 --%>
                       		<span id="emailCheck">이메일중복확인</span>
                   			<span id="emailCheckResult"></span>
							<span class="error">이메일 형식에 맞지 않습니다</span>
					</td>
					</tr>
						<td>연락처&nbsp; <span class="star">*</span></td>
						<td>
					 	   <input type="text" name="mobileHead" id="hp1" name='hp1' size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp; 
	                       <input type="text" name="mobileMiddle" id="hp2" name='hp2' size="6" maxlength="4" />&nbsp;-&nbsp;
	                       <input type="text" name="mobileLast" id="hp3" name='hp3' size="6" maxlength="4" />    
	                       <span class="error">휴대폰 형식이 아닙니다.</span>
					</td>
					<tr>
	                    <td>우편번호</td>
	                    <td>
	                       <input type="text" name="postcode" id="postcode" size="6" maxlength="5" />&nbsp;&nbsp;
	                       <%-- 우편번호 찾기 --%>
	                       <img src="<%= ctxPath%>/images/find_postcode.gif" width="6%" id="postcodeSearch" />
	                       <span class="error">우편번호 형식에 맞지 않습니다.</span>
                	    </td>
               		</tr>
					<tr>
						<td>주소&nbsp;</td>
						<td>
	                       <input type="text" name="address" id="address" size="40" maxlength="200" placeholder="주소" /><br>
                   		   <input type="text" name="detailAddress" id="detailAddress" size="40" maxlength="200" placeholder="상세주소" />
                   		   	&nbsp;
                   		   <input type="text" name="extraAddress" id="extraAddress" size="40" maxlength="200" placeholder="참고항목" />            
                     		<span class="error">주소를 입력하세요.</span>
                		</td>
					</tr>
					<tr>
	                    <td colspan="2" class="text-center">
	                       <input type="button" class="btn btn-success btn-lg mr-5" value="가입하기" onclick="register()" />
	                       <input type="reset"  class="btn btn-danger btn-lg" value="취소하기" onclick="reset()" />
	                    </td>
              		</tr>
					
				</tbody>
		
		</table>
	</form>

</div>
	
</html>
</div>
<jsp:include page="../footer.jsp" />
