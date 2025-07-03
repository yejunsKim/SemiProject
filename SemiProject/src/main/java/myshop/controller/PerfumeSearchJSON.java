package myshop.controller;

import java.io.PrintWriter;
import java.util.*;
import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.domain.ItemVO;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;

public class PerfumeSearchJSON extends BaseController {

    private ItemDAO idao = new ItemDAO_imple();

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

    	  String searchID = request.getParameter("searchID");
    	    int start = Integer.parseInt(request.getParameter("start"));
    	    int len = Integer.parseInt(request.getParameter("len"));

    	    ItemDAO dao = new ItemDAO_imple();
    	    List<ItemVO> itemList = dao.searchItemsByName(searchID, start, len);

    	    JSONArray jsonArr = new JSONArray();

    	    for (ItemVO vo : itemList) {
    	        JSONObject jsonObj = new JSONObject();
    	        jsonObj.put("itemno", vo.getItemNo());
    	        jsonObj.put("itemname", vo.getItemName());
    	        jsonObj.put("itemphotopath", vo.getItemPhotoPath());
    	        jsonObj.put("price", vo.getPrice());
    	        jsonObj.put("volume", vo.getVolume());
    	        jsonArr.put(jsonObj);
    	    }

    	    String json = jsonArr.toString();
    	    response.setContentType("application/json; charset=UTF-8");
    	    PrintWriter out = response.getWriter();
    	    out.print(json);
    	    out.close();
    	
    }
}