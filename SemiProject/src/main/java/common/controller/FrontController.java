package common.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebInitParam;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.lang.reflect.Constructor;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

@WebServlet(
		asyncSupported = true, 
		description = "사용자가 웹에서 *.up 을 했을 경우 이 서블릿이 응답을 해주도록 한다.", 
		urlPatterns = { "*.do" }, 
		initParams = { 
				@WebInitParam(name = "propertyConfig", value = "C:/Users/user/git/SemiProject/SemiProject/src/main/webapp/WEB-INF/Command.properties", description = "*.do 에 대한 클래스의 매핑파일")
		})

public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private Map<String, Object> cmdMap = new HashMap<>(); 
	
	public void init(ServletConfig config) throws ServletException {

		/*
        웹브라우저 주소창에서  *.up 을 하면 FrontController 서블릿이 응대를 해오는데 
        맨 처음에 자동적으로 실행되어지는 메소드가 init(ServletConfig config) 이다.
        여기서 중요한 것은 init(ServletConfig config) 메소드는 WAS(톰캣)가 구동되어진 후
        딱 1번만 init(ServletConfig config) 메소드가 실행되어지고, 그 이후에는 실행이 되지 않는다. 
        그러므로 init(ServletConfig config) 메소드에는 FrontController 서블릿이 동작해야할 환경설정을 잡아주는데 사용된다.
        init = initial rise 초기화
    */
		
		// *** 확인용 ***//
		// System.out.println("~~~ 확인용 => 서블릿 Froncontroller의 init(serveltConfig config)메소드가 실행됨" );
		// ~~~ 확인용 => 서블릿 Froncontroller의 init(serveltConfig config)메소드가 실행됨

		FileInputStream fis = null;
		// 목적은 command properties등 특정 파일에 있는 내용을 읽어오기 위한 용도
				
		// webservlet에 있는 properyConfig 를 가져온다. 그러면 벨류값인 C:/NCS/workspace_jsp/myMVC/src/main/webapp/WEB-INF/Command.properties이 쭉 나온
		String props = config.getInitParameter("propertyConfig");
		// System.out.println("확인용 properties =>" + properties);
		// 확인용 properties => C:/NCS/workspace_jsp/myMVC/src/main/webapp/WEB-INF/Command.properties
		
		try {
			fis = new FileInputStream(props);
			// fis는 C:/NCS/workspace_jsp/myMVC/src/main/webapp/WEB-INF/Command.properties 파일의 내용을 읽어오기 위한 용도로 쓰이는 객체이다.
			
			Properties pr = new Properties();
			// Properties 는 Collection 중 HashMap 계열중의 하나로써
	        // "key","value"으로 이루어져 있는것이다.
	        // 그런데 중요한 것은 Properties 는 key도 String 타입이고, value도 String 타입만 가능하다는 것이다.
	        // key는 중복을 허락하지 않는다. value 값을 얻어오기 위해서는 key값 만 알면 된다. 
			
			pr.load(fis);
			/*
	         pr.load(fis); 은 fis 객체를 사용하여 C:/NCS/workspace_jsp/MyMVC/src/main/webapp/WEB-INF/Command.properties 파일의 내용을 읽어다가   
	         Properties 클래스의 객체인 pr 에 로드시킨다.
	         그러면 pr 은 읽어온 파일(Command.properties)의 내용에서 
	         = 을 기준으로 왼쪽은 key로 보고, 오른쪽은 value 로 인식한다.
	         
	         # Test Mapping Information
			/test1.up=test.controller.Test1Controller
			/test/test2.up=test.controller.Test2Controller
			/\test3.up=test.controller.Test3Controller 이걸 가져오는것
			 */
			
			Enumeration<Object> en = pr.keys(); // /test1.up, /test/test2.up 등 키 가져오는것
			/*
	          pr.keys(); 은
	          C:/NCS/workspace_jsp/MyMVC/src/main/webapp/WEB-INF/Command.properties 
	          파일의 내용물에서 = 을 기준으로 왼쪽에 있는 모든 key 들만 가져오는 것이다.   
	        */
			
			while(en.hasMoreElements()) { // 리턴타입 불린
				
				String key = (String) en.nextElement(); 
				// nextElement로 있으면 가져온다.앞에 (String)으로 형변환
				
				// System.out.println("확인용 Key =>" + key);
				// System.out.println("### 확인용 value =>" + pr.getProperty(key) + "\n");
				
				/* 순서는 저장된 대로 나오는게 아니다.
				확인용 Key =>/test/test2.up
				### 확인용 value =>test.controller.Test2Controller

				확인용 Key =>/test3.up
				### 확인용 value =>test.controller.Test3Controller

				확인용 Key =>/test1.up
				### 확인용 value =>test.controller.Test1Controller
				*/
				
				String className = pr.getProperty(key);
				
				if (className != null) {
					
					className = className.trim();
					
					// 클래스화 시켜서 객체로 만들 수 있다.
					Class<?> cls = Class.forName(className); // <?> 는 아무거나 이고 설계도를 만들어서 객체 만들 수 있음
					
					// <?> 은 generic 인데 어떤 클래스 타입인지는 모르지만 하여튼 클래스 타입이 들어온다는 뜻이다.
		            // String 타입으로 되어진 className 을 클래스화 시켜주는 것이다.
		            // 주의할 점은 실제로 String 으로 되어져 있는 문자열이 클래스로 존재해야만 한다는 것이다.
					
					Constructor<?> constrt = cls.getDeclaredConstructor();
					// constrt 생성자 만들기
					
					Object obj = constrt.newInstance(); //newInstance가 객체만들기
					// 생성자로부터 실제 객체(인스턴스)를 생성해주는 것이다.
					
					/*
					@@@ 확인용 Test2Controller 클래스의 기본생성자 호출함 @@@
					$$$$ 확인용 Test3Controller 클래스의 기본생성자 호출함 $$$
					### 확인용 Test1Controller 클래스의 기본생성자 호출함
					만약,Test4Controller를 command 에 추가했을 떄, 클래스를 안 만들면 
					null pointer 오류떨어짐
					*/
					
					cmdMap.put(key,obj);
					
				} //end of if (className != null)
				
			} // end of while(en.hasMoreElements()) ===========================
			
		} catch (FileNotFoundException e) {

			e.printStackTrace();
			
		} catch (IOException e) {

			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			System.out.println(">> 문자열로 명명되어진 클래스가 존재하지 않습니다.");
			// >>> /asdasdasdsad/asdasdadasdas.up은 uri 패턴에 매핑된 클래스는 존재하지 않습니다. <<<
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// System.out.println("### 확인용 => 서블릿 Froncontroller의 doGet 메소드가 실행됨" );
		
		// 웹 브라우저의 주소 입력창에서 
		// http://localhost:9090/myMVC/member/idDuplicateCheck.up?userid=leess 아 같이
		// 입력되었더라면 url을 읽어와야한다. 
		// request.getRequestURL() 는 리턴타입이 String builder 또는 buffer 다 
		// String url = request.getRequestURL().toString();
		// System.out.println("확인용 URL =>" + url);
		// 확인용 URL =>http://localhost:9090/myMVC/member/idDuplicateCheck.up
		
		// 웹 브라우저의 주소 입력창에서 
		// http://localhost:9090/myMVC/member/idDuplicateCheck.up?userid=leess 아 같이
		// 입력되었더라면 url을 읽어와야한다. 
		String uri = request.getRequestURI();
		System.out.println(" === 확인용 URi =>" + uri);
		// request.getRequestURI();는 리턴타입이 String이다.
		// === 확인용 URi =>/myMVC/member/idDuplicateCheck.up 
		// URI는 port번호빼고 ctxPath만 나온다.
		// === 확인용 URi =>/myMVC/test1.up
		// === 확인용 URi =>/myMVC/test/test2.up
		// === 확인용 URi =>/myMVC/test3.up
		// key가 /test1.up , /test/test2.up, /test3.up 
		// /member/idDuplicateCheck.up 이거니까 substr으로 추출해야 함.
		// /myMVC/가 contextPath의 길이 6이다.
		String key = uri.substring(request.getContextPath().length() );
		
		BaseController action = (BaseController) cmdMap.get(key);
		// 값이 각 test1.up ,test2.up의 클래스가 나오는데 결국엔 부모클래스가 Abstract라서 형변환해야함.
		// 질문: 왜 부모클래스를 미안성 메소드로 잡고 하는거냐
		// A : 부모클래스를 사용하면 object라서 직접 참조를 못홤. 그래서, 일부러 미완성메소드로 각 클래스로 쓸 수 있게 한거임
		
		if(action == null) {
			System.out.println(">>> "  + key + "은 uri 패턴에 매핑된 클래스는 존재하지 않습니다. <<<");
		}
		
		else {
			
			try {
				action.execute(request, response);
				// ### 확인용 Test1Controller 클래스의 웹페이지 만들기
				// @@@ 확인용 Test2Controller 클래스의 웹페이지 만들기 @@@
				// === 확인용 IdDuplicateCheck 클래스의 웹페이지 만들기 ===
				boolean bool = action.isRedirect(); // true false 여부 가져오기
				String viewPage = action.getViewPage(); // 페이지 링크 가져오기
				
				if(!bool) { // false 라면
					// viewPage 에 명기된 view단 페이지로 forward(dispatcher)를 하겠다는 말이다.
		            // forward 되어지면 웹브라우저의 URL주소 변경되지 않고 그대로 이면서 
					// 화면에 보여지는 내용은 forward 되어지는 jsp 파일이다.
		            // 또한 forward 방식은 forward 되어지는 페이지로 데이터를 전달할 수 있다는 것이다.
					if(viewPage != null) {
						RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
						dispatcher.forward(request, response);
					} // end of if(viewPage != null) {
					
				} // end of if(!bool) ============= 
				
				else {
				// viewPage 에 명기된 주소로 sendRedirect(웹브라우저의 URL주소 변경됨)를 하겠다는 말이다.
		        // 즉, 단순히 페이지이동을 하겠다는 말이다. 
		        // 암기할 내용은 sendRedirect 방식은 sendRedirect 되어지는 페이지로 데이터를 전달할 수가 없다는 것이다.
					if(viewPage != null) {
						response.sendRedirect(viewPage);
					}
					
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
				
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
