package common.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public abstract class BaseController implements InterCommand{
	/*
    ※ view 단 페이지(.jsp)로 이동시 forward 방법(dispatcher)으로 이동시키고자 한다라면 
       자식클래스(/webapp/WEB-INF/Command.properties 파일에 기록된 클래스명들)에서는 부모클래스에서 생성해둔 메소드 호출시 아래와 같이 하면 되게끔 한다.
     
       super.setRedirect(false); 
       super.setViewPage("/WEB-INF/index.jsp");
    
    
     ※ URL 주소를 변경하여 페이지 이동시키고자 한다라면
        즉, sendRedirect 를 하고자 한다라면    
        자식클래스에서는 부모클래스에서 생성해둔 메소드 호출시 아래와 같이 하면 되게끔 한다.
          
       super.setRedirect(true);
       super.setViewPage("registerMember.up");               
	 */
	
	private boolean isRedirect = false;
	// isRedirect 변수의 값이 false 이라면 view단 페이지(.jsp)로 forward 방법(dispatcher)으로 이동시키겠다. 
	// isRedirect 변수의 값이 true 이라면 sendRedirect 로 페이지이동을 시키겠다.
	
	private String viewPage;
	// viewPage 는 isRedirect 값이 false 이라면 view단 페이지(.jsp)의 경로명 이고,
	// isRedirect 값이 true 이라면 이동해야할 페이지 URL 주소 이다.
	
	public boolean isRedirect() { // 기본생성자만 호출해도 즉각 true/false를 꺼낼 수 있음.
	   return isRedirect;
	}
	
	public void setRedirect(boolean isRedirect) {
	   this.isRedirect = isRedirect;
	}
	
	public String getViewPage() {
	   return viewPage;
	}
	
	public void setViewPage(String viewPage) {
	   this.viewPage = viewPage;
	}
	
	
/*	//// 로그인 유무를 반환해주는 메소드
	public boolean checkLogin(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		
		if(loginUser != null) {
			return true;
		}
		else return false;
	}
*/
}
