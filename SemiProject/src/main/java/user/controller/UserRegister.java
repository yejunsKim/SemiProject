package user.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import user.domain.UserVO;
import user.model.UserDAO;
import user.model.UserDAO_imple;

public class UserRegister extends BaseController {

	private UserDAO UserDAO = new UserDAO_imple();
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		System.out.println("받아온 메소드는 >>> "+method);
		
		System.out.println(request.getContextPath());
		
		if("POST".equalsIgnoreCase(method)) {
			
			String message = "";
			String loc = "";
			
			
			String name = request.getParameter("name");
			String id = request.getParameter("id");
			String password = request.getParameter("password");
			String email = request.getParameter("email");
			String mobile = request.getParameter("hp1")
						  + request.getParameter("hp2")
						  + request.getParameter("hp3");
			// 번호는 3개의 칸을 합쳐서 저장 '010'+'1234'+'5678'
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address");
			String addressDetail = request.getParameter("addressDetail");
			String addressExtra = request.getParameter("addressExtra");
			
			UserVO user = new UserVO();
			System.out.println(id+name+password);
			
			user.setName(name);
			user.setId(id);
			user.setPassword(password);
			user.setEmail(email);
			user.setMobile(mobile);
			user.setPostcode(postcode);
			user.setAddress(address);
			user.setAddressDetail(addressDetail);
			user.setAddressExtra(addressExtra);
			
			
			try {
				
				System.out.println("register 트라이 ㄱ");
				
				int n = UserDAO.registerUser(user);

				if(n == 1) {
					String ip = request.getRemoteAddr();
					System.out.println("나의 IP 주소는 : "+ ip);
					
					Map<String, String> paraMap = new HashMap<>();
					paraMap.put("id", id);
					paraMap.put("password", password);
					paraMap.put("ip", ip);
					
					UserVO loginUser = UserDAO.login(paraMap);
					
					HttpSession session = request.getSession();
					session.setAttribute("loginUser", loginUser);
					
					message = " SignUp~ ";
					loc = request.getContextPath()+"/main.do";
					
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
				message = "Failed for SignUp ";
				loc = "javascript:history.back()";
			}
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		
		}
		else {
			
			System.out.println("!! 메소드가 (GET) 이므로 페이지 이동불가 !!");
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/user/register.jsp");
			
		}
		
		
	}

}
