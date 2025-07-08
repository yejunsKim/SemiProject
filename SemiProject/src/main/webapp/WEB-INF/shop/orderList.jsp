<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String ctxPath = request.getContextPath();
    //    /SemiProject
%>

<!DOCTYPE html>
<html>
<head>

<title>주문 내역</title>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 

<!-- Font Awesome 6 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

<%-- jQueryUI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>



<style>
	table {
		width: 90%;
		height: 100px;
		margin: 30px auto;
		border-collapse: collapse;
		font-size: 15px;
	}
	thead {
		background-color: #e7f3f9;
	}
	th, td {
		border: 1px solid #ddd;
		padding: 10px;
		text-align: center;
		vertical-align: middle;
	}

	/* 주문 테이블 hover 스타일 추가 */
	tbody tr:hover {
		background-color: #f8fafc;
		transform: translateY(-2px);
		box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1);
		transition: all 0.3s ease;
		cursor: pointer;
	}

	/* 배송 조회 버튼 스타일 */
	.btn1 {
		padding: 6px 12px;
		background-color: #fff;
		border: 1px solid #ccc;
		cursor: pointer;
		transition: all 0.3s ease;
		border-radius: 0.375rem;
		font-size: 14px;
	}

	.btn1:hover {
		background-color: #3b82f6; /* Tailwind blue-500 */
		color: white;
		border-color: #3b82f6;
	}

	/* 빈 상태 메시지 */
	.empty-state {
		background-color: #f8fafc;
		border-radius: 0.5rem;
		padding: 2rem;
		color: #6b7280;
		text-align: center;
		font-size: 15px;
	}
</style>
	
	

<script type="text/javascript">
	
	$(function(){
		
		// tr 클릭
		$('tbody').on('click', 'tr', function(){
			
			const orderno = $(this).data("orderno");
		//	alert(orderno);
			
			if(orderno == null) {
				alert("주문을 완료하셔야 클릭 가능합니다.");
			}
			else {
			location.href = '<%= ctxPath %>/item/orderDetail.do?orderno=' + orderno;	// 주문 상세 페이지로 이동
			}
		});
		
		
		// 버튼 클릭 시 tr 클릭 막기
		$('.btn1').click(function(event) {
			event.stopPropagation();  // 상위 tr 클릭 막기
			
			alert("버튼 클릭됨");
			
	    });
		
	});// end of $(function(){})------------------------------
	
</script>

</head>
<body style="background-color: #f5f5f5;">
	
	<h2 style="text-align:center;"><span style="color: blue;">${sessionScope.loginUser.name}</span> 님 주문 내역</h2>
	
	<hr style="border: solid 1px black; width: 90%;">
	
	<table>
		<thead>
			<tr>
				<th style="width: 15%">주문일자</th>
				<th style="width: 15%">주문번호</th>
				<th>주문내역</th>
				<th style="width: 10%">배송</th>
			</tr>
		</thead>
		
		<tbody>
			
			<c:if test="${not empty requestScope.ohList}">
				<c:forEach var="ohvo" items="${requestScope.ohList}" varStatus="status">
					<tr data-orderno="${ohvo.orderno}">
						<td>${ohvo.orderdate}</td>
						<td>${ohvo.orderno}</td>
						<td>${ohvo.itemlist}</td>
						<td><button class="btn1" onclick="delivery(${status.index})" >
							<i class="fa-solid fa-truck mr-1"></i> 조회
						</button>
						</td>
					</tr>
				</c:forEach>
			</c:if>
			
			<c:if test="${empty requestScope.ohList}">
	<tr>
		<td colspan="4">
			<div class="empty-state">
				<i class="fa-solid fa-shopping-cart" style="font-size: 2rem; color: #9ca3af; margin-bottom: 0.5rem;"></i>
				<h3 style="font-size: 1.1rem; color: #374151;">주문한 내역이 없습니다.</h3>
				<p style="font-size: 0.9rem; color: #6b7280;">새로운 상품을 구매해보세요!</p>
			</div>
		</td>
	</tr>
</c:if>
		</tbody>
				
	</table>
	<c:if test="${not empty requestScope.ohList}">
		<nav class="my-5">
			<div style='display:flex; width:80%; margin: 0 auto;'>
				<ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
			</div>
		</nav>
	</c:if>
</body>
</html>