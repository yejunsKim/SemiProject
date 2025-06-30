package myshop.controller;

import java.io.File;
import java.util.Calendar;
import java.util.List;

import org.json.JSONObject;

import common.controller.BaseController;
import jakarta.servlet.ServletContext;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import myshop.domain.CategoryVO;
import myshop.domain.ItemVO;
import myshop.model.ItemDAO;
import myshop.model.ItemDAO_imple;
import user.domain.UserVO;

@MultipartConfig
public class ItemRegister extends BaseController {

    private ItemDAO idao;

    public ItemRegister() {
        idao = new ItemDAO_imple();
    }

    private String extractFileName(String partHeader) {
        for(String cd : partHeader.split(";")) {
            if(cd.trim().startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf("=") + 1).trim().replace("\"", "");
                int index = fileName.lastIndexOf(File.separator);
                return fileName.substring(index + 1);
            }
        }
        return null;
    }

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");

        if (loginUser != null && "admin".equals(loginUser.getId())) {
            String method = request.getMethod();

            if (!"POST".equalsIgnoreCase(method)) {
                List<CategoryVO> categoryList = idao.getCategoryList();
                request.setAttribute("categoryList", categoryList);

                super.setRedirect(false);
                super.setViewPage("/WEB-INF/shop/admin/itemRegister.jsp");
            } 
            else {
                ServletContext svlCtx = session.getServletContext();
                String uploadFileDir = svlCtx.getRealPath("/images");

                String itemPhotoPath = null;
                String infoImg = null;

                for (Part part : request.getParts()) {
                    if(part.getHeader("Content-Disposition").contains("filename=")) {
                        String fileName = extractFileName(part.getHeader("Content-Disposition"));
                        if (part.getSize() > 0) {
                            String newFilename = fileName.substring(0, fileName.lastIndexOf("."));
                            newFilename += "_" + String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
                            newFilename += System.nanoTime();
                            newFilename += fileName.substring(fileName.lastIndexOf("."));
                            
                            part.write(uploadFileDir + File.separator + newFilename);

                            if ("itemPhotoPath".equals(part.getName())) {
                                itemPhotoPath = newFilename;
                            }
                            else if ("infoImg".equals(part.getName())) {
                                infoImg = newFilename;
                            }

                            part.delete();
                        }
                    }
                }

                // DB 등록용 데이터 받기
                String fk_catagory_no = request.getParameter("fk_catagory_no");
                String itemName = request.getParameter("itemName");
                String company = request.getParameter("company");
                String volume = request.getParameter("volume");
                String price = request.getParameter("price");
                String itemAmount = request.getParameter("itemAmount");
                String itemInfo = request.getParameter("itemInfo");

                // 방어코드
                if (fk_catagory_no == null || fk_catagory_no.trim().isEmpty()) fk_catagory_no = "0";
                if (price == null || price.trim().isEmpty()) price = "0";
                if (itemAmount == null || itemAmount.trim().isEmpty()) itemAmount = "0";
                if (volume == null || volume.trim().isEmpty()) volume = "0";

                // VO 채우기
                int itemNo = idao.getItemNo();
                ItemVO itemVO = new ItemVO();
                itemVO.setItemNo(itemNo);
                itemVO.setItemName(itemName);
                itemVO.setFk_catagory_no(Integer.parseInt(fk_catagory_no));
                itemVO.setCompany(company);
                itemVO.setItemAmount(Integer.parseInt(itemAmount));
                itemVO.setPrice(Integer.parseInt(price));
                itemVO.setVolume(Integer.parseInt(volume));
                itemVO.setItemPhotoPath(itemPhotoPath);
                itemVO.setInfoImg(infoImg);
                itemVO.setItemInfo(itemInfo);

                int n = idao.itemInsert(itemVO);

                JSONObject jsonObj = new JSONObject();
                jsonObj.put("result", n == 1 ? 1 : 0);

                request.setAttribute("json", jsonObj.toString());
                super.setRedirect(false);
                super.setViewPage("/WEB-INF/jsonview.jsp");
            }
        } 
        else {
            String message = "관리자만 접근이 가능합니다.";
            String loc = "javascript:history.back()";
            request.setAttribute("message", message);
            request.setAttribute("loc", loc);
            super.setRedirect(false);
            super.setViewPage("/WEB-INF/msg.jsp");
        }
    }
}