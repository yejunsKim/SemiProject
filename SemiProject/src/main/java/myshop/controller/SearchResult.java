package myshop.controller;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;

public class SearchResult extends BaseController {

	private ItemDAO idao = null;
	
	public SearchResult() {
		idao = new ItemDAO_imple();
	}
	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
	    String searchID = request.getParameter("searchID");

	    ItemDAO dao = new ItemDAO_imple();
	    int totalCount = dao.getSearchResultCount(searchID);

	    request.setAttribute("searchID", searchID);
	    request.setAttribute("totalCount", totalCount);

	    super.setRedirect(false);
	    super.setViewPage("/WEB-INF/shop/searchResult.jsp");
		
	}

}
