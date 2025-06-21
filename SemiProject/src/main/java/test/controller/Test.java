package test.controller;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class Test extends BaseController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/register.jsp");
		//super.setViewPage("/WEB-INF/error.jsp");

	}

}
  