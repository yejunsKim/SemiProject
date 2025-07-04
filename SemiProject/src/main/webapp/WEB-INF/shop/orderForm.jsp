<%@page import="java.awt.event.ItemEvent"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<%
    String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp" />

<style>

	div#divOrder {
		text-align: center;
	}
	
	table#tblOrder {
		width: 80%;
		margin: 1% auto;
	}
	
	table#tblOrder td {
		line-height: 200%;
		padding: 1.2% 0;
	}
	
	table#tblOrder > tbody > tr > td:first-child {
		width: 20%;
		text-align: left;
	}
	
	table#tblOrder > tbody > tr > td:nth-child(2) {
		width: 80%;
		text-align: left;
	}
	
	span.star {
		color: red;
		font-weight: bold;
		font-size: 13pt;
	}
	
	#postcodeSearch {
 	  vertical-align: middle;
	  cursor: pointer;
	  height: 30px; /* input 높이에 맞게 고정 (필요 시 조절) */
	}
	
	span#emailCheck {
		border: solid 1px gray;
		border-radius: 5px;
		font-size: 8pt;
		display: inline-block;
		width: 80px;
		height: 30px;
		text-align: center;
		margin-left: 10px;
		cursor: pointer;
	}
}

</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">

	let b_emailcheck_click = true; 
	//회원 수정의 이메일은 자동으로 받아오기 때문에, 건들지만 않으면 true가 맞다.

	
	$(function(){
		
		$('span.error').hide();
		$('input#name').focus();
		
		$('input#name').blur((e) => { 
			   
	 		// alert($(e.target).val());
				
			const name = $(e.target).val().trim();
			if(name == "") {
				// 입력하지 않거나 공백만 입력했을 경우
					
				$('table#tblOrder :input').prop('disabled', true);
				$(e.target).prop('disabled', false);
				$(e.target).val('').focus();
					
			//	$(e.target).next().show();
			//  또는
			    $(e.target).parent().find('span.error').show();
			}
			else {
				// 공백이 아닌 글자를 입력했을 경우
				$('table#tblUserEdit :input').prop('disabled', false);
					
		 	// 	$(e.target).next().hide();
		 	// 	또는
				$(e.target).parent().find('span.error').hide();
			}
					
			
			
		});	// end of $('input#name').blur((e) => {})-------------------
		
		
		$('input#postcode').blur((e) => { 
			
 		//	const regExp_hp3 = /^[0-9]{4}$/;
		// 	또는
			const regExp_postcode = /^\d{5}$/;
			// 숫자 5자리만 들어오도록 정규표현식 객체 생성
				
			const bool = regExp_postcode.test($(e.target).val());
				
			if(!bool) {
				// 우편번호가 정규표현식에 위배된 경우
						
				$('table#tblOrder :input').prop('disabled', true);
				$(e.target).prop('disabled', false);
				$(e.target).val('').focus();
						
			//	$(e.target).next().show();
			//  또는
			    $(e.target).parent().find('span.error').show();
			}
			else {
				// 우편번호가 정규표현식에 맞는 경우
				$('table#tblOrder :input').prop('disabled', false);
					
		     // $(e.target).next().next().hide();
			 // 또는
				$(e.target).parent().find('span.error').hide();
			}
						
		});	// end of $('input#postcode').blur((e) => {})-------------------
			
			
		//////////////////////////////////////////////////////////////////////
			
		/*	
	        >>>> .prop() 와 .attr() 의 차이 <<<<	         
	             .prop() ==> form 태그내에 사용되어지는 엘리먼트의 disabled, selected, checked 의 속성값 확인 또는 변경하는 경우에 사용함. 
	             .attr() ==> 그 나머지 엘리먼트의 속성값 확인 또는 변경하는 경우에 사용함.
		*/
				
		// 우편번호를 읽기전용(readonly)로 만들기 
		$('input#postcode').attr('readonly', true);
		
		// 주소를 읽기전용(readonly)로 만들기 
		$('input#address').attr('readonly', true);
		
		// 참고항목을 읽기전용(readonly)로 만들기 
		$('input#addressExtra').attr('readonly', true);
				
		// ==== "우편번호찾기"를 클릭했을때 이벤트 처리하기 ==== //
		$('img#postcodeSearch').click(function(){
			new daum.Postcode({
			    oncomplete: function(data) {
			        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
			        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			        let addr = ''; // 주소 변수
			        let extraAddr = ''; // 참고항목 변수

			        //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
			            addr = data.roadAddress;
			        } else { // 사용자가 지번 주소를 선택했을 경우(J)
			            addr = data.jibunAddress;
			        }

			        // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
			        if(data.userSelectedType === 'R'){
			            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
			            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
			                extraAddr += data.bname;
			            }
			            // 건물명이 있고, 공동주택일 경우 추가한다.
			            if(data.buildingName !== '' && data.apartment === 'Y'){
			                extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			            }
			            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
			            if(extraAddr !== ''){
			                extraAddr = ' (' + extraAddr + ')';
			            }
			            // 조합된 참고항목을 해당 필드에 넣는다.
			            document.getElementById("addressExtra").value = extraAddr;
			        
			        } else {
			            document.getElementById("addressExtra").value = '';
			        }

			        // 우편번호와 주소 정보를 해당 필드에 넣는다.
			        document.getElementById('postcode').value = data.zonecode;
			        document.getElementById("address").value = addr;
			        // 커서를 상세주소 필드로 이동한다.
			        document.getElementById("addressDetail").focus();
			    }
			}).open();
					
		});// end of $('img#postcodeSearch').click(function(){})---------------
			
		$('input#hp2').blur((e) => { 
			
		    const regExp_hp2 = /^[1-9][0-9]{3}$/; 
			// 연락처 국번( 숫자 4자리인데 첫번째 숫자는 1-9 이고 나머지는 0-9) 정규표현식 객체 생성
			
			const bool = regExp_hp2.test($(e.target).val());
			
			if(!bool) {
				// 연락처 국번이 정규표현식에 위배된 경우
					
				$('table#tblOrder :input').prop('disabled', true);
				$(e.target).prop('disabled', false);
				$(e.target).val('').focus();
					
			//	$(e.target).next().show();
			//  또는
			    $(e.target).parent().find('span.error').show();
			}
			else {
				// 연락처 국번이 정규표현식에 맞는 경우
				$('table#tblOrder :input').prop('disabled', false);
					
		     // $(e.target).next().hide();
			 // 또는
				$(e.target).parent().find('span.error').hide();
			}
					
		});	// end of $('input#hp2').blur((e) => {})-------------------	
			
			
		$('input#hp3').blur((e) => { 
					
		 // const regExp_hp3 = /^[0-9]{4}$/;
		 // 또는
			const regExp_hp3 = /^\d{4}$/;
			// 연락처 마지막 4자리( 숫자만 되어야 함) 정규표현식 객체 생성
			
			const bool = regExp_hp3.test($(e.target).val());
			
			if(!bool) {
				// 연락처 마지막 4자리가 정규표현식에 위배된 경우
					
				$('table#tblOrder :input').prop('disabled', true);
				$(e.target).prop('disabled', false);
				$(e.target).val('').focus();
					
			//	$(e.target).next().show();
			//  또는
			    $(e.target).parent().find('span.error').show();
			}
			else {
				// 연락처 마지막 4자리가 정규표현식에 맞는 경우
				$('table#tblOrder :input').prop('disabled', false);
					
		     // $(e.target).next().hide();
			 // 또는
				$(e.target).parent().find('span.error').hide();
			}
					
		});	// end of $('input#hp3').blur((e) => {})-------------------	
			
		$('input#email').blur((e) => { 
			
		    const regExp_email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
			// 이메일 정규표현식 객체 생성
			
			const bool = regExp_email.test($(e.target).val());
			
			if(!bool) {
				// 이메일이 정규표현식에 위배된 경우
					
				$('table#tblOrder :input').prop('disabled', true);
				$(e.target).prop('disabled', false);
				$(e.target).val('').focus();
					
			//	$(e.target).next().show();
			//  또는
			    $(e.target).parent().find('span.error').show();
			}
			else {
				// 이메일이 정규표현식에 맞는 경우
				$('table#tblOrder :input').prop('disabled', false);
					
		     // $(e.target).next().hide();
			 // 또는
				$(e.target).parent().find('span.error').hide();
			}
					
		});	// end of $('input#email').blur((e) => {})-------------------	
			
		
	 	
		// 현재주소지로 변경 버튼을 눌렀을 때
	 	$('#btnUseCurrentAddress').click(function() {
	 		
	 		const postcode = $('input#postcode').val().trim();
	 		const address = $('input#address').val().trim();
	 		const addressDetail = $('input#addressDetail').val().trim();
	 		const addressExtra = $('input#addressExtra').val().trim();
	 		
	 		
	 		if(postcode === '' || address === '') {
 				alert("주소를 입력해주세요.")
 				return;
 			} // 만약 주소를 입력(찾기)하지 않았다면, 경고 후 함수종료시키기.
 			if(addressDetail === '' ) {
 				alert("상세주소를 입력해주세요.")
 				return;
 			}
 			
 			$.ajax({
 				url:"user/userUpdateAddress.do",
 				data:{"postcode":postcode,
 					  "address":address,
 					  "addressDetail":addressDetail,
 					  "addressExtra":addressExtra},
 				// data 속성은 http://localhost:9090/SemiProject/user/userRegister.do 로 
 				// 전송해야할 데이터를 말한다.
 				type:"post",
 				async:true, 
 				dataType:"json",  
 				
 				success:function(json){
 					console.log(json);
 					// {"isChanged":false} 또는 {"isChanged":true}
 					
 					if(json.isChanged) {
 						// isChanged가 true로 응답되면 주소 업데이트완료.
 						alert("변경이 완료되었습니다.");
 					};
 				},
 				error: function(request, status, error){
 	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
 	            }				  
 			});
	 	});
			
		// 포인트 입력하는 input에 pattern을 넣는 방법.(###,###)처럼
	 	$('#usePoint').on('input', function() {
	 	    // 입력된 값에서 숫자만 추출 (쉼표나 POINT 제거)
	 	    let raw = $(this).val().replace(/[^\d]/g, "");

	 	    // 정수로 변환
	 	    let inputPoint = parseInt(raw || 0);

	 	    // 최대 포인트보다 크면 보유 포인트로 되돌리기
	 	    if (inputPoint > ${sessionScope.loginUser.point}) {
	 	        inputPoint = ${sessionScope.loginUser.point};
	 	    }

	 	    // 다시 쉼표 붙여서 보여주기
	 	    let formatted = inputPoint.toLocaleString();
	 	    $(this).val(formatted);
	 	});
		
	
		
 	// 결제하기 버튼을 눌렀을 때 배송지가 입력되었는지, 약관에 동의 했는지
	 	$('#btnOrderSubmit').click(function(e) {
		    if ( $('#name').val().trim() === "") {
		       alert("받는 사람을 입력해주세요.");
		       $('#name').focus();
		       e.preventDefault();
		       return false;
		    }
		
		    if ( $('#postcode').val().trim() === "") {
		       alert("우편번호를 입력해주세요.");
		       $('#postcode').focus();
		       e.preventDefault();
		       return false;
		    } 
		
		    if ($('#address').val().trim() === "") {
		       alert("주소를 입력해주세요.");
		       $('#address').focus();
		       e.preventDefault();
		       return false;
		    }
		
		    if ( $('#addressDetail').val().trim() === "") {
		       alert("상세주소를 입력해주세요.");
		       $('#addressDetail').focus();
		       e.preventDefault();
		       return false;
		    }
		    
		   /*  if ( $('#addressExtra').val().trim() === "") {
			       alert("참고항목(동)를 입력해주세요.");
			       $('#addressDetail').focus();
			       e.preventDefault();
			       return false;
			    }
		 */
 		   if ($('#email').val().trim() === "") {
		       alert("이메일을 입력해주세요.");
		       $('#email').focus();
		       e.preventDefault();
		       return false;
 		   }

	 		// 약관에 동의 했는지
	 		if (!$('#agree').is(':checked')) {
	            e.preventDefault(); // form 전송 막기
	            alert("이용약관에 동의해야 결제가 가능합니다.");
	            $('#agree').focus();
	            return false;
	        }
	 		
////////////////////////////////////////////////////////////////////////// 
	 		
					 //	포트윈 결제하기 관련 여기서 부터
		 
////////////////////////////////////////////////////////////////////////// 
	 
 			const ctxPath = "<%= ctxPath%>";
 		//	console.log($('#finalPrice > strong').attr('data-price'));
 			const totalAmount = $('#finalPrice > strong').attr('data-price');
 		//	console.log($('th#loginUserId').html().trim());
 			const id = $('th#loginUserId').html().trim();
 		// 	console.log($('input#usePoint').val());
 			const usepoint = $('input#usePoint').val();
 		
	 		// ==== 포트원(구 아임포트) 결제
	 		requestPayment(ctxPath, totalAmount, id, usepoint);
	    });
		
//////  *** 유저 아이디를 찾기 위해 header에 loginUserId 라는 id값을 주었음. ***  ////// 
// <th id="loginUserId" colspan="3" .... > ${sessionScope.loginUser.id} </th>

		console.log("<%= ctxPath%>");
		console.log($('th#loginUserId').html().trim()); // 확인

}); 
// end of $(function(){})--------------------------------

// ==== 포트원(구 아임포트) 결제를 해주는 함수 ==== //
function requestPayment(ctxPath, coinmoney, userid, usepoint) {
	
	const url = `${ctxPath}/item/itemPayment.do?userid=${userid}&coinmoney=${coinmoney}&usepoint=${usepoint}`;
//	console.log(url);
	// 너비 1000, 높이 600 인 팝업창을 화면 가운데 위치시키기
	const width = 1000;
	const height = 600;
	
	const left = Math.ceil((window.screen.width - width) / 2);	// 정수로 만듬
							// 1400 - 1000 = 400		400/2 ==> 200
	
	const top = Math.ceil((window.screen.height - height) / 2);	// 정수로 만듬
							// 1400 - 600 = 800		800/2 ==> 400
	
	window.open(url, "payment", `left=${left}, top=${top}, width=${width}, height=${height}`);
	
}// end of function goCoinPurchaseTypeChoice(userid, ctx_Path) {}--------------------

//----------------------------------------------------------------------//		
					 //	포트윈 결제하기 관련 종료
//----------------------------------------------------------------------//	
	
//결제완료시 해당 함수 호출됨!
function paymentSuccess(id, usepoint, totalAmount) {
	
	console.log(id, usepoint, totalAmount);
	
	// 여기서 orderAdd 예정
	
	
}// end of function paymentSuccess()-----------------------------



//----------------------------------------------------------------------//
				//	포트윈 결제 후, orderAdd 함수까지 종료!
//----------------------------------------------------------------------//	
	
	window.addEventListener('DOMContentLoaded', function() {
	    const priceSpans = document.querySelectorAll('.item-price');
	    const totalPrice = document.querySelector('#totalPrice');
	    const finalPrice = document.querySelector('#finalPrice');
	    const usePointInput = document.querySelector('#usePoint');
	    const maxPoint = ${sessionScope.loginUser.point};
	
	    function calcTotalPrice() {
	        let total = 0;
	        priceSpans.forEach(span => {
	            const raw = span.getAttribute('data-price');
	            total += parseInt(raw);
	        });
	        return total;
	    }
	
	    function updatePrices() {
	        const total = calcTotalPrice();
	        const usedPoint = parseInt(usePointInput.value.replace(/[^\d]/g, '')) || 0;
	        const adjustedUsed = usedPoint > maxPoint ? maxPoint : usedPoint;
	        const final = Math.max(total - adjustedUsed, 0);
	
	        // 가격 표시
	        totalPrice.textContent = total.toLocaleString() + '원';
	        finalPrice.innerHTML = '<strong data-price="' + final + '">' + final.toLocaleString() + '원</strong>';
	    }
	
	    // 포인트 입력 시마다 금액 업데이트
	    usePointInput.addEventListener('input', () => {
	        let raw = usePointInput.value.replace(/[^\d]/g, '');
	        let num = parseInt(raw || 0);
	        if (num > maxPoint) num = maxPoint;
	        usePointInput.value = num.toLocaleString();
	        updatePrices();
	    });
	
	    // 초기 실행
	    updatePrices();
	});
	
	
	
</script>

	<div class="col-md-12" id="divOrder" style="background-color: #f5f5f5;padding-top:80px;">
      	<form name="orderFrm" method="post">
      	
      		<%-- 배송지 --%>
      		<div class="section">
	      		<table id="tblOrder">
	             	<thead>
	                	<tr class="h3">
	                   		<th colspan="2">주문서 작성</th>
	                	</tr>
	             	</thead>
	             	
	             	<tbody>
	             		<tr class="h5">
	                   		<td>배송지</td>
	                	</tr>
	                	           
		                <tr>
	                    	<td>받는사람&nbsp;<span class="star">*</span></td>
		                    <td>
		                       	<input type="hidden" name="id" value="${sessionScope.loginUser.id}" />
								<input type="text" id="name" name='name' maxlength="30" class="requiredInfo" value="${sessionScope.loginUser.name}">
								<span class="error">필수 입력 사항입니다</span>
	                    	</td>
	                	</tr>
	                
	                	<tr>
                    		<td>우편번호&nbsp;<span class="star">*</span></td>
                    		<td>
                       			<input type="text" name="postcode" id="postcode" size="10" maxlength="5" value="${sessionScope.loginUser.postcode}" />&nbsp;&nbsp;
                       			<%-- 우편번호 찾기 --%>
                       			<img src="<%= ctxPath%>/images/find_postcode.gif" width="27px" id="postcodeSearch" />
                       			&nbsp;&nbsp;&nbsp;
                       			<span class="error">우편번호 형식에 맞지 않습니다.</span>
                       			<button type="button" id="btnUseCurrentAddress" style="padding: 5px 10px; border: 3pt">
				            		현재 주소지로 변경
				        		</button>
               	   	 		</td>
            			</tr>
            			
		                <tr>
							<td>주소&nbsp;<span class="star">*</span></td>
							<td>
                       			<input type="text" name="address" id="address" size="40" maxlength="200" placeholder="주소"  value="${sessionScope.loginUser.address}" /><br>
                  		   		<input type="text" name="detailAddress" id="addressDetail" size="40" maxlength="200" placeholder="상세주소" value="${sessionScope.loginUser.addressDetail}"/>
                 		   		&nbsp;
                  		   		<input type="text" name="extraAddress" id="addressExtra" size="40" maxlength="200" placeholder="참고항목" value="${sessionScope.loginUser.addressExtra}"/>            
                   				<span class="error">주소를 입력하세요.</span>
               				</td>
						</tr>
						
		                <tr>
		                    <td>연락처&nbsp;<span class="star">*</span></td>
		                    <td>
		                       	<input type="text" id="hp1" name='hp1' size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp; 
								<input type="text" name="hp2" id="hp2" size="6" maxlength="4" value="${fn:substring(sessionScope.loginUser.mobile, 3, 7)}" />&nbsp;-&nbsp; 
                       			<input type="text" name="hp3" id="hp3" size="6" maxlength="4" value="${fn:substring(sessionScope.loginUser.mobile, 7, 11)}" />    
                       			<span class="error">휴대폰 형식이 아닙니다.</span>
		                    </td>
		                </tr>
		                
		                <tr style="border-bottom: 1px solid">
		                    <td>이메일&nbsp;<span class="star">*</span></td>
		                    <td>
		                       	<input type="text" name="email" id="email" maxlength="60" class="requiredInfo" value="${sessionScope.loginUser.email}" /> 
								<%-- 이메일 중복체크 --%>
                				<span id="emailCheckResult"></span>
								<span class="error">이메일 형식에 맞지 않습니다</span>
		                    </td>
		                </tr>
	                </tbody>	                
           		</table>
	    	</div>
	    	
	    	<!-- 주문상품 -->
			<div class="section">
				<table id="tblOrder">
					<tr class="h5">
                   		<td>주문상품</td>
                	</tr>
                	<c:forEach var="item" items="${requestScope.orderItemList}">
                		<tr style="border-bottom: 1px solid">
							<td style="width: 100px;">
								<span>
									<img src="<%= ctxPath%>${item.itemPhotoPath}" alt="상품 이미지" style="width: 60px; height: auto;" />
								</span>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<span class="item-price" data-price="${item.price * item.cartvo.cartamount}">
									${item.itemName}&nbsp;${item.volume}ml
								</span>
							    &nbsp;&nbsp;&nbsp;
							    <span class="quantity" data-price="${item.cartvo.cartamount}">
									X ${item.cartvo.cartamount}개
								</span>
							    &nbsp;&nbsp;&nbsp;
							    <span> 
									<fmt:formatNumber value="${item.price * item.cartvo.cartamount}" pattern="###,###"/>원
								</span>
								<span class="itemNo" style="display: none;">${item.itemNo}</span>
							</td>
						</tr>
                	</c:forEach>
				</table>
			</div>
			
			<!-- 결제정보 -->
			<div class="section">
				<table id="tblOrder">
					<tr class="h5">
                   		<td>결제정보</td>
                	</tr>
					<tr>
						<td>상품금액</td>
						<td id="totalPrice" style="text-align: right;"></td>
					</tr>
					<tr>
						<td>배송비</td>
						<td style="text-align: right;">무료</td>
					</tr>
					<tr>
						<td>포인트</td>
						<td style="text-align: right;">
							<span>보유 포인트:&nbsp;
								<strong style="color: navy;">
									<fmt:formatNumber value="${sessionScope.loginUser.point}" pattern="###,###"/> POINT
								</strong>
							</span>
							&nbsp;&nbsp;&nbsp;
							<span>사용:
								<input type="text" name="usePoint" id="usePoint" 
									   style="width: 100px; text-align: right; margin-left: 10px;" 
									   value="${sessionScope.loginUser.point}" />&nbsp;POINT
							</span>
						</td>
					</tr>
					<tr style="border-bottom: 1px solid">
						<td><strong>최종 결제 금액</strong></td>
						<td id="finalPrice" name="finalPrice" style="text-align: right;"><strong></strong></td>
					</tr>
				</table>
			</div>
			
			<!-- 결제수단 -->
			<div class="section">
				<table id="tblOrder">
					<tr class="h5" >
                   		<td>결제수단</td>
                	</tr>
                	<tr style="border-bottom: 1px solid">
                		<td colspan="2">
					        <label><input type="radio" name="paymentMethod" value="card" checked /> 카드결제</label>
					    </td>
                	</tr>
				</table>
			</div>
		
			<!-- 개인정보 동의 및 결제 버튼 -->
			<div>
				<table id="tblOrder">
					<tr class="h5" >
                   		<td colspan="2">
                    		<label for="agree">이용약관에 동의합니다</label>&nbsp;&nbsp;<input type="checkbox" id="agree" />
                   		</td>
               		</tr>
               		<tr>
                   		<td colspan="2">
                      		<iframe src="<%= ctxPath%>/iframe_agree/agree.html" width="100%" height="150px" style="border: solid 1px navy;"></iframe>
                   		</td>
               		</tr>
               		<tr>
					    <td colspan="2" style="text-align: center; padding-top: 20px;">
					        <button type="button" id="btnOrderSubmit" style="padding: 10px 30px; font-size: 16px; font-weight: bold;">
					            결제하기
					        </button>
					    </td>
					</tr>
				</table>
				
			</div>
		
   		</form>
   		
	</div>

<jsp:include page="../footer.jsp" />