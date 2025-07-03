package myshop.controller;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.domain.ReviewVO;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;

public class ReviewList extends BaseController {
	
	private ItemDAO itemDAO = new ItemDAO_imple();

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String fk_itemNo = request.getParameter("fk_itemNo");
		
		List<ReviewVO> reviewList = itemDAO.reviewList(fk_itemNo);

		JSONArray jsArr = new JSONArray(); // []
		
		if(reviewList.size() > 0) {
			
			for(ReviewVO reviewvo : reviewList) {
				
				JSONObject jsobj = new JSONObject();
				jsobj.put("reviewId", reviewvo.getReviewId());
				jsobj.put("fk_id", reviewvo.getFk_id());
				jsobj.put("name", reviewvo.getUserVO().getName());
				jsobj.put("content", reviewvo.getContent());
				jsobj.put("createdAt", reviewvo.getCreatedAt());
				
				jsArr.put(jsobj);
				
			}
			
		}
		
		String json = jsArr.toString();
		
		request.setAttribute("json", json);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}
