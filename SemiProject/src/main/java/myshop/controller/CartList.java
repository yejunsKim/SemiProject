package myshop.controller;

import java.util.List;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import myshop.domain.CartVO;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;
import user.domain.UserVO;

public class CartList extends BaseController {
	
	private ItemDAO idao = null;
	
	public CartList() {
		idao = new ItemDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String referer = request.getHeader("referer");
	//	System.out.println("~~~~ 확인용 referer : " + referer);
		
		if(referer == null) {	// referer == null 은 웹브라우저 주소창에 URL 을 직접 입력하고 들어온 경우이다.
			super.setRedirect(true);
			super.setViewPage(request.getContextPath()+"/main.do");
			return;
		}
		
		// 장바구니 보기는 반드시 해당사용자가 로그인을 해야만 볼 수 있다.
		if(!super.checkLogin(request)) {
			request.setAttribute("message", "장바구니를 보려면 먼저 로그인 부터 하세요!!");
			request.setAttribute("loc", "javascript:history.back()"); 
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		else {	// 로그인을 했을 경우 
			
			HttpSession session = request.getSession();
			UserVO loginUser = (UserVO) session.getAttribute("loginUser");
			String fk_users_id = loginUser.getId();
			
			// 장바구니 목록 가져오기(select)
			List<CartVO> cartList = idao.selectItemCart(fk_users_id);
			
			int totalPrice = 0;
			int totalPoint = 0;

			for (CartVO cvo : cartList) {
			   
				totalPrice += cvo.getIvo().getPrice() * cvo.getCartamount();		// 총 상품금액
				totalPoint += cvo.getIvo().getItemPoint() * cvo.getCartamount();	// 총 적립금액
				
			}// end of for----------------------
			
			
			request.setAttribute("cartList", cartList);
			request.setAttribute("totalPrice", totalPrice);
			request.setAttribute("totalPoint", totalPoint);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/shop/cartList.jsp");
		}
		
	}

}
