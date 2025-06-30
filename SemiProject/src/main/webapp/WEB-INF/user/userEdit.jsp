<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>     
    
<% String ctxPath = request.getContextPath(); %>

   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>•	Edit Profile    •</title>

<%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%-- Bootstrap CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 

<%-- 직접 만든 CSS --%>

<%-- Optional JavaScript --%>
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/user/userEdit.js"></script>
<%-- user폴더 내부의 js --%>

<%-- css 주기 --%>

<head>
<style type="text/css">
@charset "UTF-8";

div.container {width:100%;max-width:initial;}
form[name="editForm"]{max-width:1200px;margin:0;}
div#editForm {
	text-align: center;
}

table#tblUserEdit {
 /*	border: solid 1px red; */ 
	width: 93%;
	margin: 1% auto;
}

table#tblUserEdit th {
    border: solid 1px gray; 
}
table#tblUserEdit th {
	height: 60px;
	background-color: silver;
	font-size: 14pt;
}

table#tblUserEdit td {
	line-height: 200%;
	padding: 1.2% 0;
	color: white;
}

span.star {
	color: red;
	font-weight: bold;
	font-size: 13pt;
}

table#tblUserEdit > tbody > tr > td:first-child {
	width: 20%;
	font-weight: bold;
	text-align: left;
}

table#tblUserEdit > tbody > tr > td:nth-child(2) {
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

<div class="container" id="editDiv" style="background: black;">
	<form name="editForm">
		<table id="tblUserEdit">
			<thead>
				<tr>
				<br>
					<th colspan="2" style="text-align: center; color: #b1ab40; size: 20px; background: none; border: 0px; font-family: italic">
						:: ${sessionScope.loginUser.id}님의 Profile ::
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
                        <input type="hidden" name="id" value="${sessionScope.loginUser.id}" />
						<input type="text" id="name" name='name' maxlength="30" class="requiredInfo" value="${sessionScope.loginUser.name}">
						<span class="error">필수 입력 사항입니다</span>
					</td>
				<tr>
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
                       <input type="text" name="email" id="email" maxlength="60" class="requiredInfo" value="${sessionScope.loginUser.email}" /> 
						<%-- 이메일 중복체크 --%>
                   		<span id="emailCheck">이메일중복확인</span>
                		<span id="emailCheckResult"></span>
						<span class="error">이메일 형식에 맞지 않습니다</span>
				</td>
				</tr>
					<td>연락처&nbsp; <span class="star">*</span></td>
					<td>
				 	   <input type="text" id="hp1" name='hp1' size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp; 
				       <input type="text" name="hp2" id="hp2" size="6" maxlength="4" value="${fn:substring(sessionScope.loginUser.mobile, 3, 7)}" />&nbsp;-&nbsp; 
                       <input type="text" name="hp3" id="hp3" size="6" maxlength="4" value="${fn:substring(sessionScope.loginUser.mobile, 7, 11)}" />    
                       <span class="error">휴대폰 형식이 아닙니다.</span>
				</td>
				<tr>
                    <td>우편번호</td>
                    <td>
                       <input type="text" name="postcode" id="postcode" size="6" maxlength="5" value="${sessionScope.loginUser.postcode}" />&nbsp;&nbsp;
                       <%-- 우편번호 찾기 --%>
                       <img src="<%= ctxPath%>/images/find_postcode.gif" width="6%" id="postcodeSearch" />
                       <span class="error">우편번호 형식에 맞지 않습니다.</span>
               	    </td>
              		</tr>
				<tr>
					<td>주소&nbsp;</td>
					<td>
                       <input type="text" name="address" id="address" size="40" maxlength="200" placeholder="주소"  value="${sessionScope.loginUser.address}" /><br>
                  		   <input type="text" name="detailAddress" id="addressDetail" size="40" maxlength="200" placeholder="상세주소" value="${sessionScope.loginUser.addressDetail}"/>
                  		   	&nbsp;
                  		   <input type="text" name="extraAddress" id="addressExtra" size="40" maxlength="200" placeholder="참고항목" value="${sessionScope.loginUser.addressExtra}"/>            
                    		<span class="error">주소를 입력하세요.</span>
               		</td>
				</tr>
				<tr>
                    <td colspan="2" class="text-center">
                       <input type="button" class="btn btn-success btn-lg mr-5" value="수정하기" onclick="edit()" />
                       <input type="reset"  class="btn btn-danger btn-lg" value="취소하기" onclick="reset()" />
                    </td>
           		</tr>
		
		</table>
	</form>

</div>
	
</html>
</div>
