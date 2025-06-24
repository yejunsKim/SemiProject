package common.controller;

import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import shop.domain.CategoryVO;
import shop.model.ProductDAO;
import shop.model.ProductDAO_imple;

public class Commercials extends BaseController{

	//private ProductDAO productdao = new ProductDAO_imple();
		private ProductDAO productdao;
		
		public Commercials() {
			productdao = new ProductDAO_imple();
		}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		try {
			List<CategoryVO> categoryList= productdao.imageSelectAll();
			request.setAttribute("categoryList", categoryList);
			
			for( CategoryVO category : categoryList ) {

			}
		
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/main.jsp");
		}catch (SQLException e) {
			e.printStackTrace();
			
			super.setRedirect(true);
			super.setViewPage(request.getContextPath()+"/error.up");
			
			
		}
		
	}

}
