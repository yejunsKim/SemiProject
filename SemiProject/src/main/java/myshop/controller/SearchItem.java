package myshop.controller;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;

public class SearchItem extends BaseController {

	private ItemDAO idao = null;
	
	public SearchItem() {
		idao = new ItemDAO_imple();
	}
	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String searchID = request.getParameter("searchID");
		System.out.println("검색어: " + searchID);
		
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/shop/SearchItem.jsp");
		
	}

}
