package common.controller;

import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.domain.CategoryVO;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;
import user.model.UserDAO;
import user.model.UserDAO_imple;

public class MainController extends BaseController {

	//private ProductDAO productdao = new ProductDAO_imple();

	private ItemDAO itemDAO = new ItemDAO_imple();
			
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		try {
			List<CategoryVO> categoryList= itemDAO.imageSelectAll();
			request.setAttribute("categoryList", categoryList);
			if (request.getServletContext().getAttribute("categoryList") == null) {
				request.getServletContext().setAttribute("categoryList", categoryList);
			}

			
			for( CategoryVO category : categoryList ) {

			}
		
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/main.jsp");
			
		 }  catch (SQLException e) {
			e.printStackTrace();
			
			super.setRedirect(true);
			super.setViewPage(request.getContextPath()+"/error.up");
			
			
		}
			
	}
}