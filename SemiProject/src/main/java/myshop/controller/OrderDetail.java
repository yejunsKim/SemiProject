package myshop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import myshop.domain.Order_itemsVO;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;
import user.domain.UserVO;

public class OrderDetail extends BaseController {
	
	private ItemDAO idao;
	
	public OrderDetail() {
		idao = new ItemDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String referer = request.getHeader("referer");
		
		if(referer == null) {	// referer == null 은 웹브라우저 주소창에 URL 을 직접 입력하고 들어온 경우이다.
			super.setRedirect(true);
			super.setViewPage(request.getContextPath()+"/main.do");
			return;
		}
		
		// 주문 상세 내역은 해당사용자가 로그인을 해야만 볼 수 있다.
		if(!super.checkLogin(request)) {
			request.setAttribute("message", "주문 상세 내역을 보려면 먼저 로그인 부터 하세요!!");
			request.setAttribute("loc", "javascript:history.back()"); 
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		else {	// 로그인을 했을 경우 
			
			HttpSession session = request.getSession();
			UserVO loginUser = (UserVO) session.getAttribute("loginUser");
			String id = loginUser.getId();
			
			String orderno = request.getParameter("orderno");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("orderno", orderno);
			paraMap.put("id", id);
			
			// 상품이미지, 상품이름, 상품용량(item 테이블) // 주문수량, 주문금액(주문상세내역 테이블) // 최종결제금액(주문내역 테이블)
			List<Order_itemsVO> oiList = idao.selectOrderDetail(paraMap);
			
			request.setAttribute("oiList", oiList);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/shop/orderDetail.jsp");
		}
		
	}

}
