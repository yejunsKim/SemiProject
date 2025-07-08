package myshop.controller;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import user.domain.UserVO;

public class Chart extends BaseController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		
		String referer = request.getHeader("Referer");
		
		if(referer == null || !"admin".equals(loginUser.getId())) {	
			super.setRedirect(true);
			super.setViewPage(request.getContextPath() + "/main.do");
			return;	// 종료
		}
		else {
			// === 로그인 유무 검사하기 === //
			if(!super.checkLogin(request)) {
				// 로그인 하지 않은 경우이라면
		         
				String message = "관리자만 접근이 가능합니다.";
		        String loc = "javascript:history.back()";
		         
		        request.setAttribute("message", message);
		        request.setAttribute("loc", loc);
		         
		        super.setRedirect(false);
		        super.setViewPage("/WEB-INF/msg.jsp");
			}
		      
			else { // 로그인 한 경우이라면 
		         
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/chart/chart.jsp");
			}
		}
		

	}

}
