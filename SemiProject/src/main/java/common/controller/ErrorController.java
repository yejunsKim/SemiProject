<<<<<<< HEAD
package common.controller;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ErrorController extends BaseController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/error.jsp");
		
	}
	
}
=======
package common.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ErrorController extends BaseController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		setRedirect(false);
		setViewPage("/WEB-INF/error.jsp");
	}

}
>>>>>>> branch 'yejun12348888' of https://github.com/yejunsKim/SemiProject.git
