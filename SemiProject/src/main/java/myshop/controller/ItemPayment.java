package myshop.controller;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import user.domain.UserVO;

public class ItemPayment extends BaseController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 원포트(구 아임포트) 결제창을 띄우기 위한 전제조건은 먼저 로그인을 해야 하는 것이다.
		if(super.checkLogin(request)) {
			// 로그인을 했으면
			// goCoinPurchaseEnd(ctxPath, coinmoney, userid, usepoint)
			// requestPayment(ctxPath, totalAmount, id, usePoint)
			String id = request.getParameter("id");
			String usePoint = request.getParameter("usePoint");
			
			HttpSession session = request.getSession();
			UserVO loginUser = (UserVO) session.getAttribute("loginUser");
			
			if(loginUser.getId().equals(id)) {
				// 로그인한 사용자가 결제하는 경우
				
				// request 데이터 가져와야함
				
				String s_totalAmount = request.getParameter("totalAmount");
				
				String productName = "PerfumeArena 상품";	// "새우깡"
			//	int productPrice = Integer.parseInt(s_coinmoney);
				
				int coinmoney = Integer.parseInt(s_totalAmount);
				
				request.setAttribute("productName", productName);
			//	request.setAttribute("productPrice", productPrice);
				
				request.setAttribute("productPrice", 100);
				
				request.setAttribute("coinmoney", coinmoney);
				request.setAttribute("email", loginUser.getEmail());
				request.setAttribute("name", loginUser.getName());
				request.setAttribute("mobile", loginUser.getMobile());
				
				
				request.setAttribute("userid", loginUser.getId());
				request.setAttribute("usePoint", usePoint);
				
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/shop/paymentGateway.jsp");
			}
			else {
				// 로그인한 사용자가 다른 사용자로 결제를 시도하는 경우
				String message = "다른 사용자의 코인충전 시도는 불가합니다!!";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		}
		else {
			// 로그인을 안 했으면
			String message = "코인충전 결제를 하기 위해서는 먼저 로그인을 하세요!!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}

}
