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

<title>장바구니 예시</title>

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

<style type="text/css">

	body {
		font-family: Arial, sans-serif;
		margin: 40px;
	}
	
	table {
		width: 100%;
		border-collapse: collapse;
		margin-bottom: 20px;
	}
	
	thead > tr {
		height: 20px;
	}
	
	tbody > tr {
		height: 100px;
	}
	
	th, td {
		border: 1px solid #ddd;
		padding: 12px;
		text-align: center;
	}
	
	th {
		background-color: #f5f5f5;
	}
	
	.product-info {
		display: flex;
		align-items: center;
		justify-content: center;
		gap: 10px;
	}
	
	.product-info img {
		width: 50px;
		height: auto;
	}
	
	.summary {
		text-align: right;
		font-size: 18px;
		margin-top: 20px;
	}
	
	.total-row {
		font-weight: bold;
		font-size: 20px;
		text-align: right;
		border-top: 2px solid #000;
		padding-top: 10px;
	}
	
	.btn-row {
		margin-top: 30px;
		text-align: center;
	}
	
	.btn {
		padding: 12px 24px;
		margin: 5px;
		font-size: 16px;
		border: none;
		background-color: #222;
		color: #fff;
		cursor: pointer;
	}
	
	.btn:hover {
		background-color: #555;
	}
	
	.select-shipping {
		display: flex;
		align-items: center;
		justify-content: space-between;
		margin: 20px 0;
	}

</style>

<script type="text/javascript">
	
	$(function(){
		
		$('input:checkbox[name="selectedItems"]').click(function(){	// 제품 체크박스 상태에 따라 전체 체크박스 연동
			
			let all_check = false;
			
			$('input:checkbox[name="selectedItems"]').each(function(index, elmt){
				
				const cartno_checked = $(elmt).prop("checked");
				
				if(!cartno_checked) {
					$('input:checkbox[id="allCheckOrNone"]').prop("checked", false);
					all_check = true;
					return false;	// break;
				}
				
			});
			
			if(!all_check) {
				$('input:checkbox[id="allCheckOrNone"]').prop("checked", true);
			}
			
		});// end of $('input.checkbox[name="selectedItems"]').click(function()})------------------------
		
	});// end of $(function(){})-------------------------
	
	
	// Function Declaration
	
	// 장바구니 제품 왼쪽 상단 전부 체크 or 해제하기
	function allCheckBox() {
		
		const bool = $('input:checkbox[id="allCheckOrNone"]').is(":checked");
		
		$('input:checkbox[name="selectedItems"]').prop("checked", bool);
	}// end of function allCheckBox()-------------------------
	
	
	// 장바구니에서 특정 제품 삭제하기
	function cartDel(cartno) {
		
		const itemName = $(event.target).parent().parent().find("div#cart_itemName").text();
		
		if( confirm(`\${itemName} 을[를] 삭제하시겠습니까?`) ) {
			
			$.ajax({	// 삭제 클래스 만들기
				url:"<%= ctxPath%>/item/cartDel.do",
				type:"post",
				data:{"cartno":cartno},
				dataType:"json",
				success:function(json){
					
					if(json.n == 1) {	// 성공시 삭제된 채로 다시 장바구니 목록으로
						location.href = "<%= ctxPath%>/item/cartList.do";
					}
					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
		}
		
		else {
			alert(`장바구니에서 \${itemName} 제품 삭제를 취소하셨습니다.`);
		}
		
	}// end of function cartDel(cartno)------------------------------
	
</script>

</head>
<body>
	
	<h1 class="text-center" >${sessionScope.loginUser.name} 님 장바구니</h1>
	
	<hr style="border: solid 1px black;">
	
	<div class="text-center my-3" style="font-size: 10pt;">장바구니에 담긴 상품은 30일 동안 보관됩니다.</div>
	
	<form name="CartList" method="POST">	<%-- action="추후 추가" --%>
		<table>
			<thead>
				<tr>
					<th style="width: 10%;"><input type="checkbox" id="allCheckOrNone" onclick="allCheckBox()" />  제품번호</th>
					<th style="width: 15%;">이미지</th>
					<th style="width: 15%;">향수명</th>
					<th style="width: 10%;">상품금액(개당)</th>
					<th style="width: 10%;">포인트</th>
					<th style="width: 15%;">수량</th>
					<th style="width: 15%;">등록날짜</th>
					<th style="width: 10%;">비우기</th>
				</tr>
			</thead>
			<tbody>
					<c:if test="${empty requestScope.cartList}">
						<tr>
							<td colspan="8" style="text-align: center"><strong>장바구니가 비었습니다.</strong></td>
						</tr>
					</c:if>
					
					<c:if test="${not empty requestScope.cartList}">
						<c:forEach var="cart" items="${requestScope.cartList}">
							<tr>
								<td><input type="checkbox" name="selectedItems" value="${cart.cartno}" /></td>
								<td><img src="<%= ctxPath%>${cart.ivo.itemPhotoPath}" alt="상품 이미지" style="width: 120px; height: auto;" /></td>
								<td><div id="cart_itemName">${cart.ivo.itemName}</div></td>
								<td><fmt:formatNumber pattern="#,###">${cart.ivo.price}</fmt:formatNumber>원</td>
								<td><fmt:formatNumber pattern="#,###">${cart.ivo.itemPoint}</fmt:formatNumber> Point</td>
								<td>
									<input type="number" name="quantity_item001" value="${cart.cartamount}" min="1" style="width: 60px;" />	
									<button type="button">변경</button>
								</td>
								<td>${cart.cartdate}</td>
								<td>
									<button type="button" id="cartDelete" onclick="cartDel('${cart.cartno}')">삭제</button>
								</td>
							</tr>
						</c:forEach>
					</c:if>
			</tbody>
		</table>
		
		<div class="select-shipping">
			<div>
				<strong>선택상품을 : </strong>
				<button type="submit" name="action" value="delete">삭제하기</button>
			</div>
			<div>
				<button type="submit" name="action" value="clear">장바구니 비우기</button>
			</div>
		</div>
		
		<hr style="border: solid 1px black;">
		
		<table style="width: 100%; text-align: center; font-size: 15pt; margin-top: 30px; 
				border-collapse: collapse; border: 1px solid gray;">
		
			<thead>
				<tr style="border-bottom: 1px solid #ddd;"> 
					<th style="padding: 10px; width: 25%;">총 상품금액</th>
					<th style="padding: 10px; width: 25%;">총 적립 포인트</th>
					<th style="padding: 10px; width: 50%;">결제 예정 포인트</th>
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td style="padding: 15px;"><strong><fmt:formatNumber pattern="#,###">${requestScope.totalPrice}</fmt:formatNumber></strong>원</td>
					<td style="padding: 15px;"><fmt:formatNumber pattern="#,###">${requestScope.totalPoint}</fmt:formatNumber> Point</td>
					<td style="padding: 15px; color: red; font-weight: bold;">= <fmt:formatNumber pattern="#,###">${requestScope.totalPrice}</fmt:formatNumber> Point</td>
				</tr>
			</tbody>
		</table>
		
		<div class="btn-row">
			<button type="submit" name="action" value="order_selected" class="btn">선택상품주문</button>
			<button type="button" onclick="location.href='<%= ctxPath%>/item/mallHome.do'" class="btn">쇼핑계속하기</button>
		</div>
	</form>
	
</body>
</html>