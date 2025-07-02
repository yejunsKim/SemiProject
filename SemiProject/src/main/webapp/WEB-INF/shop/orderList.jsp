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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css">

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
		background-color: #e7f3f9; /* 연한 하늘색 */
	}
	th, td {
		border: 1px solid #ddd;
		padding: 10px;
		text-align: center;
		vertical-align: middle;
	}
	tbody tr:hover {
		background-color: #f5f5f5;
		cursor: pointer;
	}
	.order-summary {
		text-align: left;
		white-space: nowrap;
	}
	.btn-view {
		padding: 6px 12px;
		background-color: #fff;
		border: 1px solid #ccc;
		cursor: pointer;
	}
</style>

<script type="text/javascript">
	
	$(function(){
		
		// tr 클릭
		$('tbody tr').click(function(){
			alert("tr 클릭됨");
		});
		
		// 버튼 클릭 시 tr 클릭 막기
		$('.btn1').click(function(event) {
			event.stopPropagation();  // 상위 tr 클릭 막기
			
			alert("버튼 클릭됨");
			
	    });
		
	});// end of $(function(){})------------------------------
	
</script>

</head>
<body>
	
	<h2 style="text-align:center;">최근 주문 내역</h2>
	
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
			<tr>
				<th>2025-07-02</th>
				<th>s20250702-1</th>
				<th>내용물, 내용물, 내용물, 내용물, 내용물,내용물(넘처나면 ...표현)...</th>
				<th><button class="btn1" >조회</button></th>
			</tr>
		</tbody>
				
	</table>
	
	<div id="pageBar">
		<nav>
			<%--<ul class="pagination">${requestScope.pageBar}</ul> --%>
		</nav>
	</div>
	
		
</body>
</html>