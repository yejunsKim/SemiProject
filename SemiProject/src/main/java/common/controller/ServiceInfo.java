package common.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ServiceInfo extends BaseController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		setRedirect(false);
		setViewPage("/WEB-INF/serviceInfo.jsp");
		
	}

}
