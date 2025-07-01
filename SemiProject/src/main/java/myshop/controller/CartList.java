package myshop.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import myshop.domain.CartVO;
import myshop.domain.ItemVO;
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
		
		if(super.checkLogin(request)) {	// 로그인 했을 경우
			
			String id = request.getParameter("id");
		//	System.out.println("1. " + id);
			
			HttpSession session = request.getSession();
			UserVO loginUser = (UserVO) session.getAttribute("loginUser");
			String fk_users_id = loginUser.getId();
			
			if(fk_users_id.equals(id)) {	// 본인 아이디
				
				String fk_item_no = request.getParameter("itemNo");
				String cartamount = request.getParameter("quantity");
			//	System.out.println("~~~확인용 1. " + itemNo + " 2. " + quantity + " 3. " + loginUser.getId());
				
				Map<String ,String> paraMap = new HashMap<>();
				paraMap.put("fk_users_id", fk_users_id);
				paraMap.put("fk_item_no", fk_item_no);
				paraMap.put("cartamount", cartamount);
				
				try {
					// 장바구니 담기 
					int n = idao.insertCartOne(paraMap);
					
					if(n == 1) {
						
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
					
				} catch(SQLException e) {
					request.setAttribute("message", "장바구니 담기 실패!!");
					request.setAttribute("loc", "javascript:history.back()");
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}
				
			}
			
			else {	// 본인 아이디가 아닐 경우
				
				String message = "다른 유저의 장바구니에 담을 수 없습니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		}
		
		else {	// 로그인 하지 않았을 경우
			
			String message = "장바구니에 담기 위해서는 먼저 로그인을 하셔야 합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}

}
