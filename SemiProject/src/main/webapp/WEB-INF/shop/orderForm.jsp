<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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

</style>

<script type="text/javascript">

	
	
</script>

	<div class="col-md-12" id="divOrder" style="background-color: #f5f5f5;padding-top:80px;">
      	<form name="orderFrm" action="post">
      	
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
		                       	<input type="hidden" name="userid" value="${sessionScope.loginuser.userid}" />
		                       	<input type="text" name="name" id="name" class="requiredInfo" value="${sessionScope.loginuser.name}" />
		                    	<span class="error">성명은 필수입력 사항입니다.</span>
	                    	</td>
	                	</tr>
	                
	                	<tr>
	                    	<td>우편번호&nbsp;<span class="star">*</span></td>
		                    <td>
		                       <input type="text" name="postcode" id="postcode" size="6" maxlength="5" value="${sessionScope.loginuser.postcode}" />&nbsp;&nbsp;
		                       <%-- 우편번호 찾기 --%>
		                       <img src="<%= ctxPath%>/images/find_postcode.gif" id="zipcodeSearch" style="width:40px" />
		                       <span class="error">우편번호 형식에 맞지 않습니다.</span>
		                    </td>
		                </tr>
		                
		                <tr>
		                    <td>주소&nbsp;<span class="star">*</span></td>
		                    <td>
		                       <input type="text" name="address" id="address" size="40" maxlength="200" placeholder="주소" value="${sessionScope.loginuser.address}" /><br>
		                       <input type="text" name="detailaddress" id="detailAddress" size="40" maxlength="200" placeholder="상세주소" value="${sessionScope.loginuser.detailaddress}" />&nbsp;<input type="text" name="extraaddress" id="extraAddress" size="40" maxlength="200" placeholder="참고항목" value="${sessionScope.loginuser.extraaddress}" />            
		                       <span class="error">주소를 입력하세요.</span>
		                    </td>
		                </tr>
	               
		                <tr>
		                    <td>연락처&nbsp;<span class="star">*</span></td>
		                    <td>
		                       <input type="text" name="hp1" id="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp; 
		                       <input type="text" name="hp2" id="hp2" size="6" maxlength="4" value="${fn:substring(sessionScope.loginuser.mobile, 3, 7)}" />&nbsp;-&nbsp; 
		                       <input type="text" name="hp3" id="hp3" size="6" maxlength="4" value="${fn:substring(sessionScope.loginuser.mobile, 7, 11)}" />    
		                       <span class="error">휴대폰 형식이 아닙니다.</span>
		                    </td>
		                </tr>
		                
		                <tr style="border-bottom: 1px solid">
		                    <td>이메일&nbsp;<span class="star">*</span></td>
		                    <td>
		                       <input type="text" name="email" id="email" maxlength="60" class="requiredInfo" value="${sessionScope.loginuser.email}" /> 
		                       <span class="error">이메일 형식에 맞지 않습니다.</span>
		                       <%-- 이메일중복체크 --%>
		                       <span id="emailcheck">이메일중복체크</span>
		                       <span id="emailCheckResult"></span>
		                    </td>
		                </tr>
	                </tbody>	                
           		</table>
	    	</div>
	    	
	    	<!-- 주문상품 -->
			<div class="section">
				<table id="tblOrder">
					<tr class="h5">
                   		<td>배송지</td>
                	</tr>
					<tr style="border-bottom: 1px solid">
						<td style="width: 100px;">
							<img src="images/sample.jpg" alt="테스트 상품" style="width:100px;" />
						</td>
						<td>
							<strong>테스트 상품 (예시)</strong><br/>
							상품 설명이 여기에 들어갑니다.
						</td>
					</tr>
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
						<td style="text-align: right;">57,375원</td>
					</tr>
					<tr>
						<td>배송비</td>
						<td style="text-align: right;">0원</td>
					</tr>
					<tr style="border-bottom: 1px solid">
						<td><strong>최종 결제 금액</strong></td>
						<td style="text-align: right;"><strong>57,375원</strong></td>
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
                		<td><button>카드결제</button></td>
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
				</table>
				
			</div>
		
   		</form>
   		
	</div>

<jsp:include page="../footer.jsp" />