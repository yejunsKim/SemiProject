package myshop.controller;

import java.sql.SQLException;

import org.json.JSONObject;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;


public class ReviewDel extends BaseController {

	private ItemDAO itemDAO = null;
	
	public ReviewDel() {
		itemDAO = new ItemDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			// **** POST 방식으로 넘어온 것이라면 **** //
			
			String reviewId = request.getParameter("reviewId");
						
			int n = 0;
			try {
				 n = itemDAO.reviewDel(reviewId);
			} catch(SQLException e) {
				
			}
			
			JSONObject jsobj = new JSONObject(); // {} 
			jsobj.put("n", n); // {"n":1} 또는 {"n":0}
			
			String json = jsobj.toString(); // 문자열 형태로 변환해줌.
			// "{"n":1}" 또는 "{"n":0}"
			
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
		}
		else {
			// **** POST 방식으로 넘어온 것이 아니라면 **** //
			
			String message = "비정상적인 경로를 통해 들어왔습니다.!!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
		}

	}

}
