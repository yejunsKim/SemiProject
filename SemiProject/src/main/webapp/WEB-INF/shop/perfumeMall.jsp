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
<script src="https://cdn.tailwindcss.com"></script>

<!-- Google Fonts for Noto Sans KR -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600;700&display=swap" rel="stylesheet">




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
    background: #f0f4fa; /* 기존 background: none; 대신 배경색 추가 */
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
    padding: 30px;
}

#displayHIT .card {
    /* 기존 스타일 유지 */
    display: flex; flex-direction: column; align-items: center; justify-content: space-between;
    padding: 20px; border-radius: 12px;
    background: #f9fafb; /* 기존 background: white; 대신 연한 회색 배경색 추가 */
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    transition: transform 0.2s, box-shadow 0.2s; height: 100%;
}

.go-top-btn {
  background: rgba(255,255,255,0.85);
  color: #232946;
  border: none;
  border-radius: 28px;
  font-weight: 600;
  font-size: 1.1rem;
  padding: 0.9rem 2.5rem;
  box-shadow: 0 4px 24px rgba(140,180,255,0.15);
  backdrop-filter: blur(6px);
  transition: background 0.3s, box-shadow 0.2s, color 0.2s, transform 0.16s;
}

.go-top-btn:hover {
  background: rgba(140,180,255,0.92);
  color: #fff;
  box-shadow: 0 8px 32px rgba(140,180,255,0.25);
  transform: translateY(-3px) scale(1.05);
}




    
</style>
<div class="col-md-12" id="maininfo" align="center" style="padding-top:80px;">
	<div id="maincontent">
		<div>
			<p class="h3 my-3 text-center font-bold text-3xl gradient-text mb-8">- ${requestScope.categoryName} -</p>
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
						<button style="display: none;" class="btn btn-dark" onclick="goTop()">
							<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-caret-up-fill" viewBox="0 0 16 16">
			        		<path d="m7.247 4.86-4.796 5.481c-.566.647-.106 1.659.753 1.659h9.592a1 1 0 0 0 .753-1.659l-4.796-5.48a1 1 0 0 0-1.506 0z"/>
			      		</svg>
						</button>
					</div>
				</div>
				
			</div>
		</div>
	</div>
</div>
</body>
<jsp:include page="../footer.jsp" />