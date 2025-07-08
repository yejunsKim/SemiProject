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
import myshop.domain.ItemVO;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;
import user.domain.UserVO;
import user.model.UserDAO;
import user.model.UserDAO_imple;

public class OrderService extends BaseController {

	private ItemDAO itemDAO = new ItemDAO_imple();
	private UserDAO userDAO = new UserDAO_imple();
	
	// === 전표(주문코드)를 생성해주는 메소드 생성하기 === //
	private String getOrderNo() {
		
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
		
		System.out.println("s"+today+"-"+seq);
		return "s"+today+"-"+seq;
	}
	// === 주문 배송지번호를 생성해주는 메소드 생성하기 === //
	private int getDeliveryNo() {
		
		int seq = 0;
		
		try {
			seq = itemDAO.getDeliverySequence();
			// 다음 주문번호를 채번해올것!
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		System.out.println("주문배송지 번호는: "+seq);
		return seq;
	}
	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("주문 시작");
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
			

			HttpSession session = request.getSession();
			UserVO loginUser = (UserVO) session.getAttribute("loginUser"); 
		    loginUser = userDAO.selectUser(loginUser.getId());
			
			// ==== 주문테이블(tbl_order)에 insert 할 데이터 ==== 
			String orderNo = getOrderNo(); // 사실상 orderCode인 셈.
			int deliverNo = getDeliveryNo();
			String totalAmount = request.getParameter("totalAmount");
			String usePoint = request.getParameter("usePoint").replaceAll(",", "");
			String getPoint = request.getParameter("getPoint").replaceAll(",", "");
			String email = request.getParameter("email");
			
			paraMap.put("orderNo", orderNo); // 주문코드(명세서번호) s+날짜+sequence
			// getOrderNo() 메소드는 위에서 정의한 전표(주문코드)를 생성해주는 것이다. 
			paraMap.put("deliverNo", deliverNo); 
			// getDeliveryNo() 메소드로 주문배송지 번호 받아오기.
			
			paraMap.put("id", loginUser.getId()); // 회원아이디
			paraMap.put("totalAmount", totalAmount); // 주문총액
			paraMap.put("usePoint", usePoint); // 주문총포인트
			paraMap.put("getPoint", getPoint); // 주문총포인트
			paraMap.put("email", email);
			
			paraMap.put("postcode", loginUser.getPostcode()); // 우편번호와
			paraMap.put("address", loginUser.getAddress()); // 주소 삽입
			paraMap.put("addressDetail", loginUser.getAddressDetail()); 
			paraMap.put("addressExtra", loginUser.getAddressExtra()); 

			// String 삽입 끝
			
			
			// ==== 주문상세테이블(tbl_orderdetail)에 insert 할 데이터 ====
			String[] cartNoArr = request.getParameter("str_cartNo").split("\\,");
			String[] itemNoArr = request.getParameter("str_itemNo").split("\\,");
			String[] quantityArr = request.getParameter("str_quantity").split("\\,");
			int[] itemEachPriceArr =  new int[itemNoArr.length];;
			// 이 배열은 각 아이템당 판매된 당시의 가격을 가져와서 저장하기위한 용도임.
			for(int i = 0; i < itemNoArr.length; i++) {
				ItemVO itemVO = itemDAO.selectOneItemByItemNo(Integer.parseInt(itemNoArr[i]));
			    itemEachPriceArr[i] = itemVO.getPrice(); 
			}
			
			for (String str : cartNoArr) {
				System.out.println(str);
			}
			for (String str : itemNoArr) {
				System.out.println(str);
			}
			for (String str : quantityArr) {
				System.out.println(str);
			}
			paraMap.put("itemNoArr", itemNoArr);
			paraMap.put("quantityArr", quantityArr);
			paraMap.put("cartNoArr", cartNoArr);
			paraMap.put("itemEachPriceArr", itemEachPriceArr);
			// Object 삽입 끝
			
			// *** Transaction 처리를 해주는 메소드 호출하기 *** //
			int isSuccess = itemDAO.insertOrderUpdate(paraMap); 
			System.out.println(isSuccess+" 번호 나온 거 확인");
			// **** 주문이 완료되었을시 세션에 저장되어져 있는 loginuser 정보를 갱신하고
			//      이어서 주문이 완료되었다라는 email 보내주기  **** //
			if(isSuccess == 1) {
			
				// === 세션에 저장되어져 있는 loginuser 정보를 갱신하기 === 
				loginUser.setPoint(loginUser.getPoint() 
							+ Integer.parseInt(getPoint) - Integer.parseInt(usePoint));
				
		        ////////// === 주문이 완료되었다는 email 보내기 시작 === ///////////
				GoogleMail mail = new GoogleMail();
				
			//	str_pnum_join ==> 5,3,57
				
				//String str_itemNo = "'"+String.join("','",itemNoArr+"'");
			                    // {5,3,7} ==> 5','3','7 ==> '5','3','57'
				
			//	System.out.println("~~~ 확인용 주문한 제품번호 itemNo 들 : " + itemNo 들);
				// ~~~ 확인용 주문한 제품번호 itemNo 들 : '5','3','57'
				
				
			 // 주문한 제품에 대해 email 보내기시 email 내용에 넣을 주문한 제품번호들에 대한 제품정보를 얻어오는 것.
				List<ItemVO> orderitemList = itemDAO.getOrderItemList(itemNoArr);
				System.out.println("getOrderItemList 사용 완료");
                StringBuilder sb = new StringBuilder();
				
				sb.append("주문코드번호 : <span style='color: green; font-weight: bold;'>"+orderNo+"</span><br><br>"); 
				sb.append("<주문상품><br>");
				
				for(int i=0; i<orderitemList.size(); i++) {
					sb.append(orderitemList.get(i).getItemName()+"&nbsp;"+quantityArr[i]+"개&nbsp;&nbsp;");  
					sb.append("<br>");
					sb.append("<img src='http://localhost:9090//SemiProject"+orderitemList.get(i).getItemPhotoPath()+"' width='300px'/>");
					sb.append("<br>");
				}// end of for------------------------------------------
				sb.append("&nbsp;총 결제금액 : "+ totalAmount +"원");
                sb.append("<br><br> &nbsp;이용해 주셔서 감사합니다.");
				 
				String emailContents = sb.toString();
				System.out.println(sb);
				mail.sendmail_OrderFinish(email, loginUser.getName(), emailContents);
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