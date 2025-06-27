package login.controller;

import java.util.HashMap;
import java.util.Map;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import user.model.UserDAO;
import user.model.UserDAO_imple;

public class IdFind extends BaseController {

	private UserDAO UserDAO;
	
	public IdFind() {
		UserDAO = new UserDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			// 아이디 찾기 modal에서 "찾기" 버튼을 클릭했을 경우

			String name = request.getParameter("name");
			String email = request.getParameter("email");
			
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("name", name);
			paraMap.put("email", email); // email이 후보식별자가 된다.
			
			String id = UserDAO.findUserid(paraMap); // 위에 mdao를 가져와서 Map으로 보내야한다.
			// 리턴값은 아이디값을 찾기위해서 String으로 찾아야한다.
			
			if(id != null) { // db에서 넘어온 값을 아까 찾기 화면으로 값들을 넘겨줘야한다.
				request.setAttribute("id", id); 
			}
		
			else {
				request.setAttribute("id", "존재하지 않습니다."); 
			}
			
			request.setAttribute("name",name); // 폼태그에서 입력한 name값을 넘겨주겠다. 
			request.setAttribute("email",email); // 폼태그에서 입력한 email값을 넘겨주겠다. 
			
		} // end of if("POST".equalsIgnoreCase(method)) { 

		request.setAttribute("method",method); 
		// 아이디찾기에서 get 일때 안보이고, post로 아이디 찾을때 나오도록 해야해서 넘겨줘야 한다.
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/login/idFind.jsp");
	}

}
