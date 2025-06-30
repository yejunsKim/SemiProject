<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />
<%
    String ctxPath = request.getContextPath();
%>
<style>
.formBox {margin:0 auto;max-width:700px;padding:5% 5%;}
#newPassword1, #newPassword2 {margin:2% auto;} 
</style>

<script type="text/javascript">
  $(function(){
    $(".passwordUp").on("click", function(){
        const frm = document.passwordUp;
        
        const pwd1 = $("#newPassword1").val();
        const pwd2 = $("#newPassword2").val();

        if (pwd1 !== pwd2) {
            alert("비밀번호가 일치하지 않습니다.");
            return;
        }

        // 비밀번호 값 hidden 처리해서 전송할 수 있음
        $("<input>").attr({
            type: "hidden",
            name: "newPassword2",
            value: pwd2
        }).appendTo(frm);

        frm.action = "<%=ctxPath%>/login/passwordUpdate.do";
        frm.method = "POST";
        frm.submit();
    });
  });
</script>
	
	<div style="margin:150px auto 0;">
		<form name="passwordUp" class="formBox">
			비밀번호 변경할 아이디: ${requestScope.id}
			<input type="hidden" name="id" value="${requestScope.id}" />
			<br>
			비밀번호: <input type="password" name="newPassword1" id="newPassword1">
			<br>
			비밀번호 재확인: <input type="password" id="newPassword2"> <!-- name 제거 -->
			<br>
			<button type="button" name="passwordUp" class="btn btn-info passwordUp">변경하기</button>
		</form>
	</div>

</div>

<jsp:include page="../footer.jsp" />