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
		
		String referer = request.getHeader("referer");
		
		if(referer == null) {	// referer == null 은 웹브라우저 주소창에 URL 을 직접 입력하고 들어온 경우이다.
			super.setRedirect(true);
			super.setViewPage(request.getContextPath()+"/main.do");
			return;
		}

		else { 
		
			//GET 방식이든 POST 방식이든 다들어온다
					String id = request.getParameter("id");
					
					String method = request.getMethod();
					
					if( "POST".equalsIgnoreCase(method) ) {
						
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
					            return;
					        }
							
					}	
					
					else {
					        request.setAttribute("id", id);
					        request.setAttribute("method", method);
	
					        super.setRedirect(false);
					        super.setViewPage("/WEB-INF/login/passwordUpdate.jsp");
				   }		
			}
	}
}