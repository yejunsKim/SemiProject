package user.controller;

import java.sql.SQLException;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import user.domain.UserVO;
import user.model.UserDAO;
import user.model.UserDAO_imple;

public class UserEditSubmit extends BaseController {

	private UserDAO userDAO = new UserDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			String name = request.getParameter("name");
			String id = request.getParameter("id");
			String password = request.getParameter("password");
			String email = request.getParameter("email");
			String mobile = request.getParameter("hp1")
						  + request.getParameter("hp2")
						  + request.getParameter("hp3");

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
			
			try{
				int n = userDAO.updateUser(user);
				
				if(n==1) {
					
					HttpSession session = request.getSession();
					UserVO loginUser = (UserVO) session.getAttribute("loginUser");
					
					loginUser.setName(name);
					loginUser.setPassword(password);
					loginUser.setEmail(email);
					loginUser.setMobile(mobile);
					loginUser.setPostcode(postcode);
					loginUser.setAddress(address);
					loginUser.setAddressDetail(addressDetail);
					loginUser.setAddressExtra(addressExtra);
					
					String message = "회원정보를 수정하였습니다";
				   String loc = request.getContextPath()+"/main.do";
				   
				   request.setAttribute("message", message);
				   request.setAttribute("loc", loc);
				   
				   request.setAttribute("popup_close", true);
				   // 부모창 새로고침 및 팝업창 닫기를 하기 위한 용도
				   
				   super.setRedirect(false); 
				   super.setViewPage("/WEB-INF/msg.jsp");
					
				}
			}catch (SQLException e) {
				e.printStackTrace();
				   
				   super.setRedirect(true);
				   super.setViewPage(request.getContextPath()+"/error.up"); 
			}
		}
	}

}
