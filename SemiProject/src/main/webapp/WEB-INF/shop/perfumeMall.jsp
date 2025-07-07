<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp" />

<script type="text/javascript" src="${pageContext.request.contextPath}/js/shop/perfumeMall.js"></script>
<script>
	const categoryName = "${requestScope.categoryName}";
</script>

<!-- Google Fonts for Noto Sans KR -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600;700&display=swap" rel="stylesheet">
<!-- 
<style>
     body {
		    font-family: 'Noto Sans KR', sans-serif;
		    background-color: #f5f3ff; /* 라이트 퍼플 */
		    background-image: url('https://img.freepik.com/free-vector/hand-painted-watercolor-floral-pattern_23-2148931052.jpg');
		    background-size: cover;
		    background-position: center;
		    background-attachment: fixed;
		    background-blend-mode: overlay;
		}


    @keyframes gradientBG {
        0% {background-position: 0% 50%;}
        50% {background-position: 100% 50%;}
        100% {background-position: 0% 50%;}
    }
</style>
 -->
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

<style>
    .card-link { text-decoration: none; color: black; }
    .card-link:hover { text-decoration: underline; color: black; }
    a.itemDetail { text-decoration: none; color: black; }
    .card-title:hover { text-decoration: underline; }

    #displayHIT .card {
        display: flex; flex-direction: column; align-items: center; justify-content: space-between;
        padding: 20px; border-radius: 12px; background: white;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        transition: transform 0.2s, box-shadow 0.2s; height: 100%;
    }

    #displayHIT .card:hover {
        transform: translateY(-4px);
        box-shadow: 0 6px 12px rgba(0,0,0,0.15);
    }

    #displayHIT .card img {
        width: 100%; height: 220px; object-fit: cover;
        border-radius: 8px; margin-bottom: 12px;
    }

    #displayHIT .card .card-title,
    #displayHIT .card .card-volume,
    #displayHIT .card .card-price,
    #displayHIT .card .card-link {
        display: block; text-align: center; margin-bottom: 8px; word-break: keep-all;
    }

    #maincontent {
        background: none;
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
        padding: 30px;
    }
</style>
<body>
<div class="col-md-12" id="maininfo" align="center" style="padding-top:80px;">
	<div id="maincontent">
		<div>
			<p class="h3 my-3 text-center">- ${requestScope.categoryName} -</p>
			<div class="row" id="displayHIT" style="text-align: left;"></div>

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
</body>
<jsp:include page="../footer.jsp" />