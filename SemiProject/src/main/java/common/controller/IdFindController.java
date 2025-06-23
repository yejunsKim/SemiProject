package common.controller;

import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.model.ProductDAO;
import myshop.model.ProductDAO_imple;

public class IdFindController extends BaseController {

	private ProductDAO pdao;
	
	public IdFindController() {
		pdao = new ProductDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String name = request.getParameter("name");
		String mobile = request.getParameter("mobile");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("name", name);
		paraMap.put("mobile", mobile);
		
		String userid = pdao.idFind(paraMap);
		
		if(userid != null) {
			
			request.setAttribute("userid", userid);
			System.out.println("userid" + userid);
		}
		
		else {
			
			setRedirect(false);
			setViewPage("WEB-INF/error.jsp");
		}
		
		
		request.setAttribute("name",name); // 폼태그에서 입력한 name값을 넘겨주겠다. 
		request.setAttribute("mobile",mobile); // 폼태그에서 입력한 email값을 넘겨주겠다. 
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/idFind.jsp");
	}

}
