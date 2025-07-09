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
 	#maincontent { 
    background: #f0f4fa; /* 기존 background: none; 대신 배경색 추가 */
    border-radius: 15px;
    /* box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05); */
    padding: 30px;
	}
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
	.card {
	  transition: transform 0.3s ease, box-shadow 0.3s ease;
	  cursor: pointer;
	}
	
	.card:hover,
	.card:active {
	  transform: scale(1.05);
	  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
	}
	
</style> 

	<%-- === 카테고리(?) 상품을 모두 가져와서 디스플레이(페이징 처리 방식은 미정) === --%>
	<%-- 수정사항3 --%>
	<div class="col-md-12" id="maininfo" align="center" style="padding-top:80px;background: #f0f4fa;">
		<div id="maincontent">
			<div>
 				<p class="h3 my-3 text-center">- ${requestScope.categoryName} -</p>
				
				<div class="row" id="displayHIT" style="text-align: left;"></div>
				
				<%-- 여기에 페이징 처리 방법은 버튼이나 기타 등등 추후 추가 --%>
				<div>
					<p class="text-center">
						<span id="end" style="display:block; margin:20px; font-size: 14pt; font-weight: bold; color: red;"></span>
						<span style="display:none;" id="totalCount">${requestScope.totalCount}</span>
						<span style="display:none;" id="countHIT">0</span>
					</p>
				</div>
				
				<!-- <div style="display: flex;">
					<div style="margin: 0 auto;">
						<button style="display: none;" class="btn btn-dark" onclick="goTop()">
							<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-caret-up-fill" viewBox="0 0 16 16">
			        		<path d="m7.247 4.86-4.796 5.481c-.566.647-.106 1.659.753 1.659h9.592a1 1 0 0 0 .753-1.659l-4.796-5.48a1 1 0 0 0-1.506 0z"/>
			      		</svg>
						</button>
					</div>
				</div> -->
				
			</div>
		</div>
	</div>
		 
<jsp:include page="../footer.jsp" />