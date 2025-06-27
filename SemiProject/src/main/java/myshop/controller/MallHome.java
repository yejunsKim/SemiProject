package myshop.controller;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;

public class MallHome extends BaseController {

	private ItemDAO idao = null;
	
	public MallHome() {
		idao = new ItemDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String categoryNo = request.getParameter("categoryNo");
		String categoryName = "";
		
	//	System.out.println("확인용 categoryNo => " + categoryNo);
		
		if(categoryNo != null) {
			int totalCount = idao.totalCount(categoryNo);
			
			categoryName = idao.getCategoryName(categoryNo);	// No에 맞는 카테고리명 가져오기
			
			request.setAttribute("totalCount", totalCount);
			
			request.setAttribute("categoryName", categoryName);
			
		}
		
		else {
			categoryName = "전체 향수 목록";
			
			int totalCount = idao.totalCount();	// 상품의 전체 개수를 알아온다.
			
			request.setAttribute("totalCount", totalCount);
			
			request.setAttribute("categoryName", categoryName);
		}
		
	//	int totalTenCount = idao.totalTenCount(1);	// 상품의 전체 개수를 알아온다.
		
	//	request.setAttribute("totalTenCount", totalTenCount);
		
	//	request.setAttribute("categoryNo", categoryNo);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/shop/perfumeMall.jsp");

		
	}

}
