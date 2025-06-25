package user.controller;

import org.json.JSONObject;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import user.model.UserDAO;
import user.model.UserDAO_imple;

public class CheckIdDuplicate extends BaseController {
	private UserDAO userDAO = new UserDAO_imple();
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("post".equalsIgnoreCase(method)) {
			String id = request.getParameter("id");
			
			boolean isExists = userDAO.checkIdDuplicate(id);
			
			// 자바스크립트의 {} 로 만들어줄 JSON객체
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("isExists",isExists); 
			//{"isExists":true(false)} 형태 만들고,
			// 문자형태인 {"isExists":true(false)} 로 만들려면 toString()
			String json = jsonObj.toString(); 
			System.out.println("json 형태 >> " + json);
			  
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}

	}

}
