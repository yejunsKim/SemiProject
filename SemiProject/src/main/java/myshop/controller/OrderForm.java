package myshop.controller;

import java.util.List;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import myshop.domain.CartVO;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;
import user.domain.UserVO;

public class OrderForm extends BaseController {
	
	private ItemDAO idao = null;
	
	public OrderForm() {
		idao = new ItemDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		 HttpSession session = request.getSession();
         UserVO loginUser = (UserVO) session.getAttribute("loginUser");
         
         String[] selectedCartnos = request.getParameterValues("selectedItems");
         
         List<CartVO> orderItemList = idao.getOrderItem(loginUser.getId());
         
         request.setAttribute("orderItemList", orderItemList);
        
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/shop/orderForm.jsp");
		
	}

}