package user.controller;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import user.model.UserDAO;
import user.model.UserDAO_imple;

public class UserOneDetail extends BaseController {
	
	private UserDAO userDAO;
	
	private UserOneDetail() {
		UserDAO userDAO = new UserDAO_imple();
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		

	}

}
