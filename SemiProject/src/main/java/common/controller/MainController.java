package common.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import user.model.UserDAO;
import user.model.UserDAO_imple;

public class MainController extends BaseController {

	private UserDAO UserDAO;
	
	public MainController() {
		UserDAO = new UserDAO_imple();
	}
	
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.setRedirect(false);
        super.setViewPage("/WEB-INF/main.jsp");
    }
}
