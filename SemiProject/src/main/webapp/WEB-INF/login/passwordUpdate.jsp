<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />
<%
    String ctxPath = request.getContextPath();
%>
<style>

body {background-color: #f5f3ff;background-image: url(https://img.freepik.com/free-vector/hand-painted-watercolor-floral-pattern_23-2148931052.jpg);background-size: cover;background-position: center;background-attachment: fixed;background-blend-mode: overlay;}
.formBox {margin:0 auto;max-width:500px;padding:4% 2%;margin:8% auto;border-radius:20px;background-color:#fff;}
#newPassword1, #newPassword2 {margin:4% 0;} 
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
			<div style="margin-bottom:1%;text-align:center;font-size:16pt;">비밀번호 변경할 아이디: ${requestScope.id}</div>
			<input type="hidden" name="id" value="${requestScope.id}" />
			<br>
				<div style="display:flex;justify-content:space-between;align-items:center;">
					비밀번호: <input type="password" name="newPassword1" id="newPassword1">
				</div>
				<div style="display:flex;justify-content:space-between;align-items:center;">
					비밀번호 재확인: <input type="password" id="newPassword2"> <!-- name 제거 -->
				</div>
			<br>
			<button type="button" name="passwordUp" class="btn btn-info passwordUp" style="background-color: #c084fc !important;border:0 !important;width:100%;">변경하기</button>
		</form>
	</div>

</div>

<jsp:include page="../footer.jsp" />