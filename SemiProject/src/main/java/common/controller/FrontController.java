package common.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebInitParam;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.lang.reflect.Constructor;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

/**
 * Servlet implementation class FrontController
 */
@WebServlet(
		description = "사용자가 웹에서 *.do 을 했을 경우 이 서블릿이 응답을 해주도록 한다.", 
		urlPatterns = { "*.do" }, 
		initParams = { 
				@WebInitParam(name = "PropertyConfig", value = "C:/git/SemiProject/SemiProject/src/main/webapp/WEB-INF/Command.properties",
								description = "*.do 에 대한 클래스의 매핑파일")
		})

public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Map<String, Object> cmdMap = new HashMap<>(); // command Map 을 만든것.
	
	public void init(ServletConfig config) throws ServletException {
		/*
	    웹브라우저 주소창에서  *.up 을 하면 FrontController 서블릿이 응대를 해오는데 
	    맨 처음에 자동적으로 실행되어지는 메소드가 init(ServletConfig config) 이다.
	    여기서 중요한 것은 init(ServletConfig config) 메소드는 WAS(톰캣)가 구동되어진 후
	    딱 1번만 init(ServletConfig config) 메소드가 실행되어지고, 그 이후에는 실행이 되지 않는다. 
	    그러므로 init(ServletConfig config) 메소드에는 FrontController 서블릿이 동작해야할 환경설정을 잡아주는데 사용된다.
		*/
		System.out.println("서블릿 응대를 위한 init메소드 실행 및 확인완료");
	
		FileInputStream fis = null; // 특정 파일 내용을 읽어오기 위한 객체 = fileinput의 stream.
		
		String props = config.getInitParameter("PropertyConfig");
		// props =>C:/Users/dong/eclipse-workspace/jsp/MyMVC/src/main/webapp/WEB-INF.Command.properties
		// 해당 파일의 내용을 읽어오기 위한 객체 props 이다.
		System.out.println("props =>" + props);
		System.out.println("파일 경로 존재 여부 -> " + new File(props).exists());
		String realPath = config.getServletContext().getRealPath("/WEB-INF/Command.properties");

		System.out.println("realPath: " + realPath);
	
		try {
			fis = new FileInputStream(props); 
			// 특정 파일 내용을 읽어올 인스턴스 객체에 config.getInitParameter("PropertyConfig");라는 경로 넣은것이다.
			
			Properties pr = new Properties();
			// Properties 는 Collection 중 HashMap 계열중의 하나로써
	        // "key","value"으로 이루어져 있는것이다.
	        // 그런데 중요한 것은 Properties 는 key도 String 타입이고, value도 String 타입만 가능하다는 것이다.
	        // key는 중복을 허락하지 않는다. value 값을 얻어오기 위해서는 key값 만 알면 된다. 
			
			pr.load(fis);
			/*
	           pr.load(fis); 은 fis 객체를 사용하여 C:/Users/dong/eclipse-workspace/jsp/MyMVC/src/main/webapp/WEB-INF.Command.properties 파일의 내용을 읽어다가   
	         Properties 클래스의 객체인 pr 에 로드시킨다.
	         그러면 pr 은 읽어온 파일(Command.properties)의 내용에서 
	         = 을 기준으로 왼쪽은 key로 보고, 오른쪽은 value 로 인식한다.
	       */
			Enumeration<Object> en = pr.keys();
			/*
	          pr.keys(); 은
	          C:/NCS/workspace_jsp/MyMVC/src/main/webapp/WEB-INF/Command.properties 파일의 내용물에서 
	          = 을 기준으로 왼쪽에 있는 모든 key 들만 가져오는 것이다.   
	        */
			while (en.hasMoreElements()) {
			    String key = (String) en.nextElement();
			    String className = pr.getProperty(key);

			    try {
			        className = className.trim();

			        Class<?> clz = Class.forName(className); // 클래스 로딩
			        Constructor<?> constructor = clz.getDeclaredConstructor(); // 생성자 확인
			        Object obj = constructor.newInstance(); // 객체 생성

			        cmdMap.put(key, obj);
			        System.out.println("✅ 매핑 성공: " + key + " => " + className);

			    } catch (Exception e) {
			        System.out.println("❌ 매핑 실패: " + key + " => " + className);
			        System.out.println("  원인: " + e.getClass().getSimpleName() + " - " + e.getMessage());
			    }
			}

			while(en.hasMoreElements()) {
				String key = (String) en.nextElement();
				
				System.out.println("키를 확인햐보자 => " + key);
				System.out.println("밸류를 확인햐보자 => " + pr.getProperty(key) +"\n");
				
				String className = pr.getProperty(key);
				
				if(className != null) {

					className = className.trim();
					
					Class<?> clss = Class.forName(className);
					
					Constructor<?> constrt = clss.getDeclaredConstructor();
					
					Object obj = constrt.newInstance();
				
					cmdMap.put(key, obj);
				}
				
				
			}
			
				
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			System.out.println(" >>>>> 문자열로 명명된 클래스 타입이 존재하지 않습니다 <<<<< ");
			e.printStackTrace();
		} catch (Exception e) {

		}
	}
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		System.out.println("서블릿의 doGet 실행 및 확인완료");
		
		String uri = request.getRequestURI().toString(); // string 버퍼타입인 URL을 String 타입으로 전환시켜준다.
		System.out.println(uri);
		
		String key = uri.substring(request.getContextPath().length());
		// 컨텍스트 경로는 /test1.up 이나, /test3.up 이나, //member/idDuplicateCheck.up 같은 url 경로이다.
		
		// 추상클래스로 컨트롤링 할 준비.
		BaseController action = (BaseController) cmdMap.get(key); // 객체타입을 클래스로 캐스팅해서 저장.
									// key는 개발경로 test.controller.Test1Controller 같은 object 타입 튀어나옴.
		
		if(action == null) {
			System.out.println(" >>> "+ key +" 매핑 불가능.");
		}
		
		try {
			action.execute(request, response);
			
			boolean bool = action.isRedirect();
			String viewPage = action.getViewPage();
			
			if(!bool && viewPage != null) {
				// 만약 해당 매핑 값이 있기에 true 로 저장되어져 있다면,
				// 포워딩해서 해당 값을 jsp 로 연결시켜줄 생각을 해야한다.
				RequestDispatcher dispather = request.getRequestDispatcher(viewPage);
				dispather.forward(request, response);
			}
			else if(viewPage != null)  {
				response.sendRedirect(viewPage);
			}
			
		} catch (Exception e) {
		    System.out.println("매핑 중 예외 발생: " + e.getMessage());
			e.printStackTrace();
		}
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
