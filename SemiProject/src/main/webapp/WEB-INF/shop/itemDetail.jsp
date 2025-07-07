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

<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600;700&display=swap');


/* ================================
   전체 후기 영역
================================= */
div#viewComments {
    width: 80%;
    margin: 30px auto;
    text-align: left;
    max-height: 500px;
    overflow-y: auto;
}

/* ================================
   개별 후기 카드
================================= */
.review-card {
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    padding: 16px;
    margin-bottom: 16px;
    transition: transform 0.2s, box-shadow 0.2s;
}

.review-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}

.review-top {
    margin-bottom: 10px;
}

.review-meta {
    font-size: 12px;
    color: #777;
    margin-top: 5px;
}

/* ================================
   좋아요 버튼과 카운트
================================= */
.like-container {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-top: 8px;
}

.like-container i {
    color: #888;
    font-size: 20px;
    cursor: pointer;
    transition: color 0.3s;
}

.like-container i:hover {
    color: #ff4d4d;
}

.like-container span {
    font-weight: bold;
    color: #555;
    background-color: #d0e8ff; /* 연한 파랑 */
    
}

/* ================================
   후기 삭제 & 수정 버튼
================================= */
div.commentDel, div.commentUpdate {
    display: inline-block;
    font-size: 10pt;
    color: #777;
    cursor: pointer;
    margin-top: 8px;
    margin-right: 12px;
    transition: color 0.2s, background 0.2s;
    padding: 2px 6px;
    border-radius: 4px;
}

div.commentDel:hover, div.commentUpdate:hover {
    background: #2c3e50;
    color: #fff;
}

/* ================================
   textarea 후기작성 영역
================================= */
form[name="commentFrm"] textarea {
    width: 80%;
    margin: 20px auto;
    display: block;
    border: 1px solid #ccc;
    border-radius: 8px;
    padding: 10px;
    transition: border 0.2s, box-shadow 0.2s;
}

form[name="commentFrm"] textarea:focus {
    border-color: #3498db;
    box-shadow: 0 0 5px rgba(52,152,219,0.5);
    outline: none;
}

/* ================================
   후기등록 버튼
================================= */
#btnCommentOK {
    margin: 20px auto;
    display: block;
    background: #3498db;
    color: white;
    border: none;
    transition: background 0.2s, transform 0.2s;
    width: 10%
    
}

#btnCommentOK:hover {
    background: #2980b9;
    transform: translateY(-2px);
}

/* ================================
   위로가기 버튼
================================= */
#btnScrollTop {
    border: 2px solid #3498db;
    border-radius: 50%;
    width: 50px;
    height: 50px;
    transition: background 0.3s, transform 0.2s;
}

#btnScrollTop:hover {
    background: #3498db;
    color: white;
    transform: translateY(-2px);
}
</style>


<%-- JavaScript --%>
<script type="text/javascript">

let isOrderOK = false;



//특정 제품의 제품후기글들을 보여주는 함수 
 function goReviewListView() {
  
  // alert("후기글 보여주기");
  
    $.ajax({
        url:"<%= ctxPath%>/item/reviewList.do",
        type:"get",
        data:{"fk_itemNo":"${item.itemNo}"},
        dataType:"json",
         success:function(json){ 
         
            
            let v_html = "";
           
           if(json.length > 0) {
              
              $.each(json, function(index, item){
                 
                 let writeUserid = item.fk_id;
                 let loginUserid = "${sessionScope.loginUser.id}";
                 
                
			                 v_html += "<div class='review-card' id='review"+index+"'>"
			                 +   "<div class='review-top'>"
			                 +     "<div class='review-content'><span class='markColor'>▶</span>&nbsp;" + item.content + "</div>"
			                 +     "<div class='review-meta'>" + item.name + " | " + item.createdAt + "</div>"
			                 +   "</div>"
			                 +   "<div class='like-container'>"
			                 +     "<i class='fas fa-thumbs-up' style='cursor:pointer;' onclick='golikeAdd(" + item.reviewId + ")'></i>"
			                 +     "<span id='likeCnt" + item.reviewId + "' class='badge badge-primary'></span>"
			                 +   "</div>"
			                 + "</div>";
                     
			                 // ✅ 동시 요청 방지: 100ms 간격으로 AJAX 호출
			                 setTimeout(() => {
			                     goLikeCount(item.reviewId);
			                 }, 100 * index);
         
                             
                 if(loginUserid == "") { 
                     // 로그인을 안한 경우 
                     v_html += "<div class='customDisplay spacediv'>&nbsp;</div>";
                 }
                 else if(loginUserid != "" && writeUserid != loginUserid ) { 
                     // 로그인을 했으나 후기글이 로그인한 사용자 쓴 글이 아니라 다른 사용자 쓴 후기글 이라면  
                     v_html += "<div class='customDisplay spacediv'>&nbsp;</div>";
                 } 
                 else if(loginUserid != "" && writeUserid == loginUserid ) {
                     // 로그인을 했고 후기글이 로그인한 사용자 쓴 글 이라면
                     v_html += "<div class='customDisplay spacediv commentDel' onclick='delMyReview("+item.reviewId+")'>후기삭제</div>"; 
                     v_html += "<div class='customDisplay spacediv commentDel commentUpdate' onclick='updateMyReview("+index+","+item.reviewId+")'>후기수정</div>"; 
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
 
// 내가 쓴 제품후기 삭제하기 
 function delMyReview(reviewId) {
	  
	  if(confirm("제품후기를 삭제하시겠습니까?")) {
		  
		  $.ajax({
			   url:"<%= ctxPath%>/item/reviewDel.do",
			   type:"post",
			   data:{"reviewId":reviewId},
			   dataType:"json",
	 		   success:function(json){ 
	 			
	 			 
	 			    if(json.n == 1) {
	 			    	alert("제품후기를 삭제하였습니다.");
	 			    	goReviewListView(); 
	 			    }
	 			    else {
	 			    	alert("제품후기 삭제하기를 실패했습니다.");
	 			    }
	 			 
	 		   },
	 		   error: function(request, status, error){
			       alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		       }
		  });	   
	  }
	  
 }// end of function delMyReview(review_seq)---------------
 
 
//내가 쓴 제품후기 수정하기 
 function updateMyReview(index, reviewId) {
	  
	  const origin_elmt = $('div#review'+index).html(); // 원래의 제품후기 엘리먼트 
  
	    const review_contents = $('div#review'+index).find('div.review-content').text().trim().substring(2);
  
     $("div.commentUpdate").hide(); // "후기수정" 글자 감추기
     
  // "후기수정" 을 위한 엘리먼트 만들기 
	   let v_html = "<textarea id='edit_textarea' style='font-size: 12pt; width: 40%; height: 50px;'>"+review_contents+"</textarea>";
	   v_html += "<div style='display: inline-block; position: relative; top: -20px; left: 10px;'><button type='button' class='btn btn-sm btn-outline-secondary' id='btnReviewUpdate_OK'>수정완료</button></div>"; 
	   v_html += "<div style='display: inline-block; position: relative; top: -20px; left: 20px;'><button type='button' class='btn btn-sm btn-outline-secondary' id='btnReviewUpdate_NO'>수정취소</button></div>";
     
  // 원래의 제품후기 엘리먼트에 위에서 만든 "후기수정" 을 위한 엘리먼트로 교체하기    
	  $("div#review"+index).html(v_html);
  
  // 수정취소 버튼 클릭시 
     $(document).on("click", "button#btnReviewUpdate_NO", function(){
   	  $("div#review"+index).html(origin_elmt); // 원래의 제품후기 엘리먼트로 복원하기
   	  $("div.commentUpdate").show(); // "후기수정" 글자 보여주기
     });
	   
  // 수정완료 버튼 클릭시 
     $(document).on("click", "button#btnReviewUpdate_OK", function(){
   	  
   	  $.ajax({
			   url:"<%= ctxPath%>/item/reviewUpdate.do",
			   type:"post",
			   data:{"reviewId":reviewId
				    ,"content":$('textarea#edit_textarea').val()},
			   dataType:"json",
	 		   success:function(json){ 
	 			
	 			 
	 			    if(json.n == 1) {
	 			    	goReviewListView(); 
	 			    }
	 			    else {
	 			    	alert("제품후기 수정을 실패하였습니다.");
	 			    	goReviewListView(); 
	 			    }
	 			 
	 		   },
	 		   error: function(request, status, error){
			       alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		       }
		  });
   	  
     });
	   
 }// end of function updateMyReview(index, reviewId)-------
 
 
 // **** 후기에 좋아요 반응 누르기 **** // 
 function golikeAdd(reviewId) {
	  
	  if(${empty sessionScope.loginUser}) {
		   alert("좋아요 하시려면 먼저 로그인 하셔야 합니다.");
		   return; // 종료
	  }
	  
		   $.ajax({
			   url:"<%= ctxPath%>/item/likeAdd.do",
		       type:"post",
			   data:{"fk_reviewId":reviewId,
				     "fk_id":"${sessionScope.loginUser.id}"},
			   dataType:"json",
			   success:function(json){ 
			
			        //swal(json.msg);
			        
			        let current = parseInt($('#likeCnt'+reviewId).text()) || 0;
		            if(json.msg.includes("취소")) {
		                $('#likeCnt'+reviewId).text(current - 1);
		            } else {
		                $('#likeCnt'+reviewId).text(current + 1);
		            }			  
		            
			   },
			   error: function(request, status, error){
			       alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		       }
		  });
	  
	  
 }// end of function golikeAdd------------------
 
// 리뷰에 대한 좋아요 수 보여주기
 function goLikeCount(reviewId) {
	  
	  $.ajax({
		   url:"<%= ctxPath%>/item/likeCount.do",
	   //  type:"get",
		   data:{"reviewId":reviewId},
		   dataType:"json",
		   success:function(json){ 
			 
			   $('span#likeCnt'+reviewId).html(json.likecnt);
			   console.log(">>> goLikeCount item.reviewId = " + item.reviewId);
		   },
		   error: function(request, status, error){
		       alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	       }
	  });
	  
 }// end of function goLikeCount()-------------------

 

	$(function() {
		
		 //goLikeCount(reviewId);  // 좋아요 반응 수 보여주는 함수 호출하기
    	 goReviewListView();	// 제품후기글을 보여주는 함수 호출하기
    	 
    	 
		
		$('button#btnScrollTop').hide(); // 위로 가기 버튼 숨기기
		$('#reviewSection').hide();  // 리뷰내용 숨기기

		
		
		
		// 제품 상세이미지 보기 버튼을 클릭 했을 때
    	$('#btnMoreItem').click(function() {
    		
            $('#reviewSection').hide();

   			// 상세 이미지 영역에 긴 이미지 한 장 삽입
       		$('#detailImageSection').html(`
         		<img src="<%= ctxPath%>/${item.infoImg}" alt="상세 이미지" style="width: 80%; height: auto;">
       		`);
       		
   			// 상세 이미지 영역을 부드럽게 보여주고, 버튼 숨기기
       		$('#detailImageSection').slideDown(300); 
       		//$(this).hide();
       		$('button#btnScrollTop').show();
      		
    	});
    	
    	$('button#btnScrollTop').click(function(){
    		$('html, body').animate({ scrollTop: 0 }); // 맨 위로 이동
    		$('#detailImageSection').hide(); // 상세 이미지 영역 숨기기
    		$('#btnMoreItem').show(); // 제품 상세이미지 보기 버튼 보여주기
    	//	$(this).hide(); // 맨 위로 이동 버튼 숨기기
    	});
    	
    	// ------------------구매후기----------------------- 
    	
    	$('button#btnReviews').click(function(){
    		
    		// $('#reviewSection').slideToggle();
    		 $('#detailImageSection').hide();
    	        $('#reviewSection').slideDown();
    	        $('button#btnScrollTop').hide();
    		
    		
    	});
    	
    	
    	
    	// === 로그인한 사용자가 해당 제품을 구매한 상태인지 구매하지 않은 상태인지 알아오기 === // 

    	$.ajax({
 		   url:"<%= ctxPath%>/item/isOrder.do",
 		   type:"get",
 		  data:{"fk_itemNo":"${item.itemNo}",
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
     	   
     	        const review_content = $('textarea[name="content"]').val().trim();
     	   
     	        if(review_content == "") {
     	        	alert("제품후기 내용을 입력하세요!!");
     	        	$('textarea[name="content"]').val(""); // 공백제거
     	        	return; // 종료
     	        }
     	   
     	        const queryString = $('form[name="commentFrm"]').serialize();
     	       //console.log(queryString);
     	        
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
     	        		
     	        		$('textarea[name="content"]').val("").focus();
     	        	},
     	        	error: function(request, status, error){
     				   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
     		   	    }
     	        });
     	   
     	   }
     	    
     	   
     	   
        });// end of $('button#btnCommentOK').click(function(){})---------------------
 	   
 	   
 	
    	
  	})// end of ;$(function() {})--------------------------
	
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
					
					<%-- <div class="row">
					   <div class="col" style="display: flex">
					       <h3 style="margin: auto">
					          <i class="fas fa-thumbs-up fa-2x" style="cursor: pointer;" onclick="golikeAdd('${requestScope.itemVO.itemNo}')"></i> 
					          <span id="likeCnt" class="badge badge-primary"></span>
					       </h3>
					   </div>
					</div> --%>
				</div>
				<form name="commentFrm">
					<textarea  name="content" style="font-size: 12pt; width: 80%; height: 150px;"></textarea>
	    		    <input type="hidden" name="fk_id" value="${sessionScope.loginUser.id}" />
	   	            <input type="hidden" name="fk_itemNo" value="${item.itemNo}" />
				</form>
				<div style="text-align: center;">
			    	<button type="button" class="btn btn-outline-secondary" id="btnCommentOK" style="margin: auto;">
			    		<span class="h5">리뷰등록</span>
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