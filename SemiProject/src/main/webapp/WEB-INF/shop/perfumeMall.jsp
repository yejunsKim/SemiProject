<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /SemiProject_rdg
%>

<jsp:include page="../header.jsp" />

<%-- 직접 만든 JS --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/shop/perfumeMall.js"></script>

<script>
	const categoryName = "${requestScope.categoryName}";
</script>

<%-- CSS 직접 추가한 부분 --%>
<style>

	.card-link {	/* 장바구니 담기 */
		text-decoration: none;	/* 기본은 밑줄 없음  */
		color: black;
	}
	
	.card-link:hover {	/* 장바구니 담기 */
		text-decoration: underline; /* 마우스 올리면 밑줄 */
		color: black;
	}
	
	a.itemDetail {	/* 이미지랑, 제품명 */
		text-decoration: none;	/* 기본은 밑줄 없음  */
		color: black;
	}
	
	.card-title:hover {	/* 제품명 */
		text-decoration: underline; /* 마우스 올리면 밑줄 */
	}
	
</style>

	<%-- === 카테고리(?) 상품을 모두 가져와서 디스플레이(페이징 처리 방식은 미정) === --%>
	<%-- 수정사항3 --%>
	<div class="col-md-12" id="maininfo" align="center" style="padding-top:80px;">
	<div class="col-md-9" id="maininfo" align="center">
		<div id="maincontent">
			<div style="background-color: #f5f5f5;">
			
				<p class="h3 my-3 text-center">- ${requestScope.categoryName} -</p>
				
				<div class="row" id="displayHIT" style="text-align: left;"></div>
				
				<%-- 여기에 페이징 처리 방법은 버튼이나 기타 등등 추후 추가 --%>
				<div>
					<p class="text-center">
						<span id="end" style="display:block; margin:20px; font-size: 14pt; font-weight: bold; color: red;"></span>
						<span id="totalCount">${requestScope.totalCount}</span>
						<span id="countHIT">0</span>
					</p>
				</div>
				
				<div style="display: flex;">
					<div style="margin: 0 auto;">
						<button class="btn btn-info" onclick="goTop()">맨위로가기(scrollTop 1로 설정함)</button>
					</div>
				</div>
				
			</div>
		</div>
	</div>
		
<jsp:include page="../footer.jsp" />