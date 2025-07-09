<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
    String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp" />

<!-- Tailwind + FontAwesome 불러오기 -->
<script src="https://cdn.tailwindcss.com"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

<div class="min-h-screen bg-gray-100 pt-24 pb-12">
    <div class="container mx-auto px-4">

        <!-- 배송지 정보 -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <div class="flex items-center mb-4">
                <i class="fas fa-truck text-blue-500 text-xl mr-3"></i>
                <h2 class="text-xl font-bold text-gray-800">배송지 정보</h2>
            </div>

            <div class="space-y-4">
                <div class="flex items-start">
                    <span class="w-24 font-medium text-gray-600">받는사람</span>
                    <div class="flex-1 text-gray-800">${sessionScope.loginUser.name}</div>
                </div>

                <div class="flex items-start">
                    <span class="w-24 font-medium text-gray-600">배송지</span>
                    <div class="flex-1 text-gray-800">
                       <span> ${requestScope.oiList[0].delivery_addressVO.address}&nbsp;</span>
                        <span>${requestScope.oiList[0].delivery_addressVO.addressdetail}&nbsp;</span>
                        <span>${requestScope.oiList[0].delivery_addressVO.addressextra}&nbsp;</span>
                        <span>(배송코드: ${requestScope.oiList[0].delivery_addressVO.deliveryno})</span>
                    </div>
                </div>

                <div class="flex items-start">
                    <span class="w-24 font-medium text-gray-600">연락처</span>
                    <div class="flex-1 text-gray-800">
                        010 - ${fn:substring(sessionScope.loginUser.mobile, 3, 7)} - ${fn:substring(sessionScope.loginUser.mobile, 7, 11)}
                    </div>
                </div>

                <div class="flex items-start border-b pb-4">
                    <span class="w-24 font-medium text-gray-600">이메일</span>
                    <div class="flex-1 text-gray-800">${requestScope.oiList[0].delivery_addressVO.email}</div>
                </div>
            </div>
        </div>

        <!-- 주문상품 -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <div class="flex items-center mb-4">
                <i class="fas fa-shopping-basket text-green-500 text-xl mr-3"></i>
                <h2 class="text-xl font-bold text-gray-800">주문 상품</h2>
            </div>

            <div class="max-h-80 overflow-y-auto pr-2">
                <div class="space-y-4">
                    <c:forEach var="oivo" items="${requestScope.oiList}">
                        <div class="flex items-center justify-between py-3 border-b">
                            <div class="flex items-center">
                                <img src="<%= ctxPath %>${oivo.ivo.itemPhotoPath}" alt="상품 이미지"
                                     class="w-16 h-16 object-cover rounded-md">
                                <div class="ml-4">
                                    <p class="font-medium text-gray-800">${oivo.ivo.itemName}</p>
                                    <p class="text-sm text-gray-500">${oivo.ivo.volume}ml</p>
                                </div>
                            </div>
                            <div class="flex flex-col items-end">
                                <span class="text-gray-600">${oivo.quantity}개</span>
                                <span class="font-semibold text-gray-800">
                                    <fmt:formatNumber value="${oivo.orderprice}" pattern="###,###"/>원
                                </span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <!-- 결제 정보 -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <div class="flex items-center mb-4">
                <i class="fas fa-credit-card text-purple-500 text-xl mr-3"></i>
                <h2 class="text-xl font-bold text-gray-800">결제 정보</h2>
            </div>

            <div class="space-y-3">
                <div class="flex justify-between items-center py-3 border-b">
                    <span class="font-semibold text-gray-700">총 상품 가격</span>
                    <span class="text-gray-800">
                        <fmt:formatNumber value="${oiList[0].ohvo.totalamount}" pattern="###,###"/>원
                    </span>
                </div>
                <div class="flex justify-between items-center py-3 border-b">
                    <span class="font-semibold text-gray-700">배송비</span>
                    <span class="text-gray-800">0원</span>
                </div>
                <div class="flex justify-between items-center py-3">
                    <span class="text-lg font-bold text-gray-800">최종 결제 금액</span>
                    <span class="text-lg font-bold text-blue-600">
                        <fmt:formatNumber value="${oiList[0].ohvo.totalamount}" pattern="###,###"/>원
                    </span>
                </div>
            </div>
        </div>

        <!-- 결제수단 -->
        <div class="bg-white rounded-lg shadow-md p-6">
            <div class="flex items-center">
                <i class="fas fa-money-bill-wave text-yellow-500 text-xl mr-3"></i>
                <h2 class="text-xl font-bold text-gray-800">결제 수단</h2>
            </div>
            <div class="mt-3 text-blue-500 font-semibold flex items-center">
                <i class="fas fa-credit-card mr-2"></i>
                카드 결제
            </div>
        </div>

    </div>
</div>


<jsp:include page="../footer.jsp" />