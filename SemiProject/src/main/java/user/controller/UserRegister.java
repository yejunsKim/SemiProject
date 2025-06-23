package user.controller;

import java.sql.SQLException;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import user.domain.userVO;
import user.model.userDAO;
import user.model.userDAO_imple;

public class UserRegister extends BaseController {

	private userDAO userDAO = new userDAO_imple();
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
			String detailaddress = request.getParameter("detailaddress");
			String extraaddress = request.getParameter("extraaddress");
			
			userVO user = new userVO();
			
			user.setName(name);
			user.setId(id);
			user.setPassword(password);
			user.setEmail(email);
			user.setMobile(mobile);
			user.setPostcode(postcode);
			user.setAddress(address);
			user.setDetailaddress(detailaddress);
			user.setExtraaddress(extraaddress);
			
			
			try {
				
				System.out.println("register 트라이 ㄱ");
				
				int n = userDAO.registerUser(user);

				if(n == 1) {
					
					// UserVo loginUser = userDAO.login(paraMap);
					
					message = "signup~";
					loc = request.getContextPath()+"error.jsp";
				}
				
				
			} catch (Exception e) {
				e.printStackTrace();
				
				loc = "javascript:history.back()";

			}
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		
		}
		else {
			
			System.out.println("메소드 error >> (GET)");
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/user/register.jsp");
			
		}
		
		
	}

}
