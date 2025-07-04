package user.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import myshop.domain.CartVO;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;
import user.domain.UserVO;
import user.model.UserDAO;
import user.model.UserDAO_imple;

public class UserUpdateAddress extends BaseController {

	private UserDAO userDAO = new UserDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String referer = request.getHeader("referer");
	//	System.out.println("~~~~ 확인용 referer : " + referer);
		
		if(referer == null) {	// referer == null 은 웹브라우저 주소창에 URL 을 직접 입력하고 들어온 경우이다.
			super.setRedirect(true);
			super.setViewPage(request.getContextPath()+"/main.do");
			return;
		}
		
		if(super.checkLogin(request)) {
		// 로그인 시, 다른 경로로 get방식인 나의 페이지에 들어올 수 없게 만듬.
			HttpSession session = request.getSession();
			UserVO loginUser = (UserVO) session.getAttribute("loginUser");
			
			System.out.println(loginUser.getId());
		
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("id", loginUser.getId());
			paraMap.put("postcode", request.getParameter("postcode"));
			paraMap.put("address", request.getParameter("address"));
			paraMap.put("addressDetail", request.getParameter("addressDetail"));
			paraMap.put("addressExtra", request.getParameter("addressExtra"));
			
			boolean isChanged = userDAO.updateAddress(paraMap);
			
			
			// 자바스크립트의 {} 로 만들어줄 JSON객체
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("isChanged",isChanged); 
			//{"isExists":true(false)} 형태 만들고,
			
			// 문자형태인 {"isExists":true(false)} 로 만들려면 toString()
			String json = jsonObj.toString(); 
			System.out.println("json 형태 >> " + json);
			  
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");		
			
			
		}
		else {
		  	 String message = "로그인이 필요합니다.";
	         String loc = "javascript:history.back()";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");
		}
	}

}
