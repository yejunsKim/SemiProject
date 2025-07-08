<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String ctxPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>• Edit Profile •</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- Tailwind CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    
    <!-- jQuery -->
    <script src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
    
    <!-- 주소 API -->
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    
    <!-- 직접만든 JS -->
    <script src="<%= ctxPath%>/js/user/userEdit.js"></script>

    <!-- 스타일 -->
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap');

        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f5f3ff;
            background-image: url('https://img.freepik.com/free-vector/hand-painted-watercolor-floral-pattern_23-2148931052.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            background-blend-mode: overlay;
        }

        .error {
            color: #ef4444;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }

        .btn-check {
            background-color: #c084fc;
            transition: all 0.3s;
        }

        .btn-check:hover {
            background-color: #a855f7;
        }

        input:focus {
            outline: none;
            border-color: #9333ea;
            box-shadow: 0 0 0 2px rgba(147, 51, 234, 0.2);
        }

        @media (max-width: 768px) {
            .form-container {
                width: 90% !important;
            }
        }
    </style>
</head>

<body class="min-h-screen flex items-center justify-center p-4">
    <div class="form-container w-full max-w-3xl bg-white rounded-xl shadow-xl overflow-hidden backdrop-blur">
        <div class="bg-purple-400 py-4 px-6">
            <h1 class="text-2xl font-bold text-white text-center italic">
                :: ${sessionScope.loginUser.id}님의 Profile ::
            </h1>
        </div>

        <form name="editForm" class="p-6 md:p-8">
            <input type="hidden" name="id" value="${sessionScope.loginUser.id}" />
            <div class="space-y-5">
                
                <!-- 이름 -->
                <div>
                    <label for="name" class="block font-medium text-gray-700 mb-1">성명 <span class="text-red-600">*</span></label>
                    <input type="text" id="name" name="name" maxlength="30" class="requiredInfo w-full px-4 py-2 border rounded-lg" value="${sessionScope.loginUser.name}">
                    <span class="error">필수 입력 사항입니다</span>
                </div>

                <!-- 비밀번호 -->
                <div>
                    <label for="password" class="block font-medium text-gray-700 mb-1">비밀번호 <span class="text-red-600">*</span></label>
                    <input type="password" id="password" name="password" maxlength="30" class="requiredInfo w-full px-4 py-2 border rounded-lg">
                    <span class="error">영문자,숫자,특수기호가 혼합된 8~15 비밀번호를 입력해주세요</span>
                </div>

                <!-- 비밀번호 확인 -->
                <div>
                    <label for="passwordCheck" class="block font-medium text-gray-700 mb-1">비밀번호 확인 <span class="text-red-600">*</span></label>
                    <input type="password" id="passwordCheck" maxlength="30" class="requiredInfo w-full px-4 py-2 border rounded-lg">
                    <span class="error">비밀번호가 일치하지 않습니다</span>
                </div>

                <!-- 이메일 -->
                <div>
                    <label for="email" class="block font-medium text-gray-700 mb-1">이메일 <span class="text-red-600">*</span></label>
                    <div class="flex gap-2">
                        <input type="text" id="email" name="email" maxlength="60" class="requiredInfo flex-grow px-4 py-2 border rounded-lg" value="${sessionScope.loginUser.email}">
                        <span id="emailCheck" class="btn-check text-white px-4 py-2 rounded-lg cursor-pointer">이메일중복확인</span>
                    </div>
                    <span id="emailCheckResult" class="block mt-1 text-sm"></span>
                    <span class="error">이메일 형식에 맞지 않습니다</span>
                </div>

                <!-- 연락처 -->
                <div>
                    <label for="hp1" class="block font-medium text-gray-700 mb-1">연락처 <span class="text-red-600">*</span></label>
                    <div class="flex items-center gap-2">
                        <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly class="w-20 px-3 py-2 border rounded-lg text-center">
                        <span>-</span>
                        <input type="text" id="hp2" name="hp2" size="6" maxlength="4" value="${fn:substring(sessionScope.loginUser.mobile, 3, 7)}" class="w-24 px-3 py-2 border rounded-lg text-center">
                        <span>-</span>
                        <input type="text" id="hp3" name="hp3" size="6" maxlength="4" value="${fn:substring(sessionScope.loginUser.mobile, 7, 11)}" class="w-24 px-3 py-2 border rounded-lg text-center">
                    </div>
                    <span class="error">휴대폰 형식이 아닙니다.</span>
                </div>

                <!-- 주소 -->
                <div style="display:flex;justify-content:space-between;">
                	<div style="width:30%;">
                    	<label class="block font-medium text-gray-700 mb-1">주소</label>
                    </div>
                    <div>
                   <!-- 우편번호 -->
		                <div>
		                    <label for="postcode" class="block font-medium text-gray-700 mb-1"></label>
		                    <div class="flex gap-2 items-center">
		                        <input type="text" id="postcode" name="postcode" size="6" maxlength="5" value="${sessionScope.loginUser.postcode}" class="flex-grow px-4 py-2 border rounded-lg">
		                        <img src="<%= ctxPath%>/images/find_postcode.gif" width="6%" id="postcodeSearch" class="cursor-pointer">
		                    </div>
		                    <span class="error">우편번호 형식에 맞지 않습니다.</span>
		                </div>
	                    <input type="text" name="address" id="address" class="w-full px-4 py-2 border rounded-lg mb-2" placeholder="주소" value="${sessionScope.loginUser.address}">
	                    <input type="text" name="detailAddress" id="addressDetail" class="w-full px-4 py-2 border rounded-lg mb-2" placeholder="상세주소" value="${sessionScope.loginUser.addressDetail}">
	                    <input type="text" name="extraAddress" id="addressExtra" class="w-full px-4 py-2 border rounded-lg" placeholder="참고항목" value="${sessionScope.loginUser.addressExtra}">
	                    <span class="error">주소를 입력하세요.</span>
                    </div>
                </div>
            </div>

            <!-- 버튼 -->
            <div class="mt-8 flex justify-center gap-4">
                <input type="button" value="수정하기" onclick="edit()" class="bg-purple-400 text-white px-8 py-3 rounded-lg font-bold hover:shadow-lg cursor-pointer">
                <input type="reset" value="원래대로" onclick="reset()" class="bg-gray-300 text-gray-700 px-8 py-3 rounded-lg font-bold hover:bg-gray-400 cursor-pointer">
            </div>
        </form>
    </div>
</body>
</html>
