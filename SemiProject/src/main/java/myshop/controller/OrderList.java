package myshop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;
import user.domain.UserVO;

public class OrderList extends BaseController {
	
	private ItemDAO idao;
	
	public OrderList() {
		idao = new ItemDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		
		// 주문내역은 해당사용자가 로그인을 해야만 볼 수 있다.
		if(!super.checkLogin(request)) {
			
			request.setAttribute("message", "주문내역을 보려면 먼저 로그인 부터 하세요!!");
			request.setAttribute("loc", "javascript:history.back()");
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		String id = loginUser.getId();
		
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
		
		// 로그인한 유저의 주문 내역 목록 보여주기
		Map<String, String> paraMap = new HashMap();
		paraMap.put("id", id);
		paraMap.put("currentShowPageNo", currentShowPageNo);
		
		// 로그인한 유저의 주문 내역의 총 페이지수 알아오기
		int totalPage = idao.getTotalPage(id);
	/*	
		List<Order_historyVO> ohList = idao.select_order_paging(paraMap);
		
		request.setAttribute("ohList", ohList);
		
		String pageBar = "";
		
		int blockSize = 10;
		// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
		
		int loop = 1;
		// loop 는 1 부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다.
		
		// ==== !!! 다음은 pageNo 구하는 공식이다. !!! ==== // 
		int pageNo = ( (Integer.parseInt(currentShowPageNo) - 1) / blockSize) * blockSize + 1;
		// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
		
		// **** [맨처음][이전] 만들기 **** //
		// pageNo ==> 11
		pageBar += "<li class='page-item'><a class='page-link' href='orderList.do?currentShowPageNo=1&cnum=" + cnum + "'>[맨처음]</a></li>";
		
		if(pageNo != 1) {
			pageBar += "<li class='page-item'><a class='page-link' href='mallByCategory.up?currentShowPageNo=" + (pageNo - 1) + "&cnum=" + cnum + "'>[이전]</a></li>";
		}
		
		while(!(loop > blockSize || pageNo > totalPage)) {
			
			if(pageNo == Integer.parseInt(currentShowPageNo)) {
				pageBar += "<li class='page-item active'><a class='page-link' href='#'>" + pageNo + "</a></li>";
			}
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='mallByCategory.up?currentShowPageNo=" + pageNo + "&cnum=" + cnum + "'>" + pageNo + "</a></li>";
			}
			
			loop++;		// 1 2 3 4 5 6 7 8 9 10
			
			pageNo++;	// 	1  2  3  4  5  6  7  8  9 10
						// 11 12 13 14 15 16 17 18 19 20
						// 21 22 23 24 25 26 27 28 29 30
						// 31 32 33 34 35 36 37 38 39 40
						// 41 42 
			
		}// end of while(!(loop > blockSize || pageNo > totalPage))--------------------
		
		// **** [다음][마지막] 만들기 **** //
		// pageNo ==> 11
		
		if(pageNo <= totalPage) {
			pageBar += "<li class='page-item'><a class='page-link' href='mallByCategory.up?currentShowPageNo=" + pageNo + "&cnum=" + cnum + "'>[다음]</a></li>";
		}
		pageBar += "<li class='page-item'><a class='page-link' href='mallByCategory.up?currentShowPageNo=" + totalPage + "&cnum=" + cnum + "'>[마지막]</a></li>";
		
		request.setAttribute("pageBar", pageBar);
			
			
	
	*/	
	}

}
