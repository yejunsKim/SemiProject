<% 
  String ctxPath = request.getContextPath(); 
%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/css/find/idFind.css" />

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<script type="text/javascript" >
  $(function(){
	  
	  $('span.error').hide();
	 
	 
  });
  
  function goIdFind(){
	
	  const name = $('input:text[id="idName"]').val().trim();
	  console.log(name);
	  
	  $('input#hp2').blur((e)=>{
			
			// 연락처 국번( 숫자 4자리인데 첫번째 숫자는 1-9 이고 나머지는 0-9) 정규표현식 객체 생성
			const regExp_hp2 = /^[1-9][0-9]{3}$/;
							
			const bool = regExp_hp2.test($(e.target).val());
					
			if(!bool){ // 연락처 국번이 정규표현식에 위배된 경우
													
			 	// 해당 테이블내에 있는 '모든 input' 태그를 가져오는 것.
				// prop 는 disabled로 허용여부 하는것.
				$('table#tblMemberRegister :input').prop('disabled', true);
				$(e.target).prop('disabled', false);
				$(e.target).val("").focus();
											
				// 이벤트가 발생되어진 태그의 그 다음에 나오는태그. 형제 없으면 자식
				// $(e.target).next().show();
				// 또는
				$(e.target).parent().find('span.error').show();
			}
									
			else { // 연락처 국번이 정규표현식에 맞은 경우
							
				$('table#tblMemberRegister :input').prop('disabled', false);
				$(e.target).parent().find('span.error').hide();			
			}
						
		});// end of $('input#hp2').blur((e)=>{
			
		$('input#hp3').blur((e)=>{
												
			// 연락처 마지막 4자리 (숫자 4자리인데 숫자만 되어야 함) 정규표현식 객체 생성
			const regExp_hp3 = /^[0-9]{4}$/;
			// 또는
			// const regExp_hp3 = /^\D{4}$/;// 소문자 D 가 아닌 대문자 D
									
			const bool = regExp_hp3.test($(e.target).val());
									
			if(!bool){ // 연락처 마지막 4자리가 정규표현식에 위배된 경우
																
			 // 해당 테이블내에 있는 '모든 input' 태그를 가져오는 것.
			 // prop 는 disabled로 허용여부 하는것.
				$('table#useridFind:input').prop('disabled', true);
				$(e.target).prop('disabled', false);
				$(e.target).val("").focus();
														
				// 이벤트가 발생되어진 태그의 그 다음에 나오는태그. 형제 없으면 자식
				// $(e.target).next().show();
				//또는
				$(e.target).parent().find('span.error').show();
			}		
								
			else { // 연락처 마지막 4자리가 정규표현식에 맞은 경우				
				$('table#useridFind:input').prop('disabled', false);
				$(e.target).parent().find('span.error').hide();			
			}	
										
		});// end of $('input#hp3').blur((e)=>{
			
				
		const mobile = $('input:text[id="hp1"]').val() + $('input:text[id="hp2"]').val() + $('input:text[id="hp3"]').val();
	
		console.log(mobile);

		<%--
		$.ajax({
			url:"${pageContext.request.contextPath}/common/controller/idFind.do",
			type:"get",
			data: name="name"
			dataType:"json",
			success:function(json){
				alert('성공');
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error); 
			}

		}); // end of ajax		
		--%>
		 
		const frm = document.idFindForm;
		//method = frm.method("get");
		<%--//frm.action = "<%= ctxPath%>/WEB-INF/idfind.up";--%>
		frm.submit();
  }

  
</script>


	<div style="width:75%;height:100%;background-color:#ddd;">
	
	<div class="container" id="registerDiv" style="background: #084b56 ; margin-top: 10%;">
	<form name="idFindForm">
		<table id="useridFind">
				<thead>
					<tr>
						<th style= "text-align: center; color: #b1ab40; size: 20px; background: none; border: 0px; font-family: italic">
							ID 찾기
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="line-height: 100%"></td>
					<tr>
					<tr>
						<td>성명&nbsp; <span class="star">*</span> </td>
						<td>
							<input type="text" id="idName" maxlength="30" class="requiredInfo">
							<span class="error">필수 입력 사항입니다</span>
						</td>
					</tr>
					<tr>
						<td>연락처&nbsp; <span class="star">*</span></td>
						<td>
					 	   <input type="text" name="mobileHead" id="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp; 
	                       <input type="text" name="mobileMiddle" id="hp2" size="6" maxlength="4" />&nbsp;-&nbsp;
	                       <input type="text" name="mobileLast" id="hp3" size="6" maxlength="4" />    
	                       <span class="error">휴대폰 형식이 아닙니다.</span>
						</td>
					<tr>
					</tr>
					<tr>
	                    <td class="text-center btn-submits">
	                       <input type="button" class="btn btn-success btn-lg mr-5" value="아이디찾기" onclick="goIdFind()" />
	                       <input type="reset"  class="btn btn-danger btn-lg" value="취소하기" onclick="goReset()" />
	                    </td>
              		</tr>
              		
				</tbody>
		</table>
	</form>

</div>

</div>

</div>
	
<jsp:include page="footer.jsp" />