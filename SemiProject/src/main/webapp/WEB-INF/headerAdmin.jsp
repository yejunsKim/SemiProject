<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
%>
<style>
.adminFunc {border: 1px solid #bbb;padding: 10px 15px;border-radius: 15px;background: #8444e9;color: #fff;cursor: pointer}
.adminTab {position: absolute;right:0;height:860px;background:#fff;top:65px;width:150px;border-left:1px solid #ddd;z-index:20;}
.adminTab p {padding:40px 13px;border-bottom:1px solid #ddd;cursor:pointer;}
.adminTab p:hover, .adminTab p:hover a {background-color:#000;color:#fff}
</style>

<script type="text/javascript">
$(function(){
	$('.adminTab').hide();

	let adminOpen = false;
	$(document).on("click",".adminFunc", function(){
		if (adminOpen) {
		    $('.adminTab').hide();
		} else {
			$('.adminTab').show();
		}
		adminOpen = !adminOpen;
	});
	
	$('.userTab').hide();
});
</script>

<li class="logins" style="border:1px solid #bbb;padding:10px 15px;border-radius:15px;background:#6b6bf7;color:#fff;cursor:pointer;">내 정보</li>
<li class="adminFunc">관리자 기능보기</li>

<div class="adminTab">
	<p><a href="<%= ctxPath %>/user/admin/userList.do">회원목록 전체보기</a></p>
	<p><a href="<%= ctxPath %>/item/admin/itemRegister.do">제품 등록하기</a></p>
	<p><a href="#">주문통계 차트보기</a></p>
</div>