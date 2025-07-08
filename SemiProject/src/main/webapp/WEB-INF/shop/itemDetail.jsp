<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp" />
<style>
.itemLeft {position:relative;}
.itemLeft::after{content:"";display:inline-block;width:1px;height:100%;background-color:#ddd;position:absolute;right:5%;top:1%;}
</style>


<%-- JavaScript --%>
<script type="text/javascript">

	$(function() {
		
		$('button#btnScrollTop').hide(); // 위로 가기 버튼 숨기기
		
		// 제품 상세이미지 보기 버튼을 클릭 했을 때
    	$('#btnMoreItem').click(function() {
    		
   			// 상세 이미지 영역에 긴 이미지 한 장 삽입
       		$('#detailImageSection').html(`
         		<img src="<%= ctxPath%>/${item.infoImg}" alt="상세 이미지" style="width: 80%; height: auto;">
       		`);
       		
   			// 상세 이미지 영역을 부드럽게 보여주고, 버튼 숨기기
       		$('#detailImageSection').slideDown(300); 
       		$(this).hide();
       		$('button#btnScrollTop').show();
      		
    	});
    	
    	$('button#btnScrollTop').click(function(){
    		$('html, body').animate({ scrollTop: 0 }); // 맨 위로 이동
    		$('#detailImageSection').hide(); // 상세 이미지 영역 숨기기
    		$('#btnMoreItem').show(); // 제품 상세이미지 보기 버튼 보여주기
    		$(this).hide(); // 맨 위로 이동 버튼 숨기기
    	});
    	
  	})// end of ;$(function() {})--------------------------
	
</script>

	<div class="col-md-12" style="background-color: #f5f5f5;padding-top:80px;">
		<div class="col-md-12" style="background-color: #f5f5f5;">
		<div class="d-flex">
			<div class="col-8 my-5" style="border-right: 1px solid #ccc;">
				<img class="mt-4" src="<%= ctxPath%>${item.itemPhotoPath}" class="img-fluid" style="width: 80%;">
			</div>
		
			<div class="col-4 my-5">
				<div class="d-flex justify-content-between mt-5">
					<span class="my-4" style="font-size: 17pt; font-weight: bold;">${item.itemName}</span>
					<%-- <span style="font-size: 15pt; font-weight: bold;">${item.itemNo}</span> --%>
				</div>
				<div>
					<span class="my-4" style="font-size: 13pt; text-align: right;"><fmt:formatNumber value="${item.price}" pattern="#,###" /> 원</span>
				</div>
				<br>
				<div class="py-2 pl-3" style="background-color: white;padding-top:16px !important;padding-bottom:16px !important;">
					용량&nbsp;: <span style="padding-left:84px;">${item.volume}ml</span> 
				</div>

				<form id="cartPush" method="post" action="<%= ctxPath%>/item/cartAdd.do">
					<%-- 제품번호 --%>
					<input type="hidden" name="itemNo" value="${item.itemNo}">
				
					<%-- 수량 입력 --%>
					<div class="bg-white p-3 d-flex align-items-center mb-2" style="gap: 10px;">
						<label for="quantity" class="mb-0" style="min-width: 80px;">수량&nbsp;:</label>
						<c:choose>
							<c:when test="${item.itemAmount == 0}">
								<span style="color: red;">현재 재고가 없습니다.</span>
							</c:when>
							<c:otherwise>
								<select id="quantity" name="quantity" class="border-0 p-0" 
								style="box-shadow: none; width: 100px; text-align: center;">
									<c:forEach var="itemAmount" begin="1" end="${item.itemAmount}">
										<option value="${itemAmount}">${itemAmount}</option>
									</c:forEach>
								</select>
							</c:otherwise>
						</c:choose>
					</div>

					<%-- 장바구니 담기 버튼 --%>
					<button type="submit" class="btn btn-dark w-100 py-3" style="font-weight: bold;">장바구니 담기</button>
				</form>
				
				<div class="mt-3">${item.itemInfo}</div>
			</div>
		</div>
		
		<%-- 상세 이미지 보기 버튼 --%>
		<div class="col text-center">
			<button type="button" class="btn btn-secondary btn-lg" id="btnMoreItem" value="">자세히보기</button>
			
			<%-- 상세 이미지 영역 --%>
			<div id="detailImageSection">
				
			</div>
			
			<%-- 위로 가기 --%>
			<div style="display: flex;">
			  	<div style="margin: 20px 0 20px auto;">
			    	<button class="btn btn-light" id="btnScrollTop">
			      		<!-- SVG 아이콘 삽입(위 화살표) -->
			      		<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-caret-up-fill" viewBox="0 0 16 16">
			        		<path d="m7.247 4.86-4.796 5.481c-.566.647-.106 1.659.753 1.659h9.592a1 1 0 0 0 .753-1.659l-4.796-5.48a1 1 0 0 0-1.506 0z"/>
			      		</svg>
			    	</button>
			  	</div>
			</div>
		</div>
		
	</div>
	

<jsp:include page="../footer.jsp" />
