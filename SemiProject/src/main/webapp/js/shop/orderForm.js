
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
	self.close();	
};// end of requestPayment(ctxPath, totalAmount, id, usePoint) {}--------------------

//----------------------------------------------------------------------//		
					 //	포트윈 결제하기 관련 종료
//----------------------------------------------------------------------//	

	