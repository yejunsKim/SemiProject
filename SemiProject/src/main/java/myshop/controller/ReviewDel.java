package myshop.controller;

import java.sql.SQLException;

import org.json.JSONObject;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;

public class ReviewDel extends BaseController {

    private ItemDAO itemDAO = null;
    
    public ReviewDel() {
        itemDAO = new ItemDAO_imple();
    }
    
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        String method = request.getMethod();
        
        if("POST".equalsIgnoreCase(method)) {
            // POST 방식
            String reviewId = request.getParameter("reviewId");
            
            System.out.println(">>> [ReviewDel] 넘어온 reviewId: " + reviewId);

            int n = 0;
            try {
                n = itemDAO.reviewDel(reviewId);
                System.out.println(">>> [ReviewDel] DAO 삭제 결과 n = " + n);
            } catch(SQLException e) {
                e.printStackTrace();
            }

            JSONObject jsobj = new JSONObject(); 
            jsobj.put("n", n);

            String json = jsobj.toString();
            request.setAttribute("json", json);

            super.setRedirect(false);
            super.setViewPage("/WEB-INF/jsonview.jsp");
            
        } else {
            // POST가 아닌 방식
            String message = "비정상적인 경로로 접근하셨습니다.";
            String loc = "javascript:history.back()";

            request.setAttribute("message", message);
            request.setAttribute("loc", loc);

            super.setViewPage("/WEB-INF/msg.jsp");
        }
    }
}