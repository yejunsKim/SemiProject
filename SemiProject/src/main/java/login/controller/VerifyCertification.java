package login.controller;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class VerifyCertification extends BaseController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		if("POST".equalsIgnoreCase(method)) {
			
			String userCertificationCode = request.getParameter("userCertificationCode");
			String id = request.getParameter("id");
			
			// 세션 불러오기
			HttpSession session = request.getSession();
			String certification_code = (String) session.getAttribute("certification_code");
			
			String message = "";
			String loc = "";
			
			if (certification_code.equals(userCertificationCode)) {
				message = "인증이 성공되었습니다.";
				loc = request.getContextPath() + "/login/passwordUpdate.do?id=" + id;
			}
			
			else {
				message = "발급된 인증코드가 아닙니다. 인증코드를 다시 발급받으세요.";
				loc = request.getContextPath() + "/login/passwordFind.do";
			}
			
			request.setAttribute("id", id);
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			// !!!! 중요 !!!! //
			// !!!! 세션에 저장된 인증코드 삭제하기 !!!! //
			session.removeAttribute("certification_code");
			
		}

	}

}
