<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">

	alert("${requestScope.message}");      // 메시지 출력해주기

	if(window.opener) { // 팝업창으로 들어왔다면,
        window.opener.location.reload(); //부모창 새로고침!
		window.close(); // 팝업창 닫기
	}
	else {
		location.href = "${requestScope.loc}"; // 페이지 이동 

	}
</script>    