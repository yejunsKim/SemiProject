<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
  String ctxPath = request.getContextPath();
%>
<style>
.footerBox {margin:0 0 15px;}
.footerTopnav {font-size:14pt;color:#fff !important;}
.footerTopnav:after {content:"";width:2px;height:20px;display:inline-block;background-color:#fff;vertical-align:-3px;margin:0 15px;}
.footerTopnav:last-child:after{content:initial;display:initial;}
.footLogo {max-width:150px;}

@media screen and (max-width:500px){
   .footerTopnav {font-size:10pt;}
   .footLogo {max-width:110px;}
   .footerTopnav:after {width:1px;height:15px;}
}
</style>

<script type="text/javascript">
function serviceInfo() {
   const url = "<%=ctxPath%>/serviceInfo.do";

   const width = 800;
   const height = 680;

   const left = Math.ceil((window.screen.width - width) / 2);
   const top = Math.ceil((window.screen.height - height) / 2);

   window.open(url, "serviceInfoPopup", `left=${left}px,top=${top}px,width=${width}px,height=${height}px`);
}

function privacyInfo() {
      const url = "<%=ctxPath%>/privacyInfo.do";

      const width = 800;
      const height = 680;

      const left = Math.ceil((window.screen.width - width) / 2);
      const top = Math.ceil((window.screen.height - height) / 2);

      window.open(url, "serviceInfoPopup", `left=${left}px,top=${top}px,width=${width}px,height=${height}px`);
   }
</script>
         
   </div>
   
   <div class="row text-center" id="footer">
      <div class="col-md-12 footerInner" style="display:flex;flex-direction:column;">
         <p class="footLogo"><img src="/SemiProject/images/footer/footerLogo.png" style="width:100%;"></p>
         <div class="footerBox">
            <a class="footerTopnav" href="<%= ctxPath%>/#">회사소개</a>
            <a class="footerTopnav" href="<%= ctxPath%>/location.do" >오시는 길</a>
            <a class="footerTopnav" href="javascript:serviceInfo()">이용약관</a>
            <a class="footerTopnav" href="javascript:privacyInfo()">개인정보처리방침</a>
         </div>
         
         <p class="footerInfo">
            회사명: 퍼퓸아레나 | 위치: 서울시 강남구 (역삼동) 한독빌딩 8층<br>
            사업자등록번호: 000-00-00000<br>
            통신판매업신고번호: 강남-00000호<br>
            제품 구매 관련 문의: test@gmail.com<br>
         </p>
      </div>
   </div>

</div>
</body>
</html>