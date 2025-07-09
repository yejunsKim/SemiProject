<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /SemiProject_rdg
%>

<jsp:include page="../header.jsp" />

<script type="text/javascript" src="<%= ctxPath%>/js/shop/perfumeSearch.js"></script>

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
	.card {transition:transform 2s ease 2s;}
	.card a {overflow:hidden;transition:transform 2s ease 2s;}
	
	.card:hover img {scale:1.2;}
	.searchBox {max-width:1440px;margin:0 auto;padding: 10vh 0 15vh;}
	.searchTit {font-size: 20pt;background-image: url("/SemiProject/images/etc/searchBg.jpg");background-size: 100%;background-repeat: no-repeat;background-position: center;padding:15vh 0;position:relative;}
	.searchTit::before {background-color:rgba(0,0,0,0.3);content:"";display:inline-block;width:100%;height:100%;position:absolute;left:0;top:0;}
		
</style>

<input type="hidden" id="searchIDVal" value="${searchID}" />
<input type="hidden" id="totalCount" value="${totalCount}" />

<h4 class="text-center searchTit">"${searchID}" 검색 결과로 총 "${totalCount}" 개가 있습니다.</h4>
<div class="row searchBox" id="displayHIT"></div>

<span id="countHIT" style="display:none;">0</span>
<span id="end" style="display:none;"></span>
<script src="<%=ctxPath%>/js/shop/perfumeSearch.js"></script>
	
		
<jsp:include page="../footer.jsp" />