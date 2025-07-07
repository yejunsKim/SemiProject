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


// ==== 포트원(구 아임포트) 결제를 해주는 함수 ==== //
function requestPayment(ctxPath, totalAmount, id, usePoint) {
	
	const url = `${ctxPath}/item/itemPayment.do?id=${id}&totalAmount=${totalAmount}&usePoint=${usePoint}`;
	console.log(url);
	// 너비 1000, 높이 600 인 팝업창을 화면 가운데 위치시키기
	const width = 1000;
	const height = 600;
	
	const left = Math.ceil((window.screen.width - width) / 2);	// 정수로 만듬
							// 1400 - 1000 = 400		400/2 ==> 200
	
	const top = Math.ceil((window.screen.height - height) / 2);	// 정수로 만듬
							// 1400 - 600 = 800		800/2 ==> 400
	
	window.open(url, "payment", `left=${left}, top=${top}, width=${width}, height=${height}`);
	
}// end of function goCoinPurchaseTypeChoice(userid, ctx_Path) {}--------------------

