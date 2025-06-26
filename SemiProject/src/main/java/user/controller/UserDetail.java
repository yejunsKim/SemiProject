package user.controller;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import user.domain.UserVO;
import user.model.UserDAO;
import user.model.UserDAO_imple;

public class UserDetail extends BaseController {

	private UserDAO UserDAO = new UserDAO_imple();
	
	public UserDetail() {
		UserDAO = new UserDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
		
		if(loginuser != null && "admin".equals(loginuser.getId())) {
			
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) {
				
				String id = request.getParameter("id");
				
				String referer = request.getHeader("Referer");
				
				if(referer == null) {
					
					referer="http://localhost:8080/SemiProject/main.do";
				}
				
				UserVO userVO = UserDAO.selectOneUser(id);
				
				request.setAttribute("userVO", userVO);
				request.setAttribute("referer", referer);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/user/admin/userDetail.jsp");
				
			} else {
				// 로그인 x 이거나 관리자 아닐 때
				String message = "관리자만 접근이 가능합니다";
				String loc = "javascript:history.back()";
							
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
							
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		} //end of if(loginuser != null && "admin".equals(loginuser.getId()))
		
	}//end of 	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception 
}
