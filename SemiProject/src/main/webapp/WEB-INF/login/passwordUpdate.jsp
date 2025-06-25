<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />
<%
    String ctxPath = request.getContextPath();
%>

<script type="text/javascript">
  $(function{
	  
	const frm = document.passwordUp;
	frm.action = "<%=ctxPath%>/login/PasswordUpdate.do";
	frm.method = "POST";
	frm.submit();
	
  });
</script>
	
	<div style="margin:150px auto 0;">
		<form name="passwordUp">
			비밀번호 변경할 아이디:${requestScope.id}
			<br>
		  	비빌번호 : <input type="text" name="newPassword1" id="newPassword1">
		  	<br>
		  	비밀번호 재 확인 : <input type="text" name="newPassword2" id="newPassword2">
		  	<button type="button" name="passwordUp" class="btn btn-info passwordUp">변경하기</button>
		</form>
	</div>

</div>

<jsp:include page="../footer.jsp" />