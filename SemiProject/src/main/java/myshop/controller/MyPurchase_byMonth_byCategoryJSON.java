package myshop.controller;

import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;

public class MyPurchase_byMonth_byCategoryJSON extends BaseController {

	private ItemDAO itemDAO = new ItemDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// === 로그인 유무 검사하기 === //
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
			
			List<Map<String, String>> myPurchase_map_List = itemDAO.myPurchase_byMonth_byCategory(id);
			
			JSONArray json_arr = new JSONArray();
			
			if(myPurchase_map_List.size() > 0) {
				for(Map<String, String> map : myPurchase_map_List) {
					JSONObject json_obj = new JSONObject(); 
					json_obj.put("categoryname", map.get("categoryname"));
					json_obj.put("cnt", map.get("cnt"));
					json_obj.put("sumpay", map.get("sumpay"));
					json_obj.put("sumpay_pct", map.get("sumpay_pct"));
					json_obj.put("m_01", map.get("m_01"));
					json_obj.put("m_02", map.get("m_02"));
					json_obj.put("m_03", map.get("m_03"));
					json_obj.put("m_04", map.get("m_04"));
					json_obj.put("m_05", map.get("m_05"));
					json_obj.put("m_06", map.get("m_06"));
					json_obj.put("m_07", map.get("m_07"));
					json_obj.put("m_08", map.get("m_08"));
					json_obj.put("m_09", map.get("m_09"));
					json_obj.put("m_10", map.get("m_10"));
					json_obj.put("m_11", map.get("m_11"));
					json_obj.put("m_12", map.get("m_12"));
					
					json_arr.put(json_obj);
				}// end of for--------------
			}
			
			request.setAttribute("json", json_arr.toString());
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}		

	}

}
