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
		
		int totalTenCount = idao.totalTenCount(1);	// 10대 상품의 전체 개수를 알아온다.
		
		request.setAttribute("totalTenCount", totalTenCount);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/shop/perfumeMall.jsp");

		
	}

}
