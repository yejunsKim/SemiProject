package myshop.controller;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;

public class IsOrder extends BaseController {
	
	private ItemDAO itemDAO = new ItemDAO_imple();

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String fk_itemNo = request.getParameter("fk_itemNo");
		String fk_id = request.getParameter("fk_id");
		
		System.out.println(">>> isOrder controller param: fk_itemNo=" + fk_itemNo + ", fk_id=" + fk_id);

		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("fk_itemNo", fk_itemNo);
		paraMap.put("fk_id", fk_id);
		
		boolean bool = itemDAO.isOrder(paraMap);
		System.out.println(">>> isOrder result: " + bool);

		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("isOrder", bool);
		
		String json = jsonObj.toString();
		request.setAttribute("json", json);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		

	}

}
