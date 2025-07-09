package myshop.controller;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

import org.json.JSONObject;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.domain.ReviewVO;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;

public class ReviewRegister extends BaseController {
	
	private ItemDAO itemDAO = new ItemDAO_imple();

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			String content = request.getParameter("content");
			String fk_id = request.getParameter("fk_id");
			String fk_itemNo = request.getParameter("fk_itemNo");
			
			// 입력한 내용에서 엔터는 <br>로 변환시키기
			content = content.replaceAll("\r\n", "<br>");
			
			ReviewVO reviewVO = new ReviewVO();
			reviewVO.setContent(content);
			reviewVO.setFk_id(fk_id);
			reviewVO.setFk_itemNo(Integer.parseInt(fk_itemNo));
			
			int n = 0;
			
			try {
				n = itemDAO.addReview(reviewVO);
				
			} catch(SQLIntegrityConstraintViolationException e) {
				e.printStackTrace();
				n = -1;
			} catch(SQLException e) {
				e.printStackTrace();
			}
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("n", n);
			
			String json = jsonObj.toString();
			
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
			
		}

	}

}
