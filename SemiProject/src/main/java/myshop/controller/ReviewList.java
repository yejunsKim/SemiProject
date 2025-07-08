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
		
		// 페이지 번호 가져오기
	    String pageStr = request.getParameter("page");
	    int currentPage = (pageStr == null || pageStr.trim().isEmpty()) ? 1 : Integer.parseInt(pageStr);

	    int sizePerPage = 5; // 한 페이지에 5개 보여주기
	    int startRow = (currentPage - 1) * sizePerPage + 1;
	    int endRow = currentPage * sizePerPage;
		
		List<ReviewVO> reviewList = itemDAO.reviewList(fk_itemNo, startRow, endRow);
		
		// 총 게시물 수
	    int totalCount = itemDAO.getReviewCount(fk_itemNo);
	    int totalPage = (int)Math.ceil((double)totalCount / sizePerPage);


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
		JSONObject result = new JSONObject();
		    result.put("reviews", jsArr);
		    result.put("totalPage", totalPage);
		    result.put("currentPage", currentPage);
		    
			request.setAttribute("json", result.toString());

		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}
