$(function() {
	// 로그인 버튼 클릭 시
	$('button#btnSubmit').click(() => {
		loginLocalStorage();
	});

	// 엔터 입력 시
	$('input#loginPwd').bind("keyup", (e) => {
		if(e.keyCode === 13) {
			loginLocalStorage();
		}
	});
});


function loginLocalStorage() {
	if($('input#loginid').val().trim() == "") {
		// id 를 입력하지 않았다면,
		alert("아이디를 입력하세요");
		$('input#loginid').focus();
		return;
	}
	if($('input#loginPwd').val().trim() == "") {
		// password 를 입력하지 않았다면,
		alert("암호를 입력하세요");
		$('input#loginPwd').focus();
		return;
	}
	
	if($('input#saveid').prop('checked')) {
		// 아이디 저장을 체크했다면,
		localStorage.setItem('saveid', $('input:text[name="id"]').val());
	} 	// 로컬스토리지에 해당 값을 남기겠다는 것.
	else localStorage.removeItem('saveid'); // 해제 시 삭제.
	
	const form = document.loginForm;
	form.method = "post";
	// post로 폼을 전송할 것.
	form.submit();
	
}


function LogOut(ctx_Path) { // 로그아웃 페이지로 이동~
	location.href = `${ctx_Path}/login/logout.do`;
}

// 나의정보 수정하기 팝업창 띄우는 메소드
function editInfo(id, ctxPath) {


	   const url = `${ctxPath}/user/userEdit.do?id=${id}`;
	   
	   // 너비 800, 높이 680 인 팝업창을 화면 가운데 위치시키기
	   const width = 800;
	   const height = 680;
	   
	   const left = Math.ceil((window.screen.width - width)/2);  // 정수로 만듬 
	   const top = Math.ceil((window.screen.height - height)/2); // 정수로 만듬
	   window.open(url, "editInfo", 
	               `left=${left}, top=${top}, 
				    width=${width}, height=${height}`);
	
}



///////////////////////////////////////////////////////////////////////////////////////////

// 김윤호 수정사항 0702 - 결제하기 관련

// ==== 포트원(구 아임포트) 결제를 해주는 함수 ==== //
function goCoinPurchaseEnd(ctx_Path, 최종결제금액, userid) {
	
//	alert(`확인용 부모창의 함수 호출함.\n결제금액:${coinmoney}원, 사용자id : ${userid}`);
	
	// 포트원(구 아임포트) 결제 팝업창 띄우기
	const url = `${ctx_Path}/item/itemPayment.do?userid=${userid}&coinmoney=${최종결제금액}`;
	
	// 너비 1000, 높이 600 인 팝업창을 화면 가운데 위치시키기
	const width = 1000;
	const height = 600;
	
	const left = Math.ceil((window.screen.width - width) / 2);	// 정수로 만듬
							// 1400 - 1000 = 400		400/2 ==> 200
	
	const top = Math.ceil((window.screen.height - height) / 2);	// 정수로 만듬
							// 1400 - 600 = 800		800/2 ==> 400
	
	window.open(url, "CoinPurchaseTypeEnd", `left=${left}, top=${top}, width=${width}, height=${height}`);
	
}// end of function goCoinPurchaseTypeChoice(userid, ctx_Path) {}--------------------



// ==== DB 상의 tbl_member 테이블에 해당 사용자의 코인금액 및 포인트를 증가(update)시켜주는 함수 === //
function goCoinUpdate(ctxPath, userid, 최종결제금액) {
	
//	console.log(`~~ 확인용 userid : ${userid}, coinmoney : ${coinmoney}`);
	
	$.ajax({
		url:`${ctxPath}/item/pointUpdateLogin.do`,
		data:{"userid":userid,
			  "최종결제금액":최종결제금액},
		type:"post",
		async:true,
		dataType:"json",
		success:function(json){
			console.log("~~~ 확인용 json => ", json);
			// {message: '김윤호님의 최종결제금액 원 결제가 완료되었습니다.', loc: '/MyMVC/index.up'}
			
			alert(json.message);
			location.href = json.loc;
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
	});
	
}// end of function goCoinUpdate(ctxPath, userid, coinmoney)------------------



