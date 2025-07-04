package myshop.controller;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import login.controller.GoogleMail;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;

public class OrderService extends BaseController {

private ItemDAO itemDAO = new ItemDAO_imple();
	
	
	// === 전표(주문코드)를 생성해주는 메소드 생성하기 === //
	private String getOdrcode() {
		
		// 전표(주문코드) 형식 : s+날짜+sequence ==> s20250702-1
		
		// 날짜 생성
		Date now = new Date();
		SimpleDateFormat smdatefm = new SimpleDateFormat("yyyyMMdd");
		String today = smdatefm.format(now);
		
		int seq = 0;
		
		try {
			seq = itemDAO.getOrderSequence();
			// 다음 주문번호를 채번해올것!
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return "s"+today+"-"+seq;
	}
	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			// POST 방식이라면 
			// ===== Transaction 처리하기 ===== // 
			// 1. 주문 테이블에 입력되어야할 주문전표를 채번(select)하기  
			// 2. 주문 테이블에 채번해온 주문전표, 로그인한 사용자, 현재시각을 insert 하기(수동커밋처리) 
			// 3. 주문상세 테이블에 채번해온 주문전표, 제품번호, 주문량, 주문금액을 insert 하기(수동커밋처리) 
			// 4. 제품 테이블에서 제품번호에 해당하는 잔고량을 주문량 만큼 감하기 update 하기(수동커밋처리)
						
			// 5. 장바구니 테이블에서 str_cartno_join 값에 해당하는 행들을 삭제(delete)하기(수동커밋처리)
			// >> 장바구니에서 주문을 한 것이 아니라 특정제품을 바로주문하기를 한 경우에는 장바구니 테이블에서 행들을 삭제할 작업은 없다. <<
															// case >> broze *
			// 6. 회원 테이블에서 로그인한 사용자의 point 를 usePoint 만큼 빼고, totalAmount*더하기(update)(수동커밋처리) 
			// 7. **** 모든처리가 성공되었을시 commit 하기(commit) **** 
		    // 8. **** SQL 장애 발생시 rollback 하기(rollback) ****
						
			// === Transaction 처리가 성공시 세션에 저장되어져 있는 loginuser 정보를 새로이 갱신하기 ===
			// === 주문이 완료되었을시 주문이 완료되었다라는 email 보내주기  === //
			
			Map<String, Object> paraMap = new HashMap<>();
			
			// ==== 주문테이블(tbl_order)에 insert 할 데이터 ==== 
			String odrcode = getOdrcode();
			paraMap.put("odrcode", odrcode); // 주문코드(명세서번호) s+날짜+sequence
			// getOdrcode() 메소드는 위에서 정의한 전표(주문코드)를 생성해주는 것이다. 
			
			HttpSession session = request.getSession();
			ItemVO orderedItem = (ItemVO) session.getAttribute("loginUser"); 
			
			paraMap.put("id",request.getParameter("id")); // 회원아이디
			paraMap.put("totalAmount", totalPrice); // 주문총액
			paraMap.put("usePoint", usePoint); // 주문총포인트
			
			
			// ==== 주문상세테이블(tbl_orderdetail)에 insert 할 데이터 ====
			String[] pnum_arr = str_pnum_join.split("\\,"); // 여러개 제품을 주문한 경우
			                                                // 장바구니에서 제품 1개만 주문한 경우 
			                                                // 특정제품을 바로주문하기를 한 경우
			
			String[] oqty_arr = str_oqty_join.split("\\,");
			
			String[] totalPrice_arr = str_totalPrice_join.split("\\,");
			
			paraMap.put("pnum_arr", pnum_arr);
			paraMap.put("oqty_arr", oqty_arr);
			paraMap.put("totalPrice_arr", totalPrice_arr);
			
			
			// === 장바구니테이블(tbl_cart)에 delete 할 데이터 === 
			if(str_cartno_join != null) {
				// 특정제품을 바로주문하기를 한 경우라면 str_cartno_join 의 값은 null 이 된다. 
				
				String[] cartno_arr = str_cartno_join.split("\\,");
				paraMap.put("cartno_arr", cartno_arr);
			}
			
			
			// *** Transaction 처리를 해주는 메소드 호출하기 *** //
			int isSuccess = pdao.orderAdd(paraMap); 
			
			// **** 주문이 완료되었을시 세션에 저장되어져 있는 loginuser 정보를 갱신하고
			//      이어서 주문이 완료되었다라는 email 보내주기  **** //
			if(isSuccess == 1) {
			
				// === 세션에 저장되어져 있는 loginuser 정보를 갱신하기 === 
				loginUser.setCoin(loginUser.getCoin() - Integer.parseInt(sum_totalPrice));				
				loginUser.setPoint(loginUser.getPoint() + Integer.parseInt(sum_totalPoint));
				
		        ////////// === 주문이 완료되었다는 email 보내기 시작 === ///////////
				GoogleMail mail = new GoogleMail();
				
			//	str_pnum_join ==> 5,3,57
				
				String pnumes = "'"+String.join("','", str_pnum_join.split("\\,"))+"'";
			                    // {5,3,7} ==> 5','3','7 ==> '5','3','57'
				
			//	System.out.println("~~~ 확인용 주문한 제품번호 pnumes : " + pnumes);
				// ~~~ 확인용 주문한 제품번호 pnumes : '5','3','57'
				
				
			 // 주문한 제품에 대해 email 보내기시 email 내용에 넣을 주문한 제품번호들에 대한 제품정보를 얻어오는 것.
				List<ProductVO> orderitemList = pdao.getOrderItemList(pnumes);
				
                StringBuilder sb = new StringBuilder();
				
				sb.append("주문코드번호 : <span style='color: blue; font-weight: bold;'>"+odrcode+"</span><br><br>"); 
				sb.append("<주문상품><br>");
				
				for(int i=0; i<orderitemList.size(); i++) {
					sb.append(orderitemList.get(i).getPname()+"&nbsp;"+oqty_arr[i]+"개&nbsp;&nbsp;");  
					sb.append("<img src='http://127.0.0.1:9090/MyMVC/images/"+orderitemList.get(i).getPimage1()+"' />");
					sb.append("<br>");
				}// end of for------------------------------------------
				
                sb.append("<br>이용해 주셔서 감사합니다.");
				
				String emailContents = sb.toString();
				
				mail.sendmail_OrderFinish(loginUser.getEmail(), loginUser.getName(), emailContents);
		        ////////// === 주문이 완료되었다는 email 보내기 끝 === ///////////
			
			} // end of if(isSuccess == 1)----------------------	
		
			JSONObject jsobj = new JSONObject(); // {}
			jsobj.put("isSuccess", isSuccess);  // {"isSuccess":1} 또는 {"isSuccess":0}
			
			String json = jsobj.toString();
		    request.setAttribute("json", json);
		    
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}
		
		else {
			// GET 방식이라면
			String message = "비정상적인 경로로 들어왔습니다";
			String loc = "javascript:history.back()";
				
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			  
		    super.setRedirect(false);	
		    super.setViewPage("/WEB-INF/msg.jsp");
		}
	}

}
