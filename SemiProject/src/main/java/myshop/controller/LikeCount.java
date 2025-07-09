package myshop.controller;

import java.util.Map;

import org.json.JSONObject;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;

public class LikeCount extends BaseController {

private ItemDAO itemDAO = null;
	
	public LikeCount() {
		itemDAO = new ItemDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    String reviewId = request.getParameter("reviewId");
	    JSONObject jsonObj = new JSONObject();

	    if(reviewId == null) {
	        jsonObj.put("likecnt", 0); 
	    }
	    else {
	        Map<String, Integer> map = itemDAO.getLikeCount(reviewId);
	        int likecnt = (map != null && map.get("likecnt") != null) ? map.get("likecnt") : 0;
	        jsonObj.put("likecnt", likecnt);
	    }

	    request.setAttribute("json", jsonObj.toString());
	    super.setRedirect(false);
	    super.setViewPage("/WEB-INF/jsonview.jsp");
	}
}
