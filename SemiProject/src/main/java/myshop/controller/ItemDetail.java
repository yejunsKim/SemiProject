package myshop.controller;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.domain.ItemVO;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;

public class ItemDetail extends BaseController {
	
	private ItemDAO idao;
	
	public ItemDetail() {
		idao = new ItemDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String referer = request.getHeader("Referer");
		
		if(referer == null) {
			super.setRedirect(true);
			super.setViewPage(request.getContextPath() + "/main.do");
			return;	// 종료
		}
		
		else {
			String s_itemno = request.getParameter("itemno");
			
			if(s_itemno != null) {
				int itemno = Integer.parseInt(s_itemno);
			
				ItemVO item = idao.selectOneItemByItemNo(itemno);
				
				if(item != null) {
					request.setAttribute("item", item);
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/shop/itemDetail.jsp");
				}
			}
			
			else {
				String message = "등록된 상품이 없습니다.";
				String loc = request.getContextPath()+"/main.do";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
		}
		
	} 

}
