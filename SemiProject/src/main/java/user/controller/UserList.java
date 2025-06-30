package user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.controller.BaseController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import user.domain.UserVO;
import user.model.UserDAO;
import user.model.UserDAO_imple;

public class UserList extends BaseController {
	
	private UserDAO userDAO = new UserDAO_imple();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
			String sizePerPage = request.getParameter("sizePerPage");
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			
			if(sizePerPage == null || 
			  ( !"10".equals(sizePerPage) && 
				!"5".equals(sizePerPage) &&
				!"3".equals(sizePerPage))) {
				sizePerPage = "10";
			}
			
			if(currentShowPageNo == null) {
				currentShowPageNo = "1";
			}
			
			// **** 페이징 처리를 한 모든 회원 목록 또는 검색되어진 회원목록 보여주기 **** //
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("sizePerPage", sizePerPage);
			paraMap.put("currentShowPageNo", currentShowPageNo);
			
			// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 회원에 대한 총 페이지 수 알아오기 //
			int totalPage = userDAO.getTotalUser(paraMap);
			
			try {
				if(Integer.parseInt(currentShowPageNo) > totalPage || 
				   Integer.parseInt(currentShowPageNo) <= 0 ) {
					currentShowPageNo = "1";
					paraMap.put("currentShowPageNo", currentShowPageNo);
				}
			} catch(NumberFormatException e) {
				currentShowPageNo = "1";
				paraMap.put("currentShowPageNo", currentShowPageNo);
			}
			
			List<UserVO> userList = userDAO.select_User_paging(paraMap);
			
			request.setAttribute("userList", userList);
			request.setAttribute("sizePerPage", sizePerPage);
			
			// ========== 페이지바 만들기 시작 ========== //
			String pageBar = "";
			
			int blockSize = 10;
			// blockSize 는 블록(토막)당 보여지는 페이지 번호의 개수이다.
			
			int loop = 1;
			// loop 는 1 부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다.
			
			// ==== !!! 다음은 pageNo 구하는 공식이다. !!! ==== // 
			int pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
			// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
			
			// **** [맨처음][이전] 만들기 **** //
			// pageNo ==> 11
			pageBar += "<li class='page-item'><a class='page-link' href='userList.up?sizePerPage="+sizePerPage+"&currentShowPageNo=1'>[맨처음]</a></li>";
			
			if(pageNo != 1) {
				pageBar += "<li class='page-item'><a class='page-link' href='userList.up?sizePerPage="+sizePerPage+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
			}
			
			while(!(loop > blockSize || pageNo > totalPage)) {
				
				if(pageNo == Integer.parseInt(currentShowPageNo)) {
					pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>";
				}
				else {
					pageBar += "<li class='page-item'><a class='page-link' href='userList.up?sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
				}
				
				loop++;    
				
				pageNo++;  
			} // end of while(!(loop > blockSize) || (pageNo > totalPage))
			
			// **** [다음][마지막] 만들기 **** //
			
			if(pageNo <= totalPage) {
				pageBar += "<li class='page-item'><a class='page-link' href='userList.up?sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			}
			pageBar += "<li class='page-item'><a class='page-link' href='userList.up?sizePerPage="+sizePerPage+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
			
			request.setAttribute("pageBar", pageBar);
			// ========== 페이지바 만들기 끝 ========== //
			
			
			/* >>> 뷰단(userList.jsp)에서 "페이징 처리시 보여주는 순번 공식" 에서 사용하기 위해 
            검색이 있는 또는 검색이 없는 회원의 총개수 알아오기 시작 <<< */
			int totalUserCount = userDAO.getTotalUserCount(paraMap);
			
			request.setAttribute("totalMemberCount", totalUserCount);
			request.setAttribute("currentShowPageNo", currentShowPageNo);
			/* 검색이 있는 또는 검색이 없는 회원의 총개수 알아오기 끝 <<< */
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/user/admin/userList.jsp");
		}
		
	

}
