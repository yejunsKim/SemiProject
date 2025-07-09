package myshop.controller;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;

public class LikeAdd extends BaseController {
	
	private ItemDAO itemDAO = null;
	
	public LikeAdd() {
		itemDAO = new ItemDAO_imple();
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		  String fk_reviewId = request.getParameter("fk_reviewId");
	      String fk_id = request.getParameter("fk_id");
	      
	      Map<String,String> paraMap = new HashMap<>();
	      paraMap.put("fk_reviewId", fk_reviewId);
	      paraMap.put("fk_id", fk_id);
	      
	      int n = itemDAO.likeAdd(paraMap);
	      // n => 1 이라면 정상투표,  n => 0 이라면 중복투표
	      
	      String msg = "";
	      
	      if(n==1) {
	         msg = "해당리뷰에\n 좋아요를 클릭하셨습니다.";
	      }
	      else if(n==0) {
	         //msg = "이미 좋아요를 클릭하셨습니다.\n 두번 이상 좋아요는 불가합니다.";
	    	  msg="좋아요를 취소했습니다.";
	      }
	      
	      JSONObject jsonObj = new JSONObject();
	      jsonObj.put("msg", msg); // {"msg":"해당제품에\n 좋아요를 클릭하셨습니다."}   {"msg":"이미 좋아요를 클릭하셨기에\n 두번 이상 좋아요는 불가합니다."} 
	      
	      String json = jsonObj.toString(); // "{"msg":"해당제품에\n 좋아요를 클릭하셨습니다."}"   "{{"msg":"이미 좋아요를 클릭하셨기에\n 두번 이상 좋아요는 불가합니다."}}" 
	      
	      request.setAttribute("json", json);
	      
	   //   super.setRedirect(false);
	      super.setViewPage("/WEB-INF/jsonview.jsp");
	

		
	}

}
