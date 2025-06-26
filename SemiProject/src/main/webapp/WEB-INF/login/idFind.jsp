<% 
  String ctxPath = request.getContextPath(); 
%>
<jsp:include page="../header2.jsp" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/css/find/idFind.css" />
<style>
.headerNav {position:relative;}
.btn.btn-success {width: 100%;margin: 25px 0 0;}
</style>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<script type="text/javascript" >
$(function(){

	const method = "${requestScope.method}";

	if(method == "GET") {
		$('div#div_findResult').prop('hidden', true);
		
	} 
	else {
		$('div#div_findResult').prop('hidden', false);
		$('input:text[name="name"]').val("${requestScope.name}");
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
 function goFind() {
	
	const name = $('input:text[name="name"]').val().trim();
	if (name == ""){
		alert('성명을 입력하십시오.');
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
	const frm = document.idFindFrm;
	frm.action = "<%= ctxPath%>/login/idFind.do";
	frm.method = "POST";
	frm.submit();
}

 function form_reset_empty(){
	 	document.querySelector('form[name="idFindFrm"]').reset();
	 	$('div#div_findResult').empty(); 
	 	<%-- 해당 태그내에 값들을 싹 비우는것.--%>
 }

</script>

	<div id="idBox" class="idBox">
		<form name="idFindFrm">
			<p style="text-align:center;">아이디 찾기</p>
			<ul style="list-style-type: none;">
				<li style="margin: 25px 0"><label
					style="display: inline-block; width: 90px;">성명</label> <input
					type="text" name="name" size="25" autocomplete="off" /></li>
				<li style="margin: 25px 0"><label
					style="display: inline-block; width: 90px;">이메일</label> <input
					type="text" name="email" size="25" autocomplete="off" /></li>
			</ul>
	
			<div class="my-3 text-center">
				<button type="button" class="btn btn-success">찾기</button>
			</div>
	
		</form>
	
		<div id="div_findResult" class="my-3 text-center">
			ID : <span style="color: #000; font-weight: 600; font-size: 16pt;">${requestScope.id}</span>
		</div>
	</div>

</div>
	
<jsp:include page="../footer.jsp" />