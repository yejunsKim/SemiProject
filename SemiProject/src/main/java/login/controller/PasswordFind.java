package login.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
			boolean sendCheckMail = false;

				if (n == 1) {
					sendCheckMail = true;
					request.setAttribute("n", 1);
					request.setAttribute("email", email);
					request.setAttribute("id", id);	
					
					Random rnd = new Random();
					
					String certification_code = "";
					
					char rndchar = ' ';
					for(int i = 0; i < 5; i++) {
						
						rndchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a'); 
						certification_code += rndchar; 
						
					} // end of for(int i = 0; i < 5; i++) 
					
					int rndnum = 0;
					for(int i = 0; i < 7; i++) {

						 rndnum = rnd.nextInt(9 - 0 + 1) + 0;
						 certification_code += rndnum;
						 
					} // end of for(int i = 0; i < 5; i++)
					
					System.out.println("----- 확인용 certificatin_code :" + certification_code);
					
					GoogleMail mail = new GoogleMail();
					
					try {
						mail.send_certification_code(email, certification_code);
						sendCheckMail = true;  
						
						HttpSession session = request.getSession();

						session.setAttribute("certification_code", certification_code);						
						
					} catch (Exception e) {

						e.printStackTrace();
						sendCheckMail = false; 				
					}
					
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
		super.setViewPage("/WEB-INF/passwordFind.jsp");

	}

}
