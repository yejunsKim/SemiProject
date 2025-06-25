package common.controller;

import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;
import myshop.domain.CategoryVO;

public class Commercials extends BaseController{

	//private ProductDAO productdao = new ProductDAO_imple();
		private ItemDAO idao;
		
		public Commercials() {
			idao = new ItemDAO_imple();
		}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		try {
			List<CategoryVO> categoryList= idao.imageSelectAll();
			request.setAttribute("categoryList", categoryList);
			
			for( CategoryVO category : categoryList ) {

			}
		
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/Commercials.jsp");
		}catch (SQLException e) {
			e.printStackTrace();
			
			super.setRedirect(true);
			super.setViewPage(request.getContextPath()+"/error.up");
			
			
		}
		
	}

}
