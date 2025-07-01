package myshop.controller;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class OrderForm extends BaseController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/shop/orderForm.jsp");

	}

}
