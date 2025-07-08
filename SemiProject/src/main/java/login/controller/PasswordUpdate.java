package login.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import user.model.UserDAO;
import user.model.UserDAO_imple;

public class PasswordUpdate extends BaseController {

	private UserDAO UserDAO = new UserDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		// POST 방식이 아닐 경우 접근 차단
	    if (!"POST".equalsIgnoreCase(method)) {
	        String message = "비정상적인 접근입니다.";
	        String loc = request.getContextPath() + "/main.do";

	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);

	        super.setRedirect(false);
	        super.setViewPage("/WEB-INF/msg.jsp");
	        return;
	    }
		
	    // POST 방식일 경우에만 비밀번호 업데이트 수행
		String id = request.getParameter("id");
		String new_password = request.getParameter("newPassword1");		
				
		System.out.println(id);
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("new_password", new_password);
		paraMap.put("id", id);
					
		int result = 0;
		
		try {
			result = UserDAO.pwdUpdate(paraMap);
		} catch(SQLException e) {
			e.printStackTrace();
		}
					
		if (result == 1) {

			String message = "비밀번호가 성공적으로 변경되었습니다.";
            String loc = request.getContextPath() + "/main.do";

            request.setAttribute("message", message);
            request.setAttribute("loc", loc);

            super.setRedirect(false);
            super.setViewPage("/WEB-INF/msg.jsp");
            return;
		} 
		else {
				            
	    	System.out.println("변경 안되는 중이오.");
	        request.setAttribute("id", id);
	        request.setAttribute("method", method);
	        request.setAttribute("result", result);
	
	        super.setRedirect(false);
	        super.setViewPage("/WEB-INF/login/passwordUpdate.jsp");
        }
			
	}
}
				
				

