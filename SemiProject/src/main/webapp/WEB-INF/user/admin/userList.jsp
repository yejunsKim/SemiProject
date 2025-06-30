<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style type="text/css">
	
	table#userTbl {
      	width: 80%;
      	margin: 0 auto;
   	}
   	
   	table#userTbl th {
      	text-align: center;
      	font-size: 14pt;
   	}
   	
</style>   	

<%-- <jsp:include page="../../header2.jsp" /> --%>

	<div class="container" style="padding: 3% 0;">
	
		<form name="member_search_frm">
			<select name="searchType">
	         	<option value="">검색대상</option>
	         	<option value="name">회원명</option>
	         	<option value="userid">아이디</option>
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
				<c:if test="${not empty requestScope.memberList}">
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
	
	<form name="memberOneDetail_frm">
		<input type="hidden" name="userid" />
	</form>
	

<%-- <jsp:include page="../../footer2.jsp" /> --%>