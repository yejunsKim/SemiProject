package common.controller;

import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import user.model.userDAO;
import user.model.userDAO_imple;

public class MainController extends BaseController {

	private userDAO pdao;
	
	public MainController() {
		pdao = new userDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		super.setRedirect(false);
		super.setViewPage("/WEB-INF/main.jsp");
		
	}
}
