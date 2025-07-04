
// ==== 포트원(구 아임포트) 결제를 해주는 함수 ==== //
function requestPayment(ctxPath, id, email, usePoint, totalAmount) {
	console.log(ctxPath+ totalAmount+ id+ usePoint)
	
	const url = ctxPath+"/item/itemPayment.do?id="+id+"&email="+email+"&totalAmount="+totalAmount+"&usePoint="+usePoint;
	//console.log(url); 위에처럼 하지 않고, ${}로 사용하면 값이 들어가질 않음.
	
	// 너비 1000, 높이 600 인 팝업창을 화면 가운데 위치시키기
	const width = 1000;
	const height = 600;
	
	const left = Math.ceil((window.screen.width - width) / 2);	// 정수로 만듬
							// 1400 - 1000 = 400		400/2 ==> 200
	
	const top = Math.ceil((window.screen.height - height) / 2);	// 정수로 만듬
							// 1400 - 600 = 800		800/2 ==> 400
	
	window.open(url, "payment", "left=" + left + ", top=" + top + ", width=" + width + ", height=" + height);	
								//  ${}로 사용하면 오류 발생함. 이게 제일 안전함
		
};// end of requestPayment(ctxPath, totalAmount, id, usePoint) {}--------------------

//----------------------------------------------------------------------//		
					 //	포트윈 결제하기 관련 종료
//----------------------------------------------------------------------//	

//결제완료시 해당 함수 호출됨!
function paymentSuccessOrderService(id, usePoint, totalAmount) {
	
	console.log(id, usePoint, totalAmount);
	
	 //// === 체크박스의 체크된 value값(checked 속성이용) === ////
	   //// === 체크가 된 것만 읽어와서 배열에 넣어준다. === ////
	   
	   const allCnt = $("input:checkbox[name='pnum']").length;
	   
	   const pnumArr = new Array();        // 또는 const pnumArr = [];
	   const oqtyArr = new Array();        // 또는 const oqtyArr = [];
	   const pqtyArr = new Array();        // 또는 const pqtyArr = [];
	   const cartnoArr = new Array();      // 또는 const cartnoArr = [];
	   const totalPriceArr = new Array();  // 또는 const totalPriceArr = [];
	   const totalPointArr = new Array();  // 또는 const totalPointArr = []; 
	   
	   for(let i=0; i<allCnt; i++){
		   if( $("input:checkbox[name='pnum']").eq(i).prop("checked") ) {
			  
			   console.log("제품번호 : ", $("input:checkbox[name='pnum']").eq(i).val() );
			   console.log("주문량 : ", $('input.oqty').eq(i).val() );
			   console.log("잔고량 : ", $('input.pqty').eq(i).val() );
			   console.log("삭제해야할 장바구니 번호 : ", $('input.cartno').eq(i).val() );
			   console.log("주문한 제품의 개수에 따른 가격합계 : ", $('input.totalPrice').eq(i).val() );
			   console.log("주문한 제품의 개수에 따른 포인트합계 : ", $('input.totalPoint').eq(i).val() );
			   console.log("======================================");
			
			 
			   pnumArr.push($("input:checkbox[name='pnum']").eq(i).val());  
			   oqtyArr.push($('input.oqty').eq(i).val());
			   pqtyArr.push($('input.pqty').eq(i).val());
			   cartnoArr.push($('input.cartno').eq(i).val());
			   totalPriceArr.push($('input.totalPrice').eq(i).val());
			   totalPointArr.push($('input.totalPoint').eq(i).val());
		   }
	   }// end of for-------------------
	   
	 
	   for(let i=0; i<checkCtn; i++){
		   console.log("확인용 제품번호: " + pnumArr[i] + ", 주문량: " + oqtyArr[i] + ", 잔고량: " + pqtyArr[i] + ", 장바구니번호 : " + cartnoArr[i] + ", 주문금액: " + totalPriceArr[i] + ", 포인트: " + totalPointArr[i]);
		   /*
		      확인용 제품번호: 58, 주문량: 1, 잔고량: 20, 장바구니번호 : 8, 주문금액: 10000, 포인트: 10
           확인용 제품번호: 5, 주문량: 3, 잔고량: 100, 장바구니번호 : 7, 주문금액: 99000, 포인트: 60
           확인용 제품번호: 56, 주문량: 2, 잔고량: 100, 장바구니번호 : 6, 주문금액: 2000000, 포인트: 120
		   */
	   }// end of for--------------------
	
	   
	   for(let i=0; i<checkCtn; i++){
		  if( Number(pqtyArr[i]) < Number(oqtyArr[i]) ) {
			  // 주문할 제품중 아무거나 하나가 잔고량이 주문량 보다 적을 경우 
			  alert("제품번호 "+ pnumArr[i] +" 의 주문개수가 잔고개수 보다 더 커서 진행할 수 없습니다.");
			  location.href="javascript:history.go(0)";
			  return; // goOrder 함수 종료 
		  }
	   }// end of for--------------------
	   
	   
	   const str_pnum = pnumArr.join();
	   const str_oqty = oqtyArr.join();
	   const str_cartno = cartnoArr.join();
	   const str_totalPrice = totalPriceArr.join();
	   const str_totalPoint = totalPointArr.join();
	       
   
    console.log("확인용 str_pnum : ", str_pnum);                 // 확인용 str_pnum :  58,5,56
	   console.log("확인용 str_oqty : ", str_oqty);                 // 확인용 str_oqty :  1,3,2	  
	   console.log("확인용 str_cartno : ", str_cartno);             // 확인용 str_cartno :  8,7,6
	   console.log("확인용 str_totalPrice : ", str_totalPrice);     // 확인용 str_totalPrice :  10000,99000,2000000
	   console.log("확인용 str_totalPoint : ", str_totalPoint);     // 확인용 str_totalPoint :  10,60,120    

 
	   let n_sum_totalPrice = 0;
    for(let i=0; i<totalPriceArr.length; i++){
 	   n_sum_totalPrice += Number(totalPriceArr[i]);
    }// end of for-------------------
    
	   let n_sum_totalPoint = 0;
	   for(let i=0; i<totalPointArr.length; i++){
		   n_sum_totalPoint += Number(totalPointArr[i]);
    }// end of for-------------------
    
   
	   console.log("확인용 n_sum_totalPrice : ", n_sum_totalPrice);  // 확인용 n_sum_totalPrice :  2109000
	   console.log("확인용 n_sum_totalPoint : ", n_sum_totalPoint);  // 확인용 n_sum_totalPoint :  190 
	
    
    const current_coin = $(sessionScope.loginUser.coin);
    
    if(current_coin < n_sum_totalPrice) {
 	   $("p#order_error_msg").html("코인잔액이 부족하므로 주문이 불가합니다.<br>주문총액 : "+ n_sum_totalPrice.toLocaleString('en') +"원 / 코인잔액 : "+ current_coin.toLocaleString('en') +"원").css({'display':''});      
  	   // 숫자.toLocaleString('en') 이 자바스크립트에서 숫자 3자리마다 콤마 찍어주기 이다.   
  	   return; // 종료
    }
    else {
 	   $("p#order_error_msg").css({'display':'none'});
 	   
 	   if( confirm("총주문액 "+ n_sum_totalPrice.toLocaleString('en') + "원을 주문하시겠습니까?") ) { 
 		   
 		   $("div.loader").show(); // CSS 로딩화면 보여주기
 		   
 		   $.ajax({
 			   url:"<%= ctxPath%>/item/orderService.do",
     		   type:"post",
     		   data:{"n_sum_totalPrice":n_sum_totalPrice,
				         "n_sum_totalPoint":n_sum_totalPoint,
				         "str_pnum_join":str_pnum,
				         "str_oqty_join":str_oqty,
 				     "str_totalPrice_join":str_totalPrice,
 				     "str_cartno_join":str_cartno
			       },
			       dataType:"json",
 			   success:function(json){ // json ==> {"isSuccess":1} 또는 {"isSuccess":0}
 				    if(json.isSuccess == 1){
 					   location.href="<%= ctxPath%>/shop/orderList.up"; 
 				    }
 				    else {
						   location.href="<%= ctxPath%>/shop/orderError.up";
					    }
 			   },
 			   error: function(request, status, error){
 			         alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
 		       }
 		   });
 		   
 	   } 
 	   
    }
	
	
	
	// 여기서 orderAdd 예정
	//OrderService
	 
	
}// end of function paymentSuccess()-----------------------------


//----------------------------------------------------------------------//
				//	포트윈 결제 후, orderAdd 함수까지 종료!
//----------------------------------------------------------------------//	
	
	