<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String ctxPath = request.getContextPath();
    //    /SemiProject
%>

<jsp:include page="../header.jsp" />

<style>
	table#orderList {
		width: 90%;
		height: 100px;
		margin: 30px auto;
		border-collapse: collapse;
		font-size: 15px;
	}
	thead#orderList {
		background-color: #e7f3f9; /* 연한 하늘색 */
	}
	tbody#orderList {
		background-color: white;
	}
	th#orderList, td#orderList {
		border: 1px solid #ddd;
		padding: 10px;
		text-align: center;
		vertical-align: middle;
	}
	/* tbody tr:hover {
		background-color: white;
		cursor: pointer;
	} */
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
	.btn1 {
		padding: 6px 12px;
		background-color: #fff;
		border: 1px solid #ccc;
		cursor: pointer;
		transition: all 0.3s ease;
		border-radius: 0.375rem;
		font-size: 10px;
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



.btn1 span {
	font-size: 8pt;
}
</style>

<script type="text/javascript">
	
	$(function(){
		
	});// end of $(function(){})------------------------------
	
	
	function orderDetail(orderno){
		if(orderno == null) {
			alert("주문을 완료하셔야 클릭 가능합니다.");
		}
		else {
		location.href = '<%= ctxPath %>/item/orderDetail.do?orderno=' + orderno;	// 주문 상세 페이지로 이동
		}
	}
	
</script>

<div class="col-md-12" style="background-color: #f5f5f5;padding-top:80px;">
<div class="container" style="min-height: 600px; background-color: #f5f5f5; padding-bottom: 50px;">
	
	<h2 style="text-align:center; font-size: 24pt;"><span style="color: blue;">${sessionScope.loginUser.name}</span> 님 주문 내역</h2>
	
	<hr style="border: solid 1px black; width: 90%;">
	
	<table id="orderList">
		<thead id="orderList">
			<tr>
				<th id="orderList" style="width: 10%">주문일자</th>
				<th id="orderList" style="width: 15%">주문번호</th>
				<th id="orderList">주문내역</th>
				<th id="orderList" style="width: 15%">적립포인트</th>
				<%-- <th id="orderList" style="width: 10%">주문상태</th> --%>
				<th id="orderList" style="width: 15%"></th>
			</tr>
		</thead>
		
		<tbody id="orderList">
			
			<c:if test="${not empty requestScope.ohList}">
				<c:forEach var="ohvo" items="${requestScope.ohList}" varStatus="status">
					<tr data-orderno="${ohvo.orderno}">
						<td id="orderList">${ohvo.orderdate}</td>
						<td id="orderList">${ohvo.orderno}</td>
						<td id="orderList">${ohvo.itemlist}</td>
						<td id="orderList"><fmt:formatNumber pattern="#,###">${ohvo.rewarded}</fmt:formatNumber> Point</td>
						<%-- <td id="orderList">임시 주문상태</td> --%>
						<td id="orderList"><button class="btn1" onclick="orderDetail('${ohvo.orderno}')">
						    <i class="fa-solid fa-truck" style="margin-right: 6px; color: #555;"></i>
						    <span>상세보기</span>
						</button>
						</td>
					</tr>
				</c:forEach>
			</c:if>
			
			<c:if test="${empty requestScope.ohList}">
				<tr>
					<td colspan="5">
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
</div>

<jsp:include page="../footer.jsp" />