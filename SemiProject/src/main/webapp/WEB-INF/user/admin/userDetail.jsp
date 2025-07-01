<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="../../headerTest.jsp" />   

<style type="text/css">

  table.table-bordered > tbody > tr > td:nth-child(1) {
  	  width: 25%;
  	  font-weight: bold;
  	  text-align: right;
  }
  
</style>

<script type="text/javascript">
  
  $(function(){
	
	  $("div#smsResult").hide();
	  
	  $('button#btnSend').click(()=>{
		  
	   // console.log( $('input#reservedate').val() + " " + $('input#reservetime').val() );
		  // 2025-06-18 09:30
		  
		  let reservedate = $('input#reservedate').val();
		  reservedate = reservedate.split("-").join("");
		  // ["2025","06","18"] ==> "20250618"
		  
		  let reservetime = $('input#reservetime').val();
		  reservetime = reservetime.split(":").join("");
		  
		  const datetime = reservedate + reservetime;
	  //  console.log(datetime);
		  // 202506180930
		 
		  let dataObj;
		  
		  if( reservedate == "" || reservetime == "" ) {
			  // 문자를 바로 보내기인 경우
			  dataObj = {"mobile":"${requestScope.uservo.mobile}",
					     "smsContent":$('textarea#smsContent').val()};
		  }
		  else {
			  // 예약문자 보내기인 경우 
			  dataObj = {"mobile":"${requestScope.uservo.mobile}",
					     "smsContent":$('textarea#smsContent').val(),
					     "datetime":datetime};
		  }
		  
		  $.ajax({
			  url:"${pageContext.request.contextPath}/user/admin/smsSend.do",
			  type:"get",
			  data:dataObj,
			  dataType:"json",
			  success:function(json){
				  // console.log(JSON.stringify(json));
				  // {"group_id":"R2Gtyx5FiTezccud","success_count":1,"error_count":0}
				  
				  if(json.success_count == 1) {
					  $("div#smsResult").html("<span style='color:red; font-weight:bold;'>문자전송이 성공되었습니다.^^</span>"); 
				  }
				  else if(json.error_count != 0) {
					  $("div#smsResult").html("<span style='color:red; font-weight:bold;'>문자전송이 실패되었습니다.ㅜㅜ</span>"); 
				  }
				  
				  $("div#smsResult").show();
				  $('textarea#smsContent').val("");
			  },
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		  });
		  
		  
	  });
	  
  });// end of $(function(){})----------------------------

</script>

<div class="container">

     <c:if test="${empty requestScope.uservo}">
        <div class="text-center h4 my-5">존재하지 않는 회원입니다.</div>
     </c:if>
     
     <c:if test="${not empty requestScope.uservo}">
        <p class="text-center h3 my-5">::: ${requestScope.uservo.name} 님의 회원 상세정보 :::</p>
        
        <table class="table table-bordered" style="width: 60%; margin: 0 auto;">
           <tr>
              <td>아이디&nbsp;:&nbsp;</td>
              <td>${requestScope.uservo.id}</td>
           </tr>
           <tr>
              <td>회원명&nbsp;:&nbsp;</td>
              <td>${requestScope.uservo.name}</td>
           </tr>
           <tr>
              <td>이메일&nbsp;:&nbsp;</td>
              <td>${requestScope.uservo.email}</td>
           </tr>
           <tr>
              <td>휴대폰&nbsp;:&nbsp;</td>
              <c:set var="mobile" value="${requestScope.uservo.mobile}" />
              <td>${fn:substring(mobile, 0, 3)}-${fn:substring(mobile, 3, 7)}-${fn:substring(mobile, 7, 11)}</td>  
           </tr>
           <tr>
              <td>우편번호&nbsp;:&nbsp;</td>
              <td>${requestScope.uservo.postcode}</td>
           </tr>
           <tr>
              <td>주소&nbsp;:&nbsp;</td>
              <td>${requestScope.uservo.address}&nbsp;
                  ${requestScope.uservo.addressDetail}&nbsp;
                  ${requestScope.uservo.addressExtra}
              </td>
           </tr>
		   <tr>
		      <td>포인트&nbsp;:&nbsp;</td>
		      <td>
		         <fmt:formatNumber value="${requestScope.uservo.point}" pattern="###,###" />&nbsp;POINT 
		      </td>
		   </tr>
		   <tr>
		      <td>가입일자&nbsp;:&nbsp;</td>
		      <td>${requestScope.uservo.registerday}</td>
		   </tr>
        </table>
        
        <%-- ==== 휴대폰 SMS(문자) 보내기 ==== --%>
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
        
     </c:if>

     <div class="text-center mb-5">
       <button type="button" class="btn btn-secondary" onclick="javascript:location.href='UserList.do'">회원목록[처음으로]</button> 
       <button type="button" class="btn btn-success mx-5" onclick="javascript:history.back()">회원목록[history.back()]</button>
       <button type="button" class="btn btn-success mx-5" onclick="javascript:location.href='${requestScope.referer}'">회원목록[검색된결과]</button>  
     </div>
     
</div>

<jsp:include page="../../footer.jsp" />









  