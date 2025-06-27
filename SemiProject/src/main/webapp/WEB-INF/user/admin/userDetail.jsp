<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- <jsp:include page="../../header2.jsp" />   --%> 

<style type="text/css">

  table.table-bordered > tbody > tr > td:nth-child(1) {
  	  width: 25%;
  	  font-weight: bold;
  	  text-align: right;
  }
  
</style>



<div class="container">

     <c:if test="${empty requestScope.userVO}">
        <div class="text-center h4 my-5">존재하지 않는 회원입니다.</div>
     </c:if>
     
     <c:if test="${not empty requestScope.userVO}">
        <p class="text-center h3 my-5">::: ${requestScope.userVO.name} 님의 회원 상세정보 :::</p>
        
        <table class="table table-bordered" style="width: 60%; margin: 0 auto;">
           <tr>
              <td>아이디&nbsp;:&nbsp;</td>
              <td>${requestScope.userVO.id}</td>
           </tr>
           <tr>
              <td>회원명&nbsp;:&nbsp;</td>
              <td>${requestScope.userVO.name}</td>
           </tr>
           <tr>
              <td>이메일&nbsp;:&nbsp;</td>
              <td>${requestScope.userVO.email}</td>
           </tr>
           <tr>
              <td>휴대폰&nbsp;:&nbsp;</td>
              <c:set var="mobile" value="${requestScope.userVO.mobile}" />
              <td>${fn:substring(mobile, 0, 3)}-${fn:substring(mobile, 3, 7)}-${fn:substring(mobile, 7, 11)}</td>  
           </tr>
           <tr>
              <td>우편번호&nbsp;:&nbsp;</td>
              <td>${requestScope.userVO.postcode}</td>
           </tr>
           <tr>
              <td>주소&nbsp;:&nbsp;</td>
              <td>${requestScope.userVO.address}&nbsp;
                  ${requestScope.userVO.detailaddress}&nbsp;
                  ${requestScope.userVO.extraaddress}
              </td>
           </tr>

		   <tr>
		      <td>포인트&nbsp;:&nbsp;</td>
		      <td>
		         <fmt:formatNumber value="${requestScope.userVO.point}" pattern="###,###" />&nbsp;POINT 
		      </td>
		   </tr>
		   <tr>
		      <td>등급&nbsp;:&nbsp;</td>
		      <td>${requestScope.userVO.grade}</td>
		   </tr>
		   <tr>
		      <td>가입일자&nbsp;:&nbsp;</td>
		      <td>${requestScope.userVO.registerday}</td>
		   </tr>
        </table>
        <%-- 
        ==== 휴대폰 SMS(문자) 보내기 ====
		<div class="border my-5 text-center" style="width: 60%; margin: 0 auto;">
		  	<p class="h5 bg-info text-white">
		  	  &gt;&gt;&nbsp;&nbsp;휴대폰 SMS(문자) 보내기 내용 입력란&nbsp;&nbsp;&lt;&lt;
		  	</p>
		  	<div class="mt-4 mb-3">
		  		<span class="bg-danger text-white" style="font-size: 14pt;">문자발송 예약일자</span>
		  		<input type="date" id="reservedate" class="mx-2" />
		  		<input type="time" id="reservetime" />
		  	</div>
		  	<div style="display: flex;">
		  	   <div style="border: solid 0px red; width: 81%; margin: auto;">
		  	      <textarea rows="4" id="smsContent" style="width: 100%;"></textarea>
		  	   </div>
		  	   <div style="border: solid 0px blue; width: 19%; margin: auto;">
		  	      <button id="btnSend" class="btn btn-secondary">문자전송</button>
		  	   </div>
		  	</div>
		  	<div id="smsResult" class="p-3"></div>
		</div>
         --%>
     </c:if>

     <div class="text-center mb-5">
       <button type="button" class="btn btn-secondary" onclick="javascript:location.href='memberList.up'">회원목록[처음으로]</button> 
       <button type="button" class="btn btn-success mx-5" onclick="javascript:history.back()">회원목록[뒤로!!]</button>
       <button type="button" class="btn btn-success mx-5" onclick="javascript:location.href='${requestScope.referer}'">회원목록[검색된결과]</button>  
     </div>
     
</div>

<%-- <jsp:include page="../../footer.jsp" /> --%>
