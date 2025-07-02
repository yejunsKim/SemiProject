package user.controller;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import user.domain.UserVO;

public class UserEdit extends BaseController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		if(super.checkLogin(request)) { //로그인 했니?
			
			String id = request.getParameter("id");
			
			HttpSession session = request.getSession();
			UserVO loginUser = (UserVO) session.getAttribute("loginUser");
			
			if(loginUser.getId().equals(id)) {
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/user/userEdit.jsp");
				
			}else{ //다른 사용자 정보수정시도
				
				String message ="다른 사용자 정보 변경은 불가합니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		}
		
		else {
			
			String message ="로그인이 필요합니다";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
		
	}

}
