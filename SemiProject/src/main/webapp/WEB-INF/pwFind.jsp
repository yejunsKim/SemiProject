<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
  String ctxPath = request.getContextPath(); 
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/css/find/pwFind.css" />
<script type="text/javascript">
$(function(){

	const method = "${requestScope.method}";

	if(method == "GET") {
		$('div#div_findResult').prop('hidden', true);
		
	} 
	else {
		$('div#div_findResult').prop('hidden', false);
		$('input:text[name="id"]').val("${requestScope.id}");
		$('input:text[name="email"]').val("${requestScope.email}");
		<%-- idfind class파일에서 setAttribute에서 name과 email을 넘겨줘서 여기서 쓸 수 있었다.--%>
	} 

	
	$('button.btn-success').click(function(){
		goFind();
	});
	
	$('input:text[name="email"]').bind('keyup',function(e){
		if(e.keyCode == 13){
			goFind();
		}
	});
	
}); 

 function pwFind() {
	
	const id = $('input:text[name="id"]').val().trim();
	if (id == ""){
		alert('아이디를 입력하십시오.');
		return; 
	}
	
	const email = $('input:text[name="email"]').val();
	
	const regExp_email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	
	if ( !regExp_email.test(email) ){
		// 이메일이 정규표현식에 위배된 경우
		alert('이메일을 올바르게 입력하십시오.');
		return; // goFind() 함수종료
	}
	
	// 다 올바른 경우
	const frm = document.pwFindFrm;
	frm.action = "<%=ctxPath%>/pwFind.do";
	frm.method = "POST";
	frm.submit();
  }

	function form_reset_empty() {
		document.querySelector('form[name="pwFindFrm"]').reset();
		$('div#div_findResult').empty();
	<%-- 해당 태그내에 값들을 싹 비우는것.--%>
	}
</script>

<jsp:include page="header.jsp" />

   <div class="pwFindWrap" id="pwFindWrap">
	 <form id="pwFindFrm" name="pwFindFrm">
			<div class="pwBox">
				<p>아이디</p>
				<input type="text" id="id" name="id">
			</div>
		
			<div class="pwBox">
				<p>이메일</p>
				<input type="text" id="email" name="email">
			</div>
			
			<div class="submitBtn">
				<button type="button" class="btn btn-success" onclick="pwFind()">찾기</button>
			</div>
			
			<div id="div_findResult">${requestScope.n}</div>
			<c:if test="${requestScope.n == 1}">
				<div>
					<p>인증코드가 ${requestScope.email} 로 발송되었습니다.<br> 인증코드를 입력해주세요</p>
					<input type="text" name="pri" id="pri" val="인증코드를 입력해주세요">
					<button type="button" class="btn btn-success" onclick="goSubmit()">인증하기</button>
				</div>
			</c:if>
			<c:if test="${requestScope.n == 0}"> 없습니다.</c:if>
	   </form>
	</div>

</div>
<jsp:include page="footer.jsp" />