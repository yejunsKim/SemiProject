package common.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface InterCommand {
	
	void execute(HttpServletRequest request, HttpServletResponse response) throws Exception;
	// 미완성 메소드 추상메소드 
	// 파라미터에 request 와 response가 있어야 웹 페이지 구성
	// 해당 메서드는 웹페이지 만드는 메서드이므로 각 클래스에서 오버라이딩 재정의를 무조건 해야함 강제적으로.
	// 껍데기는 같고, 알멩이는 각 다름
	
}

