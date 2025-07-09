<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../../header.jsp" /> 

<style>
   .gradient-bg {
   			 background: linear-gradient(135deg, #6b73ff 20%, #444eff 100%);        }
    .card-shadow {
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }
    .animate-pulse {
        animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
    }
    @keyframes pulse {
        0%, 100% {
            opacity: 1;
        }
        50% {
            opacity: 0.5;
        }
    }
    textarea {
        resize: none;
    }
   .user-row:hover {
        background-color: #f8f9fa !important;
        cursor: pointer;
        transform: translateY(-1px);
        transition: all 0.2s ease;
    }

    .search-input:focus {
        border-color: #6b73ff !important;
        box-shadow: 0 0 0 0.2rem rgba(107, 115, 255, 0.25) !important;
    }

    @media (max-width: 992px) {
        form[name="user_search_frm"] {
            flex-direction: column !important;
            align-items: stretch !important;
        }

        form[name="user_search_frm"] > * {
            width: 100% !important;
            margin-bottom: 0.75rem;
        }

        .table th,
        .table td {
            font-size: 0.875rem;
        }

        .pagination {
            flex-wrap: wrap !important;
            justify-content: center !important;
        }
    }

    @media (max-width: 576px) {
        .table th,
        .table td {
            font-size: 0.75rem;
            padding: 0.5rem;
        }
    }
    
    .pagination .page-item.active .page-link {
       background-color: #5f5fff;
       border-color: #5f5fff;
   }
      
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

      
      const frm = document.userDetail_frm;
      frm.id.value = id;
      
      frm.action = "${pageContext.request.contextPath}/user/admin/userDetail.do";
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
   
   <!-- 사용자 검색 및 목록 박스 -->
   <div class="container mt-4 mb-5 p-5" id="userListBox">
	
    <!-- 🔍 검색 영역 -->
    <div class="bg-white rounded-xl shadow-sm p-4 mb-4">
        <form name="user_search_frm" class="form-inline d-flex flex-wrap align-items-center gap-2">
            <select name="searchType" class="form-control mr-2" style="max-width: initial;">
                <option value="name">회원명</option>
                <option value="id">아이디</option>
                <option value="email">이메일</option>
                <option value="grade">회원등급</option>
            </select>

            <input type="text" name="searchWord" placeholder="검색어를 입력하세요" class="form-control mr-2 search-input" style="max-width: initial;">
            <input type="text" style="display: none;">

            <button type="button" onclick="goSearch()" class="btn mr-auto" style="background-color: #5f5fff; color: white;">
                <i class="fas fa-search mr-1"></i> 검색
            </button>

            <div class="d-flex align-items-center ml-auto">
                <span class="mr-2 font-weight-bold">페이지당 회원수:</span>
                <select name="sizePerPage" class="form-control">
                    <option value="10">10명</option>
                    <option value="5">5명</option>
                    <option value="3">3명</option>
                </select>
            </div>
        </form>
    </div>

    <!-- 👥 사용자 테이블 -->
    <div class="bg-white rounded-xl shadow-sm mb-4">
        <div class="table-responsive">
            <table class="table table-hover table-bordered text-center" id="userTbl">
                <thead class="thead-light">
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
                            <tr class="user-row userInfo">
                                <fmt:parseNumber var="currentShowPageNo" value="${requestScope.currentShowPageNo}" />
                                <fmt:parseNumber var="sizePerPage" value="${requestScope.sizePerPage}" />
                                <td>${(requestScope.totalUserCount) - (currentShowPageNo - 1) * sizePerPage - (status.index)}</td>
                                <td class="id">${uservo.id}</td>
                                <td>${uservo.name}</td>
                                <td>${uservo.email}</td>
                                <td>
                            <c:choose>
                               <c:when test="${uservo.grade == 'vip'}">
                                    <span class="badge badge-pill" style="background: linear-gradient(45deg, #ff00ff, #00ffff); color: white;">Vip</span>
                                </c:when>
                                <c:when test="${uservo.grade == 'bronze'}">
                                    <span class="badge badge-pill" style="background-color: #cd7f32; color: white;">Bronze</span>
                                </c:when>
                                <c:when test="${uservo.grade == 'gold'}">
                                    <span class="badge badge-pill" style="background-color: #ffd700; color: black;">Gold</span>
                                </c:when>
                                <c:when test="${uservo.grade == 'silver'}">
                                    <span class="badge badge-pill" style="background-color: #c0c0c0; color: white;">Silver</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-pill" style="background-color: #5f5fff; color: white;">${uservo.grade}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty requestScope.userList}">
                        <tr>
                            <td colspan="5" class="text-center text-muted">데이터가 존재하지 않습니다.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 📄 페이지네이션 -->
    <div class="bg-white rounded shadow-sm p-3" >
        <div class="d-flex justify-content-center align-items-center flex-wrap">
            <%-- <div class="text-muted small mb-2 mb-sm-0">
                총 <strong>${requestScope.totalUserCount}</strong> 명의 회원
            </div> --%>
            <ul class="pagination justify-content-center justify-content-sm-end mb-0">
                ${requestScope.pageBar}
            </ul>
        </div>
    </div>
</div>

<!-- 숨겨진 form -->
<form name="userDetail_frm">
    <input type="hidden" name="id" />
</form>

   

<jsp:include page="../../footer.jsp" /> 