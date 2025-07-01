package myshop.controller;

import org.json.JSONObject;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;

public class CartDel extends BaseController {
	
	private ItemDAO idao = null;
	
	public CartDel() {
		idao = new ItemDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {
			// GET 방식이라면
		
			String message = "비정상적인 경로로 들어왔습니다";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		else if("POST".equalsIgnoreCase(method) && super.checkLogin(request)) {
			// POST 방식이고, 로그인을 했다라면
			
			String cartno = request.getParameter("cartno");
			
			// 장바구니에서 특정 제품 삭제하기
			int n = idao.cartDelete(cartno);
			
			JSONObject jsonobj = new JSONObject();
			jsonobj.put("n", n);
			
			String json = jsonobj.toString();
			
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}
		
	}

}
