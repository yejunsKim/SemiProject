package login.controller;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class Logout extends BaseController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 로그아웃을 위해 먼저 세션을 불러온다.
		HttpSession session = request.getSession();
		// 그 후, 그 세션을 종료시키거나, 
		// 세션은 그대로두며 세션의 정보(객체)만 삭제하거나 선택.
		session.removeAttribute("loginUser");
		
		super.setRedirect(true);
		super.setViewPage(request.getContextPath()+"/main.do");
	}

}
