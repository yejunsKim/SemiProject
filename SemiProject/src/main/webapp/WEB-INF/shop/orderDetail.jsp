<%@page import="java.awt.event.ItemEvent"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp" />

<style>

	div#divOrder {
		text-align: center;
	}
	
	table#tblOrder {
		width: 80%;
		margin: 1% auto;
	}
	
	table#tblOrder td {
		line-height: 200%;
		padding: 1.2% 0;
	}
	
	table#tblOrder > tbody > tr > td:first-child {
		width: 20%;
		text-align: left;
	}
	
	table#tblOrder > tbody > tr > td:nth-child(2) {
		width: 80%;
		text-align: left;
	}
	
	
	#postcodeSearch {
 	  vertical-align: middle;
	  cursor: pointer;
	  height: 30px; /* input 높이에 맞게 고정 (필요 시 조절) */
	}
	
	span#emailCheck {
		border: solid 1px gray;
		border-radius: 5px;
		font-size: 8pt;
		display: inline-block;
		width: 80px;
		height: 30px;
		text-align: center;
		margin-left: 10px;
		cursor: pointer;
	}
}

</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
	
	$(function(){
		
		
	}); // end of $(function(){})--------------------------------
	
</script>
	
	<div class="col-md-12" id="divOrder" style="background-color: #f5f5f5;padding-top:80px;">
	
		<div class="section">
			<table id="tblOrder">
				<thead>
					<tr class="h3">
						<th colspan="2">주문 상세 내역</th>
					</tr>
				</thead>
				
				<tbody>
					<tr class="h5">
						<td>배송지</td>
					</tr>
					
					<tr>
						<td>받는사람&nbsp;</td>
						<td>
							<div id="name">${sessionScope.loginUser.name}</div>
						</td>
					</tr>
					
					<tr>
						<td>배송지&nbsp;</td>
						<td>
							<div>
								${sessionScope.loginUser.address}&nbsp;
								${sessionScope.loginUser.addressDetail}&nbsp;${sessionScope.loginUser.addressExtra}
								<span style="color: red; font-weight: bold;">(임시 입니다. order_items 테이블 딜리버리코드? 데이터 참조해야함)</span>
							</div>
						</td>
					</tr>
					
					<tr>
						<td>연락처&nbsp;</td>
						<td>
							<div>010 - ${fn:substring(sessionScope.loginUser.mobile, 3, 7)} - ${fn:substring(sessionScope.loginUser.mobile, 7, 11)}</div>  
						</td>
					</tr>
					
					<tr style="border-bottom: 1px solid">
						<td>이메일&nbsp;</td>
						<td>
							<div>${sessionScope.loginUser.email}</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<!-- 주문상품 -->
		<div class="section">
			<table id="tblOrder">
				<tr class="h5">
					<td>주문상품</td>
				</tr>
				<tbody style="display: block; height: 300px; overflow-y: auto;">
					<c:forEach var="oivo" items="${requestScope.oiList}">
						<tr style="border-bottom: 1px solid; display: block;">
							<td style="width: 100%;">
								<span>
									<img src="<%= ctxPath%>${oivo.ivo.itemPhotoPath}" alt="상품 이미지" style="width: 60px; height: auto;" />
								</span>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<span class="item-price">
									${oivo.ivo.itemName}&nbsp;${oivo.ivo.volume}ml
								</span>
								&nbsp;&nbsp;&nbsp;
								<span class="quantity">
									X ${oivo.quantity}개
								</span>
								&nbsp;&nbsp;&nbsp;
								<span>
									<fmt:formatNumber value="${oivo.orderprice}" pattern="###,###"/>원
								</span>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
		<!-- 결제정보 -->
		<div class="section">
			<table id="tblOrder">
				<tr class="h5">
					<td>결제정보</td>
				</tr>
				<tr style="border-bottom: 1px solid">
					<td><strong>최종 결제 금액</strong></td>
					<td id="finalPrice" name="finalPrice" style="text-align: right;">
						<strong><fmt:formatNumber value="${oiList[0].ohvo.totalamount}" pattern="###,###"/>원</strong>
					</td>
				</tr>
			</table>
		</div>
		
		<!-- 결제수단 -->
		<div class="section">
			<table id="tblOrder">
				<tr class="h5" >
					<td>
						결제수단 →&nbsp;
						<label style="color: blue;">카드결제</label>
					</td>
				</tr>
			</table>
		</div>
		
	</div>

<jsp:include page="../footer.jsp" />