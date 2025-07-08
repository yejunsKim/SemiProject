package myshop.controller;

import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;
import user.domain.UserVO;

public class MyPurchase_byCategoryJSON extends BaseController {
	
	private ItemDAO itemDAO = new ItemDAO_imple();

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		if(!super.checkLogin(request)) {
			// 로그인 하지 않은 경우이라면
	         
			String message = "관리자만 접근이 가능합니다.";
	        String loc = "javascript:history.back()";
	         
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	         
	        super.setRedirect(false);
	        super.setViewPage("/WEB-INF/msg.jsp");
		}
			      
		else {
			// 로그인을 했을 경우 
			String id = request.getParameter("id");
			
			List<Map<String, String>> myPurchase_map_List = itemDAO.myPurchase_byCategory(id);
			
			JSONArray json_arr = new JSONArray();
			
			if(myPurchase_map_List.size() > 0) {
				
				for(Map<String, String> map : myPurchase_map_List) {
					JSONObject json_obj = new JSONObject();
					json_obj.put("categoryname", map.get("categoryname"));
					json_obj.put("cnt", map.get("cnt"));
					json_obj.put("sumpay", map.get("sumpay"));
					json_obj.put("sumpay_pct", map.get("sumpay_pct"));
					
					json_arr.put(json_obj);
				} // end of for
				
			} 
			
			request.setAttribute("json", json_arr.toString());
	         
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}
	}
		

}
