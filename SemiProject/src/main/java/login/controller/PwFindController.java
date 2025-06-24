package login.controller;

import java.util.HashMap;
import java.util.Map;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import user.model.userDAO;
import user.model.userDAO_imple;

public class PwFindController extends BaseController {

	private userDAO pdao;
	
	public PwFindController() {
		pdao = new userDAO_imple();
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
			int n = pdao.pwFindUser(paraMap);
			
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
		super.setViewPage("/WEB-INF/pwFind.jsp");

	}

}
