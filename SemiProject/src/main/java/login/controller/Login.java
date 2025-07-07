package login.controller;

import java.util.HashMap;
import java.util.Map;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import user.domain.UserVO;
import user.model.UserDAO;
import user.model.UserDAO_imple;

public class Login extends BaseController {

	private UserDAO userDAO = new UserDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			String id = request.getParameter("id");
			String password = request.getParameter("password");
			String ip = request.getRemoteAddr();
			// clientiP 로 로그인 history 에 접근 및 기록.
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("id", id);
			paraMap.put("password", password);
			paraMap.put("ip", ip);
			
			System.out.println(id+" == ID와\n비번 == "+password);
			System.out.println(ip);
			
			UserVO loginUser = userDAO.login(paraMap);
			
			if(loginUser != null) {
				// 로그인된 유저가 들어왔다면, 세션을 남기고 리다이렉트 해야함.
				HttpSession session = request.getSession();
				session.setAttribute("loginUser", loginUser);
				
				System.out.println(loginUser.getPoint());
				System.out.println(loginUser.getGrade());

				super.setRedirect(true);
				super.setViewPage(request.getContextPath()+"/main.do");
				
			}
			else {
				System.out.println("로그인에 실패하였습니다.");
				
				String message = "로그인 실패";
				String loc = "javascript:history.back()";
				
		        request.setAttribute("message", message);
		        request.setAttribute("loc", loc);
		         
		        super.setRedirect(false);
		        super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		}
		else { // 메소드가 get 으로 요청되었다면, post로 폼을 받지 못한 경우임.
			
			String message = "비정상적인 경로입니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			setRedirect(false);
			setViewPage("/WEB-INF/msg.jsp");
		}
		
		
	}

}
