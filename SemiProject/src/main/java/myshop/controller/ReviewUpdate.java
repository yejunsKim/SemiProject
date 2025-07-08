package myshop.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;

public class ReviewUpdate extends BaseController {

private ItemDAO itemDAO = null;
	
	public ReviewUpdate() {
		itemDAO = new ItemDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			// **** POST 방식으로 넘어온 것이라면 **** //
			
			String reviewId = request.getParameter("reviewId");
			String content = request.getParameter("content");
			
			// 입력한 내용에서 엔터는 <br> 로 변환시키기
			content = content.replaceAll("\r\n", "<br>");
						
			Map<String, String> paraMap = new HashMap<>();
	         paraMap.put("reviewId", reviewId);
	         paraMap.put("content", content);
	         
			int n = 0;
			try {
				 n = itemDAO.reviewUpdate(paraMap);
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
