<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<!DOCTYPE html>

<html>
<!-- Required meta tags -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 

<!-- Font Awesome 6 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css">

<!-- 직접 만든 CSS -->
<%-- <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/template.css" />
 --%>
<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

<%-- jQueryUI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>

<script type="text/javascript">

let b_idcheck_click = false;
// "아이디중복확인" 을 클릭했는지, 클릭을 안했는지 여부를 알아오기 위한 용도

let b_emailcheck_click = false;
// "이메일중복확인" 을 클릭했는지, 클릭을 안했는지 여부를 알아오기 위한 용도

$(function(){
	
	$('span.error').hide();
	$('input#name').focus();
	
 //	$('input#name').bind('blur', function(){ alert('name 에 있던 포커스를 잃어버렸습니다-1.'); });
 // 또는
 // $('input#name').blur(function(){ alert('name 에 있던 포커스를 잃어버렸습니다-2.'); });
 
    $('input#name').blur((e) => { 
	   
	 // alert($(e.target).val());
		
		const name = $(e.target).val().trim();
		if(name == "") {
			// 입력하지 않거나 공백만 입력했을 경우
			
			$('table#tblUserRegister :input').prop('disabled', true);
			$(e.target).prop('disabled', false);
			$(e.target).val('').focus();
			
		//	$(e.target).next().show();
		//  또는
		    $(e.target).parent().find('span.error').show();
		}
		else {
			// 공백이 아닌 글자를 입력했을 경우
			$('table#tblUserRegister :input').prop('disabled', false);
			
		 // $(e.target).next().hide();
		 // 또는
			$(e.target).parent().find('span.error').hide();
		}
			
	});	// end of $('input#name').blur((e) => {})-------------------
	
	
	
	$('input#id').blur((e) => { 
		   
	 // alert($(e.target).val());
			
		const id = $(e.target).val().trim();
		if(id == "") {
			// 입력하지 않거나 공백만 입력했을 경우
				
			$('table#tblUserRegister :input').prop('disabled', true);
			$(e.target).prop('disabled', false);
			$(e.target).val('').focus();
				
		//	$(e.target).next().next().next().show();
		//  또는
		    $(e.target).parent().find('span.error').show();
		}
		else {
			// 공백이 아닌 글자를 입력했을 경우
			$('table#tblUserRegister :input').prop('disabled', false);
				
	     // $(e.target).next().next().next().hide();
		 // 또는
			$(e.target).parent().find('span.error').hide();
		}
				
	});	// end of $('input#id').blur((e) => {})-------------------
	
	
	$('input#password').blur((e) => { 
			   
	 // alert($(e.target).val());
		
	    const regExp_password = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
		// 숫자/문자/특수문자 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
		
		const bool = regExp_password.test($(e.target).val());
		
		if(!bool) {
			// 암호가 정규표현식에 위배된 경우
				
			$('table#tblUserRegister :input').prop('disabled', true);
			$(e.target).prop('disabled', false);
			$(e.target).val('').focus();
				
		//	$(e.target).next().show();
		//  또는
		    $(e.target).parent().find('span.error').show();
		}
		else {
			// 암호가 정규표현식에 맞는 경우
			$('table#tblUserRegister :input').prop('disabled', false);
				
	     // $(e.target).next().hide();
		 // 또는
			$(e.target).parent().find('span.error').hide();
		}
				
	});	// end of $('input#password').blur((e) => {})-------------------	
	
	
	$('input#passwordCheck').blur((e) => { 
	 	
		if( $('input#password').val() != $(e.target).val() ) {
			// 암호와 암호확인값이 틀린 경우
				
			$('table#tblUserRegister :input').prop('disabled', true);
			$('input#password').prop('disabled', false);
			$(e.target).prop('disabled', false);
			
			$('input#password').val('').focus();
			$(e.target).val('');
				
		//	$(e.target).next().show();
		//  또는
		    $(e.target).parent().find('span.error').show();
		}
		else {
			// 암호와 암호확인값이 같은 경우
			$('table#tblUserRegister :input').prop('disabled', false);
				
	     // $(e.target).next().hide();
		 // 또는
			$(e.target).parent().find('span.error').hide();
		}
				
	});	// end of $('input#passwordCheck').blur((e) => {})-------------------
	
	
	$('input#email').blur((e) => { 
		
	    const regExp_email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
		// 이메일 정규표현식 객체 생성
		
		const bool = regExp_email.test($(e.target).val());
		
		if(!bool) {
			// 이메일이 정규표현식에 위배된 경우
				
			$('table#tblUserRegister :input').prop('disabled', true);
			$(e.target).prop('disabled', false);
			$(e.target).val('').focus();
				
		//	$(e.target).next().show();
		//  또는
		    $(e.target).parent().find('span.error').show();
		}
		else {
			// 이메일이 정규표현식에 맞는 경우
			$('table#tblUserRegister :input').prop('disabled', false);
				
	     // $(e.target).next().hide();
		 // 또는
			$(e.target).parent().find('span.error').hide();
		}
				
	});	// end of $('input#email').blur((e) => {})-------------------	
	

	
	$('input#hp2').blur((e) => { 
			
	    const regExp_hp2 = /^[1-9][0-9]{3}$/; 
		// 연락처 국번( 숫자 4자리인데 첫번째 숫자는 1-9 이고 나머지는 0-9) 정규표현식 객체 생성
		
		const bool = regExp_hp2.test($(e.target).val());
		
		if(!bool) {
			// 연락처 국번이 정규표현식에 위배된 경우
				
			$('table#tblUserRegister :input').prop('disabled', true);
			$(e.target).prop('disabled', false);
			$(e.target).val('').focus();
				
		//	$(e.target).next().show();
		//  또는
		    $(e.target).parent().find('span.error').show();
		}
		else {
			// 연락처 국번이 정규표현식에 맞는 경우
			$('table#tblUserRegister :input').prop('disabled', false);
				
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
				
			$('table#tblUserRegister :input').prop('disabled', true);
			$(e.target).prop('disabled', false);
			$(e.target).val('').focus();
				
		//	$(e.target).next().show();
		//  또는
		    $(e.target).parent().find('span.error').show();
		}
		else {
			// 연락처 마지막 4자리가 정규표현식에 맞는 경우
			$('table#tblUserRegister :input').prop('disabled', false);
				
	     // $(e.target).next().hide();
		 // 또는
			$(e.target).parent().find('span.error').hide();
		}
				
	});	// end of $('input#hp3').blur((e) => {})-------------------	
	
	
	
	$('input#postcode').blur((e) => { 
					
	 // const regExp_hp3 = /^[0-9]{4}$/;
	 // 또는
		const regExp_postcode = /^\d{5}$/;
		// 숫자 5자리만 들어오도록 정규표현식 객체 생성
		
		const bool = regExp_postcode.test($(e.target).val());
		
		if(!bool) {
			// 우편번호가 정규표현식에 위배된 경우
				
			$('table#tblUserRegister :input').prop('disabled', true);
			$(e.target).prop('disabled', false);
			$(e.target).val('').focus();
				
		//	$(e.target).next().show();
		//  또는
		    $(e.target).parent().find('span.error').show();
		}
		else {
			// 우편번호가 정규표현식에 맞는 경우
			$('table#tblUserRegister :input').prop('disabled', false);
				
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
	$('input#extraAddress').attr('readonly', true);
	
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
		            document.getElementById("extraAddress").value = extraAddr;
		        
		        } else {
		            document.getElementById("extraAddress").value = '';
		        }

		        // 우편번호와 주소 정보를 해당 필드에 넣는다.
		        document.getElementById('postcode').value = data.zonecode;
		        document.getElementById("address").value = addr;
		        // 커서를 상세주소 필드로 이동한다.
		        document.getElementById("detailAddress").focus();
		    }
		}).open();
				
	});// end of $('img#postcodeSearch').click(function(){})---------------

	
    $(function() {

	 /////////////////////////////////////////////////////////////
	 
	 // "아이디중복확인" 을 클릭했을 때 이벤트 처리하기 시작 // 
	 $('img#idCheck').click(function(){
		 b_idcheck_click = true;
		 // "아이디중복확인" 을 클릭했는지, 클릭을 안했는지 여부를 알아오기 위한 용도
		
		 // 입력하고자 하는 아이디가 데이터베이스 테이블에 존재하는지, 존재하지 않는지 알아와야 한다. 
         /*
      		Ajax (Asynchronous JavaScript and XML)란?                         
 		    ==> 이름만 보면 알 수 있듯이 '비동기 방식의 자바스크립트와 XML' 로서     
 		        Asynchronous JavaScript + XML 인 것이다.
 		        한마디로 말하면, Ajax 란? Client 와 Server 간에 XML 데이터를 JavaScript 를 사용하여 비동기 통신으로 주고 받는 기술이다.
 		        하지만 요즘에는 데이터 전송을 위한 데이터 포맷방법으로 XML 을 사용하기 보다는 JSON(Javascript Standard Object Notation) 을 더 많이 사용한다. 
 		        참고로 HTML은 데이터 표현을 위한 포맷방법이다.                             
 		        그리고, 비동기식이란 어떤 하나의 웹페이지에서 여러가지 서로 다른 다양한 일처리가 개별적으로 발생한다는 뜻으로서, 
 		        어떤 하나의 웹페이지에서 서버와 통신하는 그 일처리가 발생하는 동안 일처리가 마무리 되기전에 또 다른 작업을 할 수 있다는 의미이다.
      	*/

		 // === 첫번째 방법(jquery Ajax) === //
		 $.ajax({
			url:"idDuplicateCheck.up",
			data:{"id":$('input#id').val()},  // data 속성은 http://localhost:9090/MyMVC/user/idDuplicateCheck.up 로 전송해야할 데이터를 말한다.   
			type:"post", // type 을 생략하면 type:"get" 이다.
			async:true,  // async:true 가 비동기 방식을 말한다. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
			             // async:false 가 동기 방식이다. 지도를 할때는 반드시 동기방식인 async:false 을 사용해야만 지도가 올바르게 나온다.  
			success:function(text){
				console.log(text);
				// {"isExists":false}
				// {"isExists":true}
				// text 는 idDuplicateCheck.up 을 통해 가져온 결과물인 "{"isExists":true}" 또는 "{"isExists":false}" 로 되어지는 string 타입의 결과물이다. 
				
				console.log("~~~~ text 의 데이터타입 : ", typeof text);
				// ~~~~ text 의 데이터타입 :  string
				
				const json = JSON.parse(text);
				// JSON.parse(text); 은 JSON.parse("{"isExists":true}"); 또는 JSON.parse("{"isExists":false}"); 와 같은 것인데
				// 그 결과물은 {"isExists":true} 또는 {"isExists":false} 와 같은 문자열을 자바스크립트 객체로 변환해주는 것이다. 
				// 조심할 것은 text 는 반드시 JSON 형식으로 되어진 문자열이어야 한다.
				
				console.log("json => ", json);
				// json => {isExists: false}
				// json => {isExists: true}
				
				console.log("~~~~ json 의 데이터타입 : ", typeof json);
				// ~~~~ json 의 데이터타입 :  object
				
				if(json.isExists) {
					// 입력한 id 가 이미 사용중이라면 
					$('span#idcheckResult')
					.html($('input#id').val() + "은 이미 사용중 이므로 다른 아이디를 입력하세요")
					.css({"color":"red"});
					
					$('input#id').val("");                               
				}
				else {
					// 입력한 id 가 존재하지 않는 경우라면 
					$('span#idcheckResult')
					.html($('input#id').val() + "은 사용가능 합니다.")
					.css({"color":"navy"});
				}
			},
			
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		 });
		
	 });
	 // "아이디중복확인" 을 클릭했을 때 이벤트 처리하기 끝 //
	 
	 // 아이디값이 변경되면 가입하기 버튼 클릭시 "아이디중복확인" 을 클릭했는지 클릭안했는지 알아보기 위한 용도 초기화 시키기 
	 $('input#id').bind('change', function(){
		b_idcheck_click = false;
	 });
	 
	 
	 // "이메일중복확인" 을 클릭했을 때 이벤트 처리하기 시작 // 
	 $('span#emailcheck').click(function(){
		b_emailcheck_click = true;
		// "이메일중복확인" 을 클릭했는지, 클릭을 안했는지 여부를 알아오기 위한 용도
		
		// 입력하고자 하는 이메일이 데이터베이스 테이블에 존재하는지, 존재하지 않는지 알아와야 한다. 
        /*
      		Ajax (Asynchronous JavaScript and XML)란?                         
 		    ==> 이름만 보면 알 수 있듯이 '비동기 방식의 자바스크립트와 XML' 로서     
 		        Asynchronous JavaScript + XML 인 것이다.
 		        한마디로 말하면, Ajax 란? Client 와 Server 간에 XML 데이터를 JavaScript 를 사용하여 비동기 통신으로 주고 받는 기술이다.
 		        하지만 요즘에는 데이터 전송을 위한 데이터 포맷방법으로 XML 을 사용하기 보다는 JSON(Javascript Standard Object Notation) 을 더 많이 사용한다. 
 		        참고로 HTML은 데이터 표현을 위한 포맷방법이다.                             
 		        그리고, 비동기식이란 어떤 하나의 웹페이지에서 여러가지 서로 다른 다양한 일처리가 개별적으로 발생한다는 뜻으로서, 
 		        어떤 하나의 웹페이지에서 서버와 통신하는 그 일처리가 발생하는 동안 일처리가 마무리 되기전에 또 다른 작업을 할 수 있다는 의미이다.
      	*/
		
		// === 두번째 방법(jquery Ajax) === //
		$.ajax({
			url:"emailDuplicateCheck.up",
			data:{"email":$('input#email').val()},
			type:"post",
		//	async:true, 
			dataType:"json",  // Javascript Standard Object Notation.  dataType은 /MyMVC/user/emailDuplicateCheck.up 로 부터 실행되어진 결과물을 받아오는 데이터타입을 말한다. 
		                      // 만약에 dataType:"xml" 으로 해주면 /MyMVC/user/emailDuplicateCheck.up 로 부터 받아오는 결과물은 xml 형식이어야 한다. 
		                      // 만약에 dataType:"json" 으로 해주면 /MyMVC/user/emailDuplicateCheck.up 로 부터 받아오는 결과물은 json 형식이어야 한다.
			
			success:function(json){
				console.log(json);
				// {"isExists":false}
				// {"isExists":true}
				// json 은 emailDuplicateCheck.up 을 통해 가져온 결과물인 {"isExists":true} 또는 {"isExists":false} 로 되어지는 object 타입의 결과물이다. 
				
				console.log("~~~~ json 의 데이터타입 : ", typeof json);
				// ~~~~ json 의 데이터타입 :  object
				
				if(json.isExists) {
					// 입력한 email 이 이미 사용중이라면 
					$('span#emailCheckResult')
					.html($('input#email').val() + "은 이미 사용중 이므로 다른 이메일을 입력하세요")
					.css({"color":"red"});
										
					$('input#email').val("");
				}
				else {
					// 입력한 email 이 존재하지 않는 경우라면 
					$('span#emailCheckResult')
					.html($('input#email').val() + "은 사용가능 합니다.")
					.css({"color":"navy"});
				}
				
			},
			
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }				  
		});
			
	 });
	 // "이메일중복확인" 을 클릭했을 때 이벤트 처리하기 끝 //	 
	 
	
	 // 이메일값이 변경되면 가입하기 버튼 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지 알아보기 위한 용도 초기화 시키기 
 	 $('input#email').bind('change', function(){
		b_emailcheck_click = false;
 	 });
	 	
});// end of $(function(){})--------------------------------


// Function Declaration
// "가입하기" 버튼 클릭시 호출되는 함수
function goRegister() {
	
	// **** 필수입력사항에 모두 입력이 되었는지 검사하기 시작 **** //
	let b_requiredInfo = true;
	
	$('input.requiredInfo').each(function(index, elmt){
		const data = $(elmt).val().trim();
		if(data == "") {
			alert("*표시된 필수입력사항은 모두 입력하셔야 합니다.");
			b_requiredInfo = false;
			return false; // break; 라는 뜻이다.
		}
	});
	
	if(!b_requiredInfo) {
		return; // goRegister() 함수를 종료한다.
	}
	// **** 필수입력사항에 모두 입력이 되었는지 검사하기 끝 **** //
	
	
	// **** "아이디중복확인" 을 클릭했는지 검사하기 시작 **** //
	if(!b_idcheck_click) {
		// "아이디중복확인" 을 클릭 안 했을 경우
		
		alert("아이디 중복확인을 클릭하셔야 합니다.");
		return; // goRegister() 함수를 종료한다.
	}
	// **** "아이디중복확인" 을 클릭했는지 검사하기 끝 **** //
	
	
	// **** "이메일중복확인" 을 클릭했는지 검사하기 시작 **** //
	if(!b_emailcheck_click) {
		// "이메일중복확인" 을 클릭 안 했을 경우
		
		alert("이메일 중복확인을 클릭하셔야 합니다.");
		return; // goRegister() 함수를 종료한다.
	}	
    // **** "이메일중복확인" 을 클릭했는지 검사하기 끝 **** //
	
	
	// **** 우편번호 및 주소에 값을 입력했는지 검사하기 시작 **** //
	let b_addressInfo = true;
	
	const arr_addressInfo = [];
	arr_addressInfo.push($('input#postcode').val());
	arr_addressInfo.push($('input#address').val());
	arr_addressInfo.push($('input#detailAddress').val());
	arr_addressInfo.push($('input#extraAddress').val());
	
	for(let addressInfo of arr_addressInfo) {
		if(addressInfo.trim() == "") {
			alert("우편번호 및 주소를 입력하셔야 합니다.");
			b_addressInfo = false;
			break;
		}
	}// end of for---------------------
	
	if(!b_addressInfo) {
		return; // goRegister() 함수를 종료한다.
	}
	// **** 우편번호 및 주소에 값을 입력했는지 검사하기 시작 **** //
	
	
	
	const form = document.registerForm;
	form.method = "post";
 //	form.action = "userRegister.up";
    form.submit();
	
}// end of function goRegister()-----------------------------

</script>

<%-- css 주기 --%>
<head>
<style type="text/css">
@charset "UTF-8";

div#registerForm {
	text-align: center;
}

table#tblUserRegister {
 /*	border: solid 1px red; */ 
	width: 93%;
	margin: 1% auto;
}

table#tblUserRegister th {
    border: solid 1px gray; 
}

table#tblUserRegister th {
	height: 60px;
	background-color: silver;
	font-size: 14pt;
}

table#tblUserRegister td {
	line-height: 200%;
	padding: 1.2% 0;
	color: white;
}

span.star {
	color: red;
	font-weight: bold;
	font-size: 13pt;
}

table#tblUserRegister > tbody > tr > td:first-child {
	width: 20%;
	font-weight: bold;
	text-align: left;
}

table#tblUserRegister > tbody > tr > td:nth-child(2) {
	width: 80%;
	text-align: left;
}

img#postcodeSearch {
	border: solid 1px gray;
	border-radius: 5px;
	font-size: 8pt;
	display: inline-block;
	text-align: center;
	margin-left: 10px;
	cursor: pointer;
}

span#idCheck, #emailCheck {
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
</style>
</head>


<body>

<div class="container" id="registerDiv" style="background: #084b56 ; margin-top: 10%;">
	<form name="registerForm">
		<table id="tblUserRegister">
				<thead>
					<tr>
						<th colspan="2" style="text-align: center; color: #b1ab40; size: 20px; background: none; border: 0px; font-family: italic">
							Perfume Arena 에 오신 걸 환영합니다
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="3" style="line-height: 100%"></td>
					<tr>
					
					<tr>
						<td>성명&nbsp; <span class="star">*</span> </td>
						<td>
							<input type="text" id="name" maxlength="30" class="requiredInfo">
							<span class="error">필수 입력 사항입니다</span>
						</td>
					<tr>
					<tr>
						<td>아이디&nbsp; <span class="star">*</span> </td>
						<td>
					 		<input type="text" id="id" maxlength="30" class="requiredInfo">
							<%-- 아이디 중복체크 --%>
							<span id="idCheck">아이디중복확인</span>
	                        <span class="idCheckResult"></span>
							<span class="error">필수 입력 사항입니다</span>
					</td>
					<tr>
						<td>비밀번호&nbsp; <span class="star">*</span></td>
						<td>
							<input type="text" id="password" maxlength="30" class="requiredInfo">
							<span class="error">영문자,숫자,특수기호가 혼합된 8~15 비밀번호를 입력해주세요</span>
					</td>
					</tr>
						<td>비밀번호 확인&nbsp;  <span class="star">*</span></td>
						<td>
							<input type="text" id="passwordCheck" maxlength="30" class="requiredInfo">
							<span class="error">비밀번호가 일치하지 않습니다</span>
					</td>
					<tr>
						<td>이메일&nbsp; <span class="star">*</span></td>
						<td>
							<input type="text" id="email" maxlength="30" class="requiredInfo">
							<span class="error">이메일 형식에 맞지 않습니다</span>
							<%-- 이메일 중복체크 --%>
                       		<span id="emailCheck">이메일중복확인</span>
                   			<span id="emailCheckResult"></span>
					</td>
					</tr>
						<td>연락처&nbsp; <span class="star">*</span></td>
						<td>
					 	   <input type="text" name="mobileHead" id="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp; 
	                       <input type="text" name="mobileMiddle" id="hp2" size="6" maxlength="4" />&nbsp;-&nbsp;
	                       <input type="text" name="mobileLast" id="hp3" size="6" maxlength="4" />    
	                       <span class="error">휴대폰 형식이 아닙니다.</span>
					</td>
					<tr>
	                    <td>우편번호</td>
	                    <td>
	                       <input type="text" name="postcode" id="postcode" size="6" maxlength="5" />&nbsp;&nbsp;
	                       <%-- 우편번호 찾기 --%>
	                       <img src="<%= ctxPath%>/images/find_postcode.gif" width="6%" id="postcodeSearch" />
	                       <span class="error">우편번호 형식에 맞지 않습니다.</span>
                	    </td>
               		</tr>
					<tr>
						<td>주소&nbsp;</td>
						<td>
	                       <input type="text" name="address" id="address" size="40" maxlength="200" placeholder="주소" /><br>
                   		   <input type="text" name="detailAddress" id="detailAddress" size="40" maxlength="200" placeholder="상세주소" />
                   		   	&nbsp;
                   		   <input type="text" name="extraAddress" id="extraAddress" size="40" maxlength="200" placeholder="참고항목" />            
                     		<span class="error">주소를 입력하세요.</span>
                		</td>
					</tr>
					<tr>
	                    <td colspan="2" class="text-center">
	                       <input type="button" class="btn btn-success btn-lg mr-5" value="가입하기" onclick="goRegister()" />
	                       <input type="reset"  class="btn btn-danger btn-lg" value="취소하기" onclick="goReset()" />
	                    </td>
              		</tr>
					
				</tbody>
		
		</table>
	</form>


</div>
	
	


</body>
</html>



