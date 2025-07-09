package myshop.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;
import user.domain.UserVO;

public class CartAdd extends BaseController {
	
	private ItemDAO idao = null;
	
	public CartAdd() {
		idao = new ItemDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// === 로그인 유무 검사하기 === //
		if( !super.checkLogin(request) ) {
			// 로그인을 하지 않은 상태이라면 
			
			request.setAttribute("message", "장바구니에 담으려면 먼저 로그인 부터 하세요!!");
			request.setAttribute("loc", "javascript:history.back()");
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;
		}
		
		else {	// 로그인을 한 상태라면
			
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) {	// POST 방식이라면
				
				HttpSession session = request.getSession();
				UserVO loginUser = (UserVO) session.getAttribute("loginUser");
				String fk_users_id = loginUser.getId();
				
				if("admin".equals(fk_users_id)) {	// 관리자 로그인 이라면
					
					String message = "관리자 아이디로 장바구니를 담을 수는 없습니다.";
					String loc = "javascript:history.back()";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}
				
				else {	// 일반 사용자 로그인 이라면
					
					String fk_item_no = request.getParameter("itemNo");
					String cartamount = request.getParameter("quantity");
				//	System.out.println("~~~확인용 1. " + fk_item_no + " 2. " + cartamount + " 3. " + loginUser.getId());
					
					Map<String ,String> paraMap = new HashMap<>();
					paraMap.put("fk_users_id", fk_users_id);
					paraMap.put("fk_item_no", fk_item_no);
					paraMap.put("cartamount", cartamount);
					
					try {
						// 장바구니 담기 
						int n = idao.insertCartOne(paraMap);
						
						if(n == 1) {
							super.setRedirect(true);
							super.setViewPage(request.getContextPath()+"/item/cartList.do");
						}
						
					} catch(SQLException e) {
						request.setAttribute("message", "재고가 부족합니다. 관리자에게 문의바랍니다.");
						request.setAttribute("loc", "javascript:history.back()");
						
						super.setRedirect(false);
						super.setViewPage("/WEB-INF/msg.jsp");
					}
				}
				
			}
			
			else {	// GET 방식이라면
				
				String message = "비정상적인 경로로 들어왔습니다";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		}
		
	}

}
