package user.controller;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import user.domain.UserVO;
import user.model.UserDAO;
import user.model.UserDAO_imple;

public class UserDetail extends BaseController {
		
	UserDAO userDAO = new UserDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 관리자(admin)일 때만 접근 가능.
		HttpSession session = request.getSession();

		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		
		if(loginUser != null && "admin".equals(loginUser.getId())) {
			
			String method =request.getMethod();
			System.out.println(method);
			
			if("POST".equalsIgnoreCase(method)) {
				String id = request.getParameter("id");
				String referer = request.getHeader("Referer");
				
				UserVO uservo = userDAO.selectUser(id);
				
				request.setAttribute("uservo", uservo);
				request.setAttribute("referer", referer);
				
				System.out.println(uservo.getAddress());

				super.setRedirect(false);
				super.setViewPage("/WEB-INF/user/admin/userDetail.jsp");
				
			}
			else {
				String message = "접근 불가능한 경로입니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
		}
		else {
			String message = "접근 불가능한 경로입니다.";
			String loc = "javascript:history.back()";

			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		
	}


}
