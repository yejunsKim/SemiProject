package myshop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.domain.ItemVO;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;

public class PerfumeDisplayJSON extends BaseController {

	private ItemDAO idao = null;
	
	public PerfumeDisplayJSON() {
		idao = new ItemDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
	//	String categoryName = request.getParameter("categoryName");	// "10대" "20대" "남성" "여성"
		String start = request.getParameter("start");
		String len = request.getParameter("len");
		
		
		Map<String, String> paraMap = new HashMap<>();
	//	paraMap.put("categoryName", categoryName);	// "10대" "20대" "남성" "여성"
		paraMap.put("start", start);	// start "1" "9" "17" "25" "33"
		
		String end = String.valueOf(Integer.parseInt(start) + Integer.parseInt(len) - 1); 
		paraMap.put("end", end);		// end => start + len - 1;
										// end   "8" "16" "24" "32"
		
		List<ItemVO> itemList = idao.selectBycategoryName(paraMap);
		
		JSONArray jsonArr = new JSONArray();	// []
		
		if(itemList.size() > 0) {
			
			for(ItemVO ivo : itemList) {
				
				JSONObject jsonObj = new JSONObject();	// {}
				
				jsonObj.put("itemno", ivo.getItemNo());
				jsonObj.put("itemname", ivo.getItemName());
				jsonObj.put("itemphotopath", ivo.getItemPhotoPath());
				jsonObj.put("volume", ivo.getVolume());
				jsonObj.put("price", ivo.getPrice());
				
				jsonArr.put(jsonObj);
				
			}// end of for-----------------
			
		}// end of if-----------------
		
		String json = jsonArr.toString();	// 문자열로 변환
		
		request.setAttribute("json", json);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}
