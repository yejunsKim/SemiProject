package login.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import user.model.UserDAO;
import user.model.UserDAO_imple;

public class PasswordUpdate extends BaseController {

	private UserDAO UserDAO = new UserDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		//GET 방식이든 POST 방식이든 다들어온다
				String id = request.getParameter("id");
				
				String method = request.getMethod();
				
				// 자기 자신으로 변경된 비밀번호를 이쪽으로 보내서 "POST 방식이다"
				if( "POST".equalsIgnoreCase(method) ) {
					// 암호 변경하기 버튼을 클릭했을 경우 다시 들어온 값
					
					String new_password = request.getParameter("newPassword2");
					
					Map<String, String> paraMap = new HashMap<>();
					paraMap.put("new_password", new_password);
					paraMap.put("id", id);
					
					int result = 0;
					
					try {
						result = UserDAO.pwdUpdate(paraMap);
					} catch(SQLException e) {
						e.printStackTrace();
					}
							
					request.setAttribute("result", result); // DB에서 받아온 값이 DML에서 1이 넘어온걸 setattr로 담아서 넘길거다.
				}	
				
				request.setAttribute("id", id);
				request.setAttribute("method", method);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/login/passwordUpdate.jsp");
				
				
	}
}
