package login.controller;

import java.util.HashMap;
import java.util.Map;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import user.model.UserDAO;
import user.model.UserDAO_imple;

public class PasswordFind extends BaseController {

	private UserDAO UserDAO;
	
	public PasswordFind() {
		UserDAO = new UserDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if ("POST".equalsIgnoreCase(method)) {
			
			String id = request.getParameter("id");
			String email = request.getParameter("email");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("id", id);
			paraMap.put("email", email);
			int n = UserDAO.pwFindUser(paraMap);
			
			if (n == 1) {
				request.setAttribute("n", 1);
				request.setAttribute("email", email);
				request.setAttribute("id", id);
			}
			
			else {
				request.setAttribute("n", 0);
			}
		}
		
		else {
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/main.jsp");	
		}
	
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/PasswordFind.jsp");

	}

}
