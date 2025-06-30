<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../../headerTest.jsp" /> 

<style>
	
	table#userTbl {
      	width: 100%;
      	margin: 30px auto;
   	}
   	
   	table#userTbl th {
      	text-align: center;
      	font-size: 14pt;
   	}
   	#userListBox {height:100vh;padding:8% 8%;}
   	
   	ul.pagination {justify-content:center;}
   	
</style>   	

<script type="text/javascript">

  $(function(){
	  <%-- ${} 중괄호 생각--%>
	  $('select[name="sizePerPage"]').val("${requestScope.sizePerPage}");
	  
	  if( "${requestScope.searchType}" != "" && 
		  "${requestScope.searchWord}" != "" ){
		  $('select[name="searchType"]').val("${requestScope.searchType}");
		  $('input:text[name="searchWord"]').val("${requestScope.searchWord}");
	  }
	  
	  $('select[name="sizePerPage"]').bind('change',function(){
		  
		  const frm = document.member_search_frm;
		  frm.action = "userList.do"; 
		  // form 태그에 action 이 명기되지 않았으면 현재보이는 URL 경로로 submit 되어진다.
		  frm.method = "get";
		  // // form 태그에 method 를 명기하지 않으면 "get" 방식이다.
		  frm.submit();
	  });
	  
	  // **** select 태그에 대한 이벤트 처리는 클릭이 아닌 change이다. ****//
	  
	  $('input:text[name="searchWord"]').bind('keyup',function(e){
		  if(e.keycode == 13){
			  goSearch();
		  }
	  })
	  
	  // **** 특정 회원을 클릭하면, 그 회원의 상세정보를 보여주도록 해야한다. ****//
	  
	  $('table#userTbl tr.userInfo').click(function(e){
		//  alert($(e.target).parent().html());
		
		const id = $(e.target).parent().find("td.id").text();
		// alert(userid);

		
		const frm = document.userOneDetail_frm;
		frm.id.value = id;
		
		frm.action = "${pageContext.request.contextPath}/user/userOneDetail.do";
		frm.method = "POST";
		frm.submit();
		
	  }); // end of $('table#memberTbl tr.memberInfo').click(function(e){} 
	
  }); // end of $(function(){} 
  
  function goSearch(){
	  
	  const searchType = $('select[name="searchType"]').val();
	  
	  if(searchType == ""){
		  alert('검색대상을 선택하세요.');
		  return; // 함수종료
	  }
	  
	  const frm = document.user_search_frm;
	  <%--자기 자신한테 감
	  // form 태그에 action 이 명기되지 않았으면 현재보이는 URL 경로로 submit 되어진다.--%>
	  frm.action = "userList.do" 
	  frm.method = "GET"
	  <%--form태그에 명기하지 않으면 GET방식이다.--%>
	  frm.submit();
	  
  }// end of function goSearch(){} 
 
  
</script>

	<div class="container" id="userListBox">
	
		<form name="user_search_frm">
			<select name="searchType">
	         	<option value="">검색대상</option>
	         	<option value="name">회원명</option>
	         	<option value="id">아이디</option>
	         	<option value="email">이메일</option>
	      	</select>
      		&nbsp;
      		<input type="text" name="searchWord" />
      	
		  	<input type="text" style="display: none;" /> <%-- 조심할 것은 type="hidden" 이 아니다. --%> 
	      
	      	<button type="button" class="btn btn-secondary" onclick="goSearch()">검색</button>
	      
	      	<span style="font-size: 12pt; font-weight: bold;">페이지당 회원명수&nbsp;-&nbsp;</span>
	   		<select name="sizePerPage">
	      		<option value="10">10명</option>
	      		<option value="5">5명</option>
	      		<option value="3">3명</option>      
	   		</select>
		</form>
		
		<table class="table table-bordered" id="userTbl">
			<thead>
				<tr>
					<th>번호</th>
					<th>아이디</th>
					<th>이름</th>
					<th>이메일</th>
					<th>회원등급</th>
				</tr>
			</thead>
			
			<tbody>
				<c:if test="${not empty requestScope.userList}">
	      			<c:forEach var="uservo" items="${requestScope.userList}" varStatus="status">
	      				<tr class="userInfo">
	      					<fmt:parseNumber var="currentShowPageNo" value="${requestScope.currentShowPageNo}" />
	      					<fmt:parseNumber var="sizePerPage" value="${requestScope.sizePerPage}" />
	      				
	      					<td>${(requestScope.totalUserCount) - (currentShowPageNo - 1) * sizePerPage - (status.index)}</td>	      						
	      					<td class="id">${uservo.id}</td>
	      					<td>${uservo.name}</td>
	      					<td>${uservo.email}</td>
	      					<td>${uservo.grade}</td>
	      				</tr>
	      			</c:forEach>
      			</c:if>
      			
      			<c:if test="${empty requestScope.userList}">
	      			<tr>
	      				<td colspan="5">데이터가 존재하지 않습니다.</td>
	      			</tr>
	      		</c:if>
			</tbody>
			
		</table>
		
		<div id="pageBar">
			<nav>
			  	<ul class="pagination">${requestScope.pageBar}</ul>
			</nav>
		</div>   
		
	</div>
	
	<form name="userOneDetail_frm">
		<input type="hidden" name="id" />
	</form>
	

<jsp:include page="../../footer.jsp" /> 