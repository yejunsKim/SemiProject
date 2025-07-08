package myshop.controller;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;
import user.domain.UserVO;

public class OrderAdd extends BaseController {

	private ItemDAO idao = null;
	
	public OrderAdd() {
		idao = new ItemDAO_imple();
	}
	
		private String getOdrcode() {
			
			// 전표(주문코드) 형식 : s+날짜+sequence ==> s20250702-1
			
			// 날짜 생성
			Date now = new Date();
			SimpleDateFormat smdatefm = new SimpleDateFormat("yyyyMMdd");
			String today = smdatefm.format(now);
			
			int seq = 0;
			
			try {
				seq = idao.get_order_seq();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			return "s"+today+"-"+seq;
		}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		 HttpSession session = request.getSession();
         UserVO loginUser = (UserVO) session.getAttribute("loginUser");
         
 		String odrcode = getOdrcode();
         String id = loginUser.getId();
         String cartnoArr = request.getParameter("cartno");
         String oqtyArr = request.getParameter("oqty");
         String[] totalPointArr = request.getParameterValues("totalPoint");

         
         int sumPrice = 0;
         for(String point : totalPointArr) {
             sumPrice += Integer.parseInt(point);
         }
         int sumPoint = (int)(sumPrice * 0.05);
         
         
		Map<String, Object> paraMap = new HashMap<>();
		
	    paraMap.put("odrcode", odrcode);
	    paraMap.put("id", id);
	    paraMap.put("cartnoArr", cartnoArr);
	    paraMap.put("oqtyArr", oqtyArr);
	    paraMap.put("sumPrice", String.valueOf(sumPrice));
	    paraMap.put("sumPoint", String.valueOf(sumPoint));
	    
	    
		 // 트랜잭션으로 주문 insert & 재고감소 & 장바구니삭제 & 포인트적립
        int n = idao.insertOrderUpdate(paraMap);

        if(n == 1) {
        	loginUser.setPoint( loginUser.getPoint() + sumPoint );
            request.setAttribute("orderCode", odrcode);
            request.setAttribute("rewardPoint", sumPoint);
            
            
            super.setRedirect(false);
            super.setViewPage("/WEB-INF/shop/orderSuccess.jsp");
            
        } else {
            request.setAttribute("message", "주문 처리에 실패했습니다.");
            request.setAttribute("loc", "javascript:history.back()");
            super.setRedirect(false);
            super.setViewPage("/WEB-INF/msg.jsp");
        }
         
		
	}

}