<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../../header.jsp" />  


<style type="text/css">

	.page-title {
        width: 80%;
    margin: 50px auto 10px auto;
       font-size: 24px;
        font-weight: bold;
        border-bottom: 2px solid #eee;
        padding-bottom: 10px;
        text-align: left;
    }

	 table#ItemInput {
        border-collapse: collapse;
        width: 80%;
        margin: 0 auto;
        font-size: 14px;
    }

    table#ItemInput td {
        border: 1px solid #ccc;
        padding: 10px;
    }

    .itemInputName {
        background-color: #e6fff2;
        font-weight: bold;
        width: 25%;
        text-align: right;
        padding-right: 15px;
    }

    table#ItemInput td input[type="text"],
    table#ItemInput td input[type="file"],
    table#ItemInput td select,
    table#ItemInput td textarea {
        width: 80%;
        box-sizing: border-box;
    }

    .error {
        color: red;
        font-weight: bold;
        font-size: 9pt;
        margin-left: 5px;
    }
   
</style> 
<script type="text/javascript">

  let total_fileSize = 0; 

  $(function(){
	  
	  $('span.error').hide();
	  
	  $('input[name="itemAmount"]').spinner({
			spin:function(event,ui){
				if(ui.value > 999) {
					$(this).spinner("value", 999);
					return false;
				}
				else if(ui.value < 1) {
					$(this).spinner("value", 1);
					return false;
				}
			}
	  });
	   
	  $(document).on("change", "input.itemPhotoPath", function(e){
		   const input_file = $(e.target).get(0);
		   const fileReader = new FileReader();
		   fileReader.readAsDataURL(input_file.files[0]);
		   fileReader.onload = function(){
		       document.getElementById("previewImg").src = fileReader.result;
		   };
		   total_fileSize += input_file.files[0].size; 
	  });
	  
	  // ===== 제품등록하기 =====
      $(document).on('click', 'input:button[id="btnRegister"]', function(){
         $('span.error').hide();
         let is_infoData_OK = true;
         $('.infoData').each(function(index, elmt){
            if($(elmt).val().trim() == "") {
               $(elmt).next().show();
               is_infoData_OK = false;
               return false;
            }
         });
         if(is_infoData_OK) {
            if(total_fileSize >= 20*1024*1024) {
               alert("첨부한 파일의 총합의 크기가 20MB 이상이어서 제품등록을 할 수 없습니다.");
               return;
            }
            var formData = new FormData($("form[name='itemInputFrm']").get(0));
            $.ajax({
            	url:"${pageContext.request.contextPath}/item/admin/itemRegister.do",
            	type:"post",
               data:formData,
               processData:false,
               contentType:false,
               dataType:"json",
               success:function(json){
                  if(json.result == 1) {
                     location.href="${pageContext.request.contextPath}/item/mallHome.do";
                  }
               },
               error: function(request, status, error){
                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
               }
            });
         }
      });

	  // === 취소하기 ===
      $('input[type="reset"]').click(function(){
         $('span.error').hide();
         $('img#previewImg').hide();
      });
	  
  }); // end of $(function(){})
</script>

<div class="page-title" style="margin-top:20px; margin-bottom:10px;">일반상품 등록</div>
<div align="center" style="margin-top:20px; margin-bottom: 20px;">

	
	<form name="itemInputFrm" enctype="multipart/form-data"> 
	      
		<table id="ItemInput" style="width: 80%;">
		<tbody>
			<tr>
				<td width="25%" class="itemInputName" style="padding-top: 10px;">카테고리</td>
				<td width="75%" align="left" style="padding-top: 10px;" >
					<select name="fk_catagory_no" class="infoData">
					
					    <option value="">:::선택하세요:::</option>
					    <c:forEach var="cvo" items="${requestScope.categoryList}">
					        <option value="${cvo.categoryNo}">${cvo.categoryName}</option>
					    </c:forEach>
					</select>
					<span class="error">필수입력</span>
				</td>	
			</tr>
			<tr>
				<td width="25%" class="itemInputName">제품명</td>
				<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;" >
					<input type="text" style="width: 300px;" name="itemName" class="box infoData" />
					<span class="error">필수입력</span>
				</td>
			</tr>
			<tr>
				<td width="25%" class="itemInputName">제조사</td>
				<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
					<input type="text" style="width: 300px;" name="company" class="box infoData" />
					<span class="error">필수입력</span>
				</td>
			</tr>
			<tr>
				<td width="25%" class="itemInputName">용량</td>
				<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
		           	<input name="volume" style="width: 30px; height: 20px;"> ML
					<span class="error">필수입력</span>
				</td>
			</tr>
			<tr>
				<td width="25%" class="itemInputName">제품정가(판매가)</td>
				<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
					<input type="text" style="width: 100px;" name="price" class="box infoData" /> 원
					<span class="error">필수입력</span>
				</td>
			</tr>
			<tr>
				<td width="25%" class="itemInputName">제품재고량</td>
				<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
		           	<input name="itemAmount" value="1" style="width: 30px; height: 20px;"> 개
					<span class="error">필수입력</span>
				</td>
			</tr>
			<tr>
				<td width="25%" class="itemInputName">제품이미지(대표이미지)</td>
				<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
					<input type="file" name="itemPhotoPath" class="itemPhotoPath" accept='image/*' /><span class="error">필수입력</span>
				</td>
			</tr>
			<tr>
				<td width="25%" class="itemInputName">상세정보이미지</td>
				<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
					<input type="file" name="infoImg" class="infoImg" accept='image/*' /><span class="error">필수입력</span>
				</td>
			</tr>
			
		
			
			
			<tr>
				<td width="25%" class="itemInputName">제품설명</td>
				<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
					<textarea name="itemInfo" rows="5" cols="60"></textarea>
				</td>
			</tr>
			
			
		    
		    
		    <%-- ==== 이미지파일 미리보여주기 ==== --%>
		    <tr>
		       	<td width="25%" class="itemInputName" style="padding-bottom: 10px;">이미지파일 미리보기</td>
		       	<td>
		       		<img id="previewImg" width="300" />
		       	</td>
		    </tr>
			
			<tr style="height: 70px;">
				<td colspan="2" align="center" style="border-left: hidden; border-bottom: hidden; border-right: hidden; padding: 50px 0;">
				    <input type="button" value="제품등록" id="btnRegister" style="width: 120px;" class="btn btn-info btn-lg mr-5" /> 
				    <input type="reset" value="취소"  style="width: 120px;" class="btn btn-danger btn-lg" />	
				</td>
			</tr>
		</tbody>
		</table>
		
	</form>

</div>

<jsp:include page="../../footer.jsp" />  
    