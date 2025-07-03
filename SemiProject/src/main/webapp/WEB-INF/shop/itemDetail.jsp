<jsp:include page="../footer.jsp" />
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

//특정 제품의 제품후기글들을 보여주는 함수 
 function goReviewListView() {
  
  // alert("후기글 보여주기");
  
    $.ajax({
        url:"<%= ctxPath%>/item/reviewList.do",
        type:"get",
        data:{"fk_itemNo":"${requestScope.itemVO.itemNo}"},
        dataType:"json",
         success:function(json){ 
         
            
            let v_html = "";
           
           if(json.length > 0) {
              
              $.each(json, function(index, item){
                 
                 let writeUserid = item.fk_id;
                 let loginUserid = "${sessionScope.loginUser.id}";
                 
                 v_html += "<div id='review"+index+"'><span class='markColor'>▶</span>&nbsp;"+item.contents+"</div>"
                             + "<div class='customDisplay'>"+item.name+"</div>"      
                             + "<div class='customDisplay'>"+item.writeDate+"</div>";
                             
                 if(loginuserid == "") { 
                     // 로그인을 안한 경우 
                     v_html += "<div class='customDisplay spacediv'>&nbsp;</div>";
                 }
                 else if(loginuserid != "" && writeuserid != loginuserid ) { 
                     // 로그인을 했으나 후기글이 로그인한 사용자 쓴 글이 아니라 다른 사용자 쓴 후기글 이라면  
                     v_html += "<div class='customDisplay spacediv'>&nbsp;</div>";
                 } 
                 else if(loginuserid != "" && writeuserid == loginuserid ) {
                     // 로그인을 했고 후기글이 로그인한 사용자 쓴 글 이라면
                     v_html += "<div class='customDisplay spacediv commentDel' onclick='delMyReview("+item.review_seq+")'>후기삭제</div>"; 
                     v_html += "<div class='customDisplay spacediv commentDel commentUpdate' onclick='updateMyReview("+index+","+item.review_seq+")'>후기수정</div>"; 
                  }
                 
              }); // end of $.each(json, function(index, item){})---------------
              
           } // end of if(json.length > 0)----------------------
            
           else {
              v_html += "<div>등록된 상품후기가 없습니다.</div>"; 
           }// end of else ----------------------------
           
           $('div#viewComments').html(v_html);
           
        },
        error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
         }   
     });
    
	  
 }// end of function goReviewListView()---------------------

	$(function() {
		
		console.log("<%= ctxPath%>/item/isOrder.up");
    	 goReviewListView();	// 제품후기글을 보여주는 함수 호출하기
		
		$('button#btnScrollTop').hide(); // 위로 가기 버튼 숨기기
		$('#reviewSection').hide();  // 리뷰내용 숨기기

		
		
		
		// 제품 상세이미지 보기 버튼을 클릭 했을 때
    	$('#btnMoreItem').click(function() {
    		
   			// 상세 이미지 영역에 긴 이미지 한 장 삽입
       		$('#detailImageSection').html(
		       '<img src="<%= ctxPath %>${item.infoImg}" alt="상세 이미지" style="width: 80%; height: auto;">'
			);
       		
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
    	
    	// ------------------구매후기----------------------- 
    	
    	$('button#btnReviews').click(function(){
    		
    		 $('#reviewSection').slideToggle();
    	});
    	
    	
    	let isOrderOK = false;
    	
    	// === 로그인한 사용자가 해당 제품을 구매한 상태인지 구매하지 않은 상태인지 알아오기 === // 

    	$.ajax({
 		   url:"<%= ctxPath%>/item/isOrder.do",
 		   type:"get",
 		   data:{"fk_itemNo":"${requestScope.itemVO.itemNo}",
 			     "fk_id":"${sessionScope.loginUser.id}"},
 		   dataType:"json",
 		   
 		   async:false, // 동기처리
 		   
 		   success:function(json){
 			   console.log("~~ 확인용 : " + JSON.stringify(json));
 			   // ~~ 확인용 : {"isOrder":true}   해당제품을 구매한 경우 
 			   // ~~ 확인용 : {"isOrder":false}  해당제품을 구매하지 않은 경우
 			   
 			   isOrderOK = json.isOrder;
 			// json.isOrder 값이 true  이면 로그인한 사용자가 해당 제품을 구매한 경우이고
 		   	// json.isOrder 값이 false 이면 로그인한 사용자가 해당 제품을 구매하지 않은 경우이다.
 		   },
 		   
 		   error: function(request, status, error){
 				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
 	   	   }
 	   });
    	
    	
    	 // **** 제품후기 쓰기(로그인하여 실제 해당 제품을 구매했을 때만 딱 1번만 작성할 수 있는 것. 제품후기를 삭제했을 경우에는 다시 작성할 수 있는 것임.) ****//
        $('button#btnCommentOK').click(function(){
     	   
     	   if(${empty sessionScope.loginUser}) {
     		   alert("제품사용 후기를 작성하시려면 먼저 로그인 하셔야 합니다.");
     		   return; // 종료
     	   }
     	   
     	   if(!isOrderOK) { // 해당 제품을 구매하지 않은 경우라면
     		   alert("${requestScope.itemVO.itemName} 제품을 구매하셔야만 후기작성이 가능합니다.");
     	   }
     	   else { // 해당 제품을 구매한 경우라면
     	     // alert("제품후기 쓰기 가능함");
     	   
     	        const review_contents = $('textarea[name="contents"]').val().trim();
     	   
     	        if(review_contents == "") {
     	        	alert("제품후기 내용을 입력하세요!!");
     	        	$('textarea[name="contents"]').val(""); // 공백제거
     	        	return; // 종료
     	        }
     	   
     	        const queryString = $('form[name="commentFrm"]').serialize();
     	   
     	        
     	        $.ajax({
     	        	url:"<%= ctxPath%>/item/reviewRegister.do",
     	        	type:"post",
     	        	data:queryString,
     	        	dataType:"json",
     	        	success:function(json){
     	        		console.log(JSON.stringify(json));
     	        		/*
     	        		   {"n":1} 또는 {"n":-1} 또는 {"n":0}
     	        		*/
     	        		
     	        		if(json.n == 1) {
   	  					   // 제품후기 등록(insert)이 성공했으므로 제품후기글을 새로이 보여줘야(select) 한다.
   	  					   goReviewListView(); // 제품후기글을 보여주는 함수 호출하기 
   		  			    }
   		  			    else if(json.n == -1)  {
   						// 동일한 제품에 대하여 동일한 회원이 제품후기를 2번 쓰려고 경우 unique 제약에 위배됨 
   						// alert("이미 후기를 작성하셨습니다.\n작성하시려면 기존의 제품후기를\n삭제하시고 다시 쓰세요.");
   						   swal("이미 후기를 작성하셨습니다.\n작성하시려면 기존의 제품후기를\n삭제하시고 다시 쓰세요.");
   					    }
   		  			    else  {
   		  				   // 제품후기 등록(insert)이 실패한 경우 
   		  				   alert("제품후기 글쓰기가 실패했습니다.");
   		  			    }
     	        		
     	        		$('textarea[name="contents"]').val("").focus();
     	        	},
     	        	error: function(request, status, error){
     				   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
     		   	    }
     	        });
     	   
     	   }
     	    
     	   
     	   
        });// end of $('button#btnCommentOK').click(function(){})---------------------
 	   
 	   
 	
    	
  	})// end of ;$(function() {})--------------------------
	
</script>

<script>
console.log("itemNo : ${requestScope.itemVO.itemNo}");
console.log("id : ${sessionScope.loginUser.id}");
</script>

	<div class="col-md-12" style="background-color: #f5f5f5;padding-top:80px;">
		<div class="d-flex">
			<div class="col-8 my-5" style="border-right: 1px solid #ccc;">
				<img class="mt-4" src="<%= ctxPath%>${item.itemPhotoPath}" class="img-fluid" style="width: 80%;">
			</div>
		
			<div class="col-4 my-5">
				<div class="d-flex justify-content-between mt-5">
					<span style="font-size: 15pt; font-weight: bold;">${item.itemNo}</span>
					<span style="font-size: 13pt;"><fmt:formatNumber value="${item.price}" pattern="#,###" /> 원</span>
				</div>
				
				<div class="my-3" style="font-size: 15pt;">${item.itemName}</div>
				
				<div class="py-2 pl-3" style="background-color: white;padding-top:16px !important;padding-bottom:16px !important;">
					용량&nbsp;: <span style="padding-left:84px;">${item.volume}ml</span> 
				</div>

				<form id="cartPush" method="post" action="<%= ctxPath%>/item/cartAdd.do">
					<%-- 제품번호 --%>
					<input type="hidden" name="itemNo" value="${item.itemNo}">
				
					<%-- 수량 입력 --%>
					<div class="bg-white p-3 d-flex align-items-center mb-2" style="gap: 10px;">
					  	<label for="quantity" class="mb-0" style="min-width: 80px;">수량&nbsp;:</label>
					  	<select id="quantity" name="quantity" class="border-0 p-0" 
					          style="box-shadow: none; width: 100px; text-align: center;">
					    	<c:forEach var="itemAmount" begin="1" end="${item.itemAmount}">
					      		<option value="${itemAmount}">${itemAmount}</option>
					    	</c:forEach>
					  	</select>
					</div>

					<%-- 장바구니 담기 버튼 --%>
					<button type="submit" class="btn btn-dark w-100 py-3" style="font-weight: bold;">장바구니 담기</button>
				</form>
				
				<div class="mt-3">${item.itemInfo}</div>
			</div>
		</div>
		
		<%-- 상세 이미지 보기 버튼 & 리뷰작성 버튼--%>
		<div class="col text-center d-flex justify-content-center gap-3 my-3">
			<button type="button" class="btn btn-secondary btn-lg" id="btnMoreItem">자세히보기</button>
			<button type="button" class="btn btn-secondary btn-lg" id="btnReviews">리뷰작성</button>
		</div>			
		
		<%-- 상세 이미지 영역 --%>
			<div id="detailImageSection"></div>
			
			<div id="reviewSection" style="display:none;">	<%-- 리뷰작성 --%>
				<div id="viewComments">
					<%-- 리뷰내용나오는 곳 --%>
				</div>
				<form name="commentFrm">
					<textarea  name="contents" style="font-size: 12pt; width: 100%; height: 150px;"></textarea>
	    		    <input type="hidden" name="fk_id" value="${sessionScope.loginUser.id}" />
	   	            <input type="hidden" name="fk_itemNo" value="${requestScope.itemVO.itemNo}" />
				</form>
				<div class="col-lg-2" style="display: flex;">
			    	<button type="button" class="btn btn-outline-secondary w-100 h-100" id="btnCommentOK" style="margin: auto;">
			    		<span class="h5">후기등록</span>
		    		</button>
	    		</div>
			</div>

			<div>	
			
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
