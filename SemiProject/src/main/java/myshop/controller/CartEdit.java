package myshop.controller;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;

public class CartEdit extends BaseController {
	
	private ItemDAO idao = null;
	
	public CartEdit() {
		idao = new ItemDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {	// GET 방식일 경우
			
			String message = "비정상적인 경로로 들어왔습니다";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		else if("POST".equalsIgnoreCase(method) && super.checkLogin(request)) {
			// POST 방식이고, 로그인 했으면
			
			String cartno = request.getParameter("cartno");
			String cartamount = request.getParameter("cartamount");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("cartno", cartno);
			paraMap.put("cartamount", cartamount);
			
			// 장바구니 테이블에서 선택 제품의 주문량 변경시키기
			int n = idao.amountUpdate(paraMap);
			
			JSONObject jsobj = new JSONObject();	// {}
			jsobj.put("n", n);	// {"n":1}
			
			String json = jsobj.toString();
			
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}
		
	}

}
