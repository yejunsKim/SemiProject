
let lenHIT = 8;

$(function(){
	
	let start = 1;
	
	displayHIT(start);
	
	// === 스크롤 이벤트 발생시키기 시작 === //
	$(window).scroll(function(){
		
		// 스크롤탑의 위치값
	//	console.log("$(window).scrollTop() => ", $(window).scrollTop());
		
		// 보여주어야할 문서의 높이값(ㄷ보기를 해주므로 append 되어져서 높이가 계속 증가 될 것이다)
	//	console.log("$(window).scrollTop() => ", $(document).scrollTop());
		
		// 웹브라우저의 높이값(디바이스마다 다르게 표현되는 고정값)
	//	console.log("$(document).height() => ", $(document).height());
		
	//	console.log("$(window).height() =>", $(window).height())
		
		// 아래는 스크롤되어진 스크롤탑의 위치값이 웹브라우저창의 높이만큼 내려갔을 경우를 알아보는 것이다.
	//	console.log( "$(window).scrollTop() => ", $(window).scrollTop() );
	//	console.log( "$(document).height() - $(window).height() => ", ( $(document).height() - $(window).height() ) );
		
		// 아래는 만약에 위의 값이 제대로 안나오는 경우 이벤트가 발생되는 숫자를 만들기 위해서 스크롤탑의 위치값에 +1 을 더해서 보정해준 것이다. 
	//	console.log( "$(window).scrollTop() + 1  => " + ( $(window).scrollTop() + 1  ) );
	//	console.log( "$(document).height() - $(window).height() => " + ( $(document).height() - $(window).height() ) ); 
		
	//	if( $(window).scrollTop() == $(document).height() - $(window).height() ) {
		// 만약에 위의 값대로 잘 안되면 아래의 것을 하도록 한다. 
		if( $(window).scrollTop() + 1 >= $(document).height() - $(window).height() ) { 
			
			if($('span#totalCount').text() != $('span#countHIT').text()) {
				start += lenHIT;
			//	alert(start);
				
				displayHIT(start);	// displayHit(9);
			}
		}
		
		if($(window).scrollTop() == 0) {
			// 다시 처음부터 시작하도록 한다.
			
			$('div#displayHIT').empty();
			$('span#end').empty();
			$('span#countHIT').text("0");
			
			start =1;
			displayHIT(start);
		}
		
	});
	// === 스크롤 이벤트 발생시키기 끝 === //
	
});// end of $(function(){})--------------------


// Function Declaration
function displayHIT(start){	// start가  1 이라면   1~ 8  까지 상품 8개를 보여준다.
							// start가  9 이라면   9~ 16  까지 상품 8개를 보여준다.
							// start가 17 이라면  17~ 24  까지 상품 8개를 보여준다.
							// start가 25 이라면  25~ 32  까지 상품 8개를 보여준다.
							// start가 33 이라면  33~ 36  까지 상품 4개를 보여준다.(마지막 상품)
	
	$.ajax({
		url:"perfumeDisplayJSON.do",
	//	type:"get"
		data:{"categoryName":categoryName,
			  "start":start,	// 1
			  "len":lenHIT},	// 8
		dataType:"json",
		success:function(json){
			
			let v_html =``;
			
			if(start == 1 && json.length == 0) {
				// 처음부터 데이터가 존재하지 않는 경우
				
				v_html = `현재 상품 준비중 입니다...`;
				$('div#displayHIT').html(v_html);
			}
			
			else if(json.length > 0) {
				// 데이터가 존재하는 경우
				
				$.each(json, function(_, item){
					
					//console.log(item.itemphotopath);
					//  /images/item/LAVANDE31_500.png
					
					v_html += `<div class='col-md-6 col-lg-3'>
									<div class="card mb-3">
										<a href="/SemiProject/item/itemDetail.do?itemno=${item.itemno}" class="itemDetail">
											<img src="/SemiProject${item.itemphotopath}" class="card-img-top" style="height: 350px; object-fit: cover;">
										</a>
										<div class="card-body">
										
											<h5 class="card-title">
												<a href="/SemiProject/item/itemDetail.do?itemno=${item.itemno}" class="itemDetail">

													<span style="display:none;">${item.itemno}</span><br>

													${item.itemname}<br>
												</a>
											</h5>
										</div>
										<ul class="list-group list-group-flush">
											<li class="list-group-item">${item.volume}ml</li>	
											<li class="list-group-item">${item.price.toLocaleString('en')}원</li>	
											<li style="height: 40.8px; display: flex; align-items: center;">
												<form id="cartPush" method="post" action="/SemiProject/item/cartAdd.do">
													<input type="hidden" name="itemNo" value="${item.itemno}">
													<input type="hidden" name="quantity" value="1">
													<button type="submit" class="btn btn-link btn-sm cart-btn" style="color: black; margin-left: 10px;">장바구니 담기</button>
												</form>
											<li>
										</ul>
									</div>
								</div>`;
				});// end of $.each(json, function(index, item){})-------------------------
				
				// HIT 상품 결과를 출력하기
				$('div#displayHIT').append(v_html);
				
				// span#countHIT 에 지금까지 출력된 상품의 개수를 누적해서 기록한다.
				$('span#countHIT').text( Number($('span#countHIT').text()) + json.length );
				
				// 스크롤을 계속하여 countHIT 값과 totalCount 값이 일치하는 경우
				if($("span#countHIT").text() == $("span#totalCount").text()) {
					$('span#end').html("더이상 조회할 제품이 없습니다.");
				}
			}// end of else if(json.length > 0)---------------------
			
		},
		error: function(request, _, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
	});
	
}// end of function displayHIT(start)-------------------


function goTop(){
	$(window).scrollTop(0);
}// end of function goTop()-----------------------------


