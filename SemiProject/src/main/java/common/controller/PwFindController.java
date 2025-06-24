package common.controller;

import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.model.ProductDAO;
import myshop.model.ProductDAO_imple;

public class PwFindController extends BaseController {

	private ProductDAO pdao;
	
	public PwFindController() {
		pdao = new ProductDAO_imple();
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
