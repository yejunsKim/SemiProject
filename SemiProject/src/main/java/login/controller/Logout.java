package login.controller;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import user.domain.UserVO;

public class Logout extends BaseController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 로그아웃 처리하기
		HttpSession session = request.getSession(); // 세션불러오기
		
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		String login_userid = loginUser.getId();
		
		super.setRedirect(true);
		
		String referer = request.getHeader("referer");
		
		if(!"admin".equals(login_userid) && referer != null ) {
			
			if(referer.contains("cartList.do") || 
			   referer.contains("chart.do") ||
			   referer.contains("orderList.do") ||
			   referer.contains("orderDetail.do")) {
				// 관리자가 아닌 일반 사용자로 들어와서 referer 페이지가 개인정보를 나타내는 것이라면 main 페이지로 돌아간다.   
				super.setViewPage(request.getContextPath()+"/main.do");
			}
			else {
				// 관리자가 아닌 일반 사용자로 들어와서 referer 페이지가 개인정보를 나타내는 것이 아니라면 referer 페이지로 돌아간다.
				super.setViewPage(referer);
			}
						
		}
		else {
			// referer 페이지가 없거나 또는 관리자로 로그아웃을 하면 무조건 main 페이지로 돌아간다.   
			super.setViewPage(request.getContextPath()+"/main.do");
		}
		
		session.invalidate();
		
	}

}
