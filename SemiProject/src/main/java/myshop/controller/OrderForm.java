package myshop.controller;

import java.util.Arrays;
import java.util.List;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import myshop.domain.CartVO;
import myshop.domain.ItemVO;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;
import user.domain.UserVO;

public class OrderForm extends BaseController {

	private ItemDAO idao = null;
	
	public OrderForm() {
		idao = new ItemDAO_imple();
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		 HttpSession session = request.getSession();
         UserVO loginUser = (UserVO) session.getAttribute("loginUser");
         
         String[] selectedCartNoArray = request.getParameterValues("selectedItems");
         
         System.out.println("제품 번호 리스트는 : " + Arrays.toString(selectedCartNoArray));
         System.out.println("제품 번호 1개만 : " + selectedCartNoArray[0]);

         if(selectedCartNoArray.length < 1) {
        	 System.err.println("선택자가 없음.");
        	 // 추후이전 페이지로 보내기
         } 
         
         List<ItemVO> orderItemList = idao.getOrderItem(loginUser.getId(), selectedCartNoArray);
         
         System.out.println(orderItemList.toString());
         System.out.println(loginUser.getGrade());
         
         request.setAttribute("orderItemList", orderItemList);
         
         super.setRedirect(false);
	 	 super.setViewPage("/WEB-INF/shop/orderForm.jsp");

	}
	
	
}