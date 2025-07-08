<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<jsp:include page="../header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/css/find/idFind.css" />


<script type="text/javascript">
$(function() {
    const method = "${requestScope.method}";

    if(method == "GET") {
        $('div#div_findResult').prop('hidden', true);
    } else {
        $('div#div_findResult').prop('hidden', false);
        $('input:text[name="name"]').val("${requestScope.name}");
        $('input:text[name="email"]').val("${requestScope.email}");
    }

    $('button.btn-success').click(function(){
        goFind();
    });

    $('input:text[name="email"]').bind('keyup',function(e){
        if(e.keyCode == 13){
            goFind();
        }
    });
});

function goFind() {
    const name = $('input:text[name="name"]').val().trim();
    if (name == "") {
        alert('성명을 입력하십시오.');
        return;
    }

    const email = $('input:text[name="email"]').val();
    const regExp_email = /^[0-9a-zA-Z]([\-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([\-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

    if (!regExp_email.test(email)) {
        alert('이메일을 올바르게 입력하십시오.');
        return;
    }

    const frm = document.idFindFrm;
    frm.action = "<%= ctxPath %>/login/idFind.do";
    frm.method = "POST";
    frm.submit();
}

function form_reset_empty(){
    document.querySelector('form[name="idFindFrm"]').reset();
    $('div#div_findResult').empty();
}
</script>

<div class="pwFindWrap" id="pwFindWrap">
  <form name="idFindFrm" id="pwFindFrm">
    <p class="pwContain">아이디 찾기</p>

    <div class="pwBox">
      <p>성명</p>
      <input type="text" name="name" id="name" />
    </div>

    <div class="pwBox">
      <p>이메일</p>
      <input type="text" name="email" id="email" />
    </div>

    <div class="submitBtn">
      <button type="button" class="btn btn-success">찾기</button>
    </div>

    <div id="div_findResult">
      <c:if test="${not empty requestScope.id}">
        <p style="text-align: center;">아이디는 <strong style="color:#000; font-size: 16pt; ">${requestScope.id}</strong> 입니다.</p>
      </c:if>
      <c:if test="${requestScope.n == 0}">
        <p>입력하신 정보와 일치하는 아이디가 없습니다.</p>
      </c:if>
    </div>
  </form>
</div>

<jsp:include page="../footer.jsp" />
