package myshop.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import myshop.domain.CartVO;
import myshop.domain.CategoryVO;
import myshop.domain.ItemVO;
import myshop.domain.Order_historyVO;
import myshop.domain.Order_itemsVO;


public class ItemDAO_imple implements ItemDAO {
	
	private DataSource ds;  // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다. 
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자
	public ItemDAO_imple() {
		
		try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/semiproject");
			
		} catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	
	// 사용한 자원을 반납하는 close() 메소드 생성하기
	private void close() {
		try {
			if(rs    != null) {rs.close();     rs=null;}
			if(pstmt != null) {pstmt.close(); pstmt=null;}
			if(conn  != null) {conn.close();  conn=null;}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}// end of private void close()---------------
	
	// 메인페이지에 보여지는 카테고리(이미지파일경로)을 조회(select)하는 메소드
		@Override
		public List<CategoryVO> imageSelectAll() throws SQLException {
			
			List<CategoryVO> categoryList = new ArrayList<>();
			
			try {
				
				  conn = ds.getConnection();
				 
				  String sql = " select categoryno, categoryname, categoryimagepath "
				  		     + " from category "
				  		     + " order by categoryno asc ";
				  
				  pstmt = conn.prepareStatement(sql);
				  rs = pstmt.executeQuery();
			
				  
			 while(rs.next()) {
					  
					  CategoryVO cvo = new CategoryVO();
					    cvo.setCategoryNo(rs.getInt("categoryNo")); 
					    cvo.setCategoryName(rs.getString("categoryName"));
					    cvo.setCategoryImagePath(rs.getString("categoryImagePath"));

					    categoryList.add(cvo); 
					    
				  }// end of while------------------
				  
			} finally {
				close();
			}
			
			return categoryList;
			
		}// end of public List<ImageVO> imageSelectAll() throws SQLException--------


	
	// 상품의 전체 개수를 알아온다.
	@Override
	public int totalCount() throws SQLException {
		
		int totalCount = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select count(*) "
					   + " from item ";
		//			   + " where fk_category_no = ? ";
			
			pstmt = conn.prepareStatement(sql);
		//	pstmt.setInt(1, i);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalCount = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return totalCount;
	}
	
	
	// 더보기 방식(페이징처리)으로 상품정보를 8개씩 잘라서(start ~ end) 조회해오기 
	@Override
	public List<ItemVO> selectBycategoryName(Map<String, String> paraMap) throws SQLException {
		
		List<ItemVO> itemList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " SELECT itemno, itemName, itemphotopath, itemInfo, price, itemamount, volume, company, infoimg, categoryname "
					   + " FROM item I "
					   + " JOIN category C "
					   + " ON I.fk_category_no = C.categoryno "
			//		   + " WHERE categoryname = ? "
					   + " ORDER BY itemno DESC "
					   + " OFFSET (?-1) * ? ROW "
					   + " FETCH NEXT ? ROW ONLY " ;
			
			pstmt = conn.prepareStatement(sql);
			
			int start = Integer.parseInt(paraMap.get("start"));
			int end = Integer.parseInt(paraMap.get("end"));
			
			int PAGE_NO = end/(end - start + 1);
			int PAGE_SIZE = end - start + 1;
			
		//	pstmt.setString(1, paraMap.get("categoryName"));
			pstmt.setInt(1,PAGE_NO);
			pstmt.setInt(2,PAGE_SIZE);
			pstmt.setInt(3,PAGE_SIZE);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ItemVO ivo = new ItemVO();
				
				ivo.setItemNo(rs.getInt("itemno"));
				ivo.setItemName(rs.getString("itemName"));
				ivo.setItemPhotoPath(rs.getString("itemphotopath"));
				ivo.setItemInfo(rs.getString("itemInfo"));
				ivo.setPrice(rs.getInt("price"));
				ivo.setItemAmount(rs.getInt("itemamount"));
				ivo.setVolume(rs.getInt("volume"));
				ivo.setCompany(rs.getString("company"));
				ivo.setInfoImg(rs.getString("infoimg"));
				
				CategoryVO categvo = new CategoryVO();
				categvo.setCategoryName(rs.getString("categoryname"));
				ivo.setCategvo(categvo);
				
				itemList.add(ivo);
			}// end of while(rs.next())------------------------------------
			
			
		} finally {
			close();
		}
		
		return itemList;
	}
	
	
	// 카테고리별 상품의 전체 개수를 알아온다.
	@Override
	public int totalCount(String categoryNo) throws SQLException {
		
		int totalCount = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select count(*) "
					   + " from item "
					   + " where fk_category_no = to_number(?) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, categoryNo);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalCount = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return totalCount;
	}
	
	
	// 해당 카테고리번호에 맞는 카테고리명 가져오기
	@Override
	public String getCategoryName(String categoryNo) throws SQLException {
		
		try {
			conn = ds.getConnection();
			
			String sql = " select categoryName "
					   + " from category "
					   + " where categoryNo = to_number(?) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, categoryNo);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			categoryNo = rs.getString(1);
			
		} finally {
			close();
		}
		
		return categoryNo;
	}
	
	
	// 카테고리별 더보기 방식(페이징처리)으로 상품정보를 8개씩 잘라서(start ~ end) 조회해오기
	@Override
	public List<ItemVO> selectBycategoryName2(Map<String, String> paraMap) throws SQLException {
		
		List<ItemVO> itemList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " SELECT itemno, itemName, itemphotopath, itemInfo, price, itemamount, volume, company, infoimg, categoryname "
					   + " FROM item I "
					   + " JOIN category C "
					   + " ON I.fk_category_no = C.categoryno "
					   + " WHERE categoryName = ? "
					   + " ORDER BY itemno DESC "
					   + " OFFSET (?-1) * ? ROW "
					   + " FETCH NEXT ? ROW ONLY " ;
			
			pstmt = conn.prepareStatement(sql);
			
			int start = Integer.parseInt(paraMap.get("start"));
			int end = Integer.parseInt(paraMap.get("end"));
			
			int PAGE_NO = end/(end - start + 1);
			int PAGE_SIZE = end - start + 1;
			
			pstmt.setString(1, paraMap.get("categoryName"));
			pstmt.setInt(2,PAGE_NO);
			pstmt.setInt(3,PAGE_SIZE);
			pstmt.setInt(4,PAGE_SIZE);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ItemVO ivo = new ItemVO();
				
				ivo.setItemNo(rs.getInt("itemno"));
				ivo.setItemName(rs.getString("itemName"));
				ivo.setItemPhotoPath(rs.getString("itemphotopath"));
				ivo.setItemInfo(rs.getString("itemInfo"));
				ivo.setPrice(rs.getInt("price"));
				ivo.setItemAmount(rs.getInt("itemamount"));
				ivo.setVolume(rs.getInt("volume"));
				ivo.setCompany(rs.getString("company"));
				ivo.setInfoImg(rs.getString("infoimg"));
				
				CategoryVO categvo = new CategoryVO();
				categvo.setCategoryName(rs.getString("categoryname"));
				ivo.setCategvo(categvo);
				
				itemList.add(ivo);
			}// end of while(rs.next())------------------------------------
			
			
		} finally {
			close();
		}
		
		return itemList;
	}
	
	
	// 제품 1개 상세 정보 가져오기
	@Override
	public ItemVO selectOneItemByItemNo(int itemno) throws SQLException {
		ItemVO item = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " SELECT itemno, itemname, itemphotopath, price, volume, itemInfo, infoimg, itemamount "
					   + " FROM item "
					   + " WHERE itemno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, itemno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				item = new ItemVO();
				item.setItemNo(rs.getInt("itemNo"));
				item.setItemName(rs.getString("itemName"));
				item.setItemPhotoPath(rs.getString("itemPhotoPath"));
				item.setPrice(rs.getInt("price"));
				item.setVolume(rs.getInt("volume"));
				item.setItemInfo(rs.getString("itemInfo"));
				item.setInfoImg(rs.getString("infoImg"));
				item.setItemAmount(rs.getInt("itemAmount"));
			}
			
		} finally {
			close();
		}
		
		return item;
		
	} // end of public ItemVO selectOneItemByItemNo(int itemNo) throws SQLException
	
	
	// 장바구니 담기 
	@Override
	public int insertCartOne(Map<String, String> paraMap) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " SELECT cartno "
					   + " FROM cart "
					   + " WHERE fk_users_id = ? AND fk_item_no = to_number(?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("fk_users_id"));
			pstmt.setString(2, paraMap.get("fk_item_no"));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {	// 장바구니에 이미 같은 제품이 존재하는 경우
				
				sql = " UPDATE cart set cartamount = cartamount + to_number(?) "
					+ " WHERE cartno = ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, paraMap.get("cartamount"));	// 제품 수량 추가 증가가 아닌 선택한 수량이 들어가게 끔 sql문 작성함.
				pstmt.setInt(2, rs.getInt("cartno"));
				
				n = pstmt.executeUpdate();
			}
			
			else {	// 장바구니에 제품을 새로 추가하는 경우
				
				sql = " INSERT INTO cart(cartno, fk_users_id, fk_item_no, cartamount, cartdate) "
					+ " VALUES(CART_SEQ.nextval, ?, to_number(?), to_number(?), sysdate) ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, paraMap.get("fk_users_id"));
				pstmt.setString(2, paraMap.get("fk_item_no"));
				pstmt.setString(3, paraMap.get("cartamount"));
				
				n = pstmt.executeUpdate();
			}
			
		} finally {
			close();
		}
		
		return n;
	}// end of public int insertCartOne(Map<String, String> paraMap) throws SQLException------------------
	
	
	// 장바구니 목록 가져오기(select)
	@Override
	public List<CartVO> selectItemCart(String fk_users_id) throws SQLException {
		
		List<CartVO> cartList = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " SELECT C.cartno, I.itemPhotoPath, I.itemName, I.price, I.itemAmount, C.cartamount, "
					   + " TO_CHAR(C.cartdate, 'yyyy-mm-dd') AS cartdate, U.grade "
					   + " FROM cart C "
					   + " JOIN users U ON C.fk_users_id = U.id "
					   + " JOIN item I ON C.fk_item_no = I.itemNo "
					   + " WHERE fk_users_id = ? "
					   + " ORDER BY C.cartno DESC ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, fk_users_id);
			
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt == 1) {
					cartList = new ArrayList<>();
				}
				
				ItemVO ivo = new ItemVO();
				ivo.setItemPhotoPath(rs.getString("itemPhotoPath"));
				ivo.setItemName(rs.getString("itemName"));
				ivo.setPrice(rs.getInt("price"));
				ivo.setItemAmount(rs.getInt("itemAmount"));
				
				// 등급에 따른 포인트 계산
				ivo.setUserItemPoint(rs.getString("grade"));
				
				
				CartVO cvo = new CartVO();
				cvo.setCartno(rs.getInt("cartno"));
				cvo.setCartamount(rs.getInt("cartamount"));
				cvo.setCartdate(rs.getString("cartdate")); // TO_CHAR 했으므로 String으로 받기
				
				cvo.setIvo(ivo);
				
				cartList.add(cvo);
			}// end of while(rs.next())----------------------
			
		} finally {
			close();
		}
		
		return cartList;
	}// end of public List<CartVO> selectItemCart(String fk_users_id) throws SQLException-------------------

	
	//카테고리 조회
	@Override
	public List<CategoryVO> getCategoryList() throws SQLException {
		List<CategoryVO> categoryList = new ArrayList<>();
		 
		try {
			conn = ds.getConnection();
			
			String sql = " select categoryNo, categoryName, categoryImagePath  "
					   + " from category ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CategoryVO cvo = new CategoryVO();
				cvo.setCategoryNo(rs.getInt("categoryNo"));
				cvo.setCategoryName(rs.getString("categoryName"));
				cvo.setCategoryImagePath(rs.getString("categoryImagePath"));
				
				
				categoryList.add(cvo);
			}
			
			
		} finally {
			close();
		}
	 
	return categoryList;
	}//end of 	public List<CategoryVO> getCategoryList() throws SQLException 

	//제품번호 채번하기
	@Override
	public int getItemNo() throws SQLException {

		int itemNo =0;
		
		try{
			conn=ds.getConnection();
			
			String sql = " select item_seq.nextval As itemNo "
					+ " from dual ";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			rs.next();
			
			itemNo = rs.getInt("itemNo");
			
		}finally {
			close();
		}
		
		return itemNo;
	}//end of 제품번호 채번하기

	
	//제품정보 insert하기(제품등록)
	@Override
	public int itemInsert(ItemVO itemVO) throws SQLException {
		int result = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	        
	         
	         String sql = " insert into item(itemNo, itemName, fk_category_no,"
	         		+ " company, itemPhotoPath, infoImg , itemInfo, itemAmount, price, volume) "
	         	    + " values(?,?,?,?,?,?,?,?,?,?) ";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setInt(1, itemVO.getItemNo());
	         pstmt.setString(2, itemVO.getItemName());
	         pstmt.setInt(3, itemVO.getFk_catagory_no());    
	         pstmt.setString(4, itemVO.getCompany()); 
	         pstmt.setString(5, itemVO.getItemPhotoPath());    
	         pstmt.setString(6, itemVO.getInfoImg()); 
	         pstmt.setString(7, itemVO.getItemInfo()); 
	         pstmt.setInt(8, itemVO.getItemAmount());
	         pstmt.setInt(9, itemVO.getPrice());
	         pstmt.setInt(10, itemVO.getVolume());
	         
	         result = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return result;
	}
	
	
	// 장바구니에서 특정 제품 삭제하기
	@Override
	public int cartDelete(String cartno) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " DELETE FROM cart "
					   + " WHERE cartno = to_number(?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, cartno);
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;
	}// end of public int cartDelete(String cartno) throws SQLException--------------------------
	
	
	// 장바구니 테이블에서 선택 제품의 주문량 변경시키기
	@Override
	public int amountUpdate(Map<String, String> paraMap) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " UPDATE cart SET cartamount = to_number(?) "
					   + " WHERE cartno = to_number(?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("cartamount"));
			pstmt.setString(2, paraMap.get("cartno"));
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;
	}
	
	
	// 장바구니 모두 비우기
	@Override
	public int cartAllDelete(String id) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " DELETE FROM cart "
					   + " WHERE fk_users_id = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;
	}
	
	
	// 30일 지난 장바구니 항목 먼저 삭제
	@Override
	public void deleteOldCart(String fk_users_id) throws SQLException {
		
		try {
			conn = ds.getConnection();
			
			String sql = " delete from cart "
					   + " where fk_users_id = ? "
					   + " and cartdate < sysdate - 30 ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_users_id);
			
			pstmt.executeUpdate();
			
		} finally {
			close();
		}
	}// end of public void deleteOldCart(String fk_users_id) throws SQLException-------------------

	
	// 로그인 유저의 장바구니 조회.	
	@Override
	public List<ItemVO> getOrderItem(String id, String[] selectedCartNoArray) throws SQLException {

	    List<ItemVO> getOrderItemList = new ArrayList<>();

	    if(selectedCartNoArray == null || selectedCartNoArray.length == 0) {
	        return getOrderItemList;
	    }

	    try {
	        conn = ds.getConnection();

	        StringBuilder placeholders = new StringBuilder();
	        for (int i = 0; i < selectedCartNoArray.length; i++) {
	            placeholders.append("?");
	            if (i < selectedCartNoArray.length - 1) {
	                placeholders.append(",");
	            }
	        }

	        String sql = "SELECT cartno, fk_users_id, itemno, cartamount, itemname, ITEMPHOTOPATH, price, volume, cartamount"
	                   + " FROM cart c "
	                   + " JOIN item i ON c.fk_item_no = i.itemno "
	                   + " WHERE c.fk_users_id = ? "
	                   + " AND cartno IN (" + placeholders.toString() + ")";

	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, id);
	        for (int i = 0; i < selectedCartNoArray.length; i++) {
	            pstmt.setString(i + 2, selectedCartNoArray[i]);
	        }
	        
	        rs = pstmt.executeQuery();

	        while(rs.next()) {
	           /* CartVO cvo = new CartVO();
	            cvo.setCartno(rs.getInt("cartno"));
	            cvo.setFk_users_id(rs.getString("fk_users_id"));
	            cvo.setCartamount(rs.getInt("cartamount"));*/

	            ItemVO itemvo = new ItemVO();
	            itemvo.setItemNo(rs.getInt("itemno"));
	            itemvo.setItemName(rs.getString("itemname"));
	            itemvo.setItemPhotoPath(rs.getString("itemphotopath"));
	            itemvo.setPrice(rs.getInt("price"));
	            itemvo.setVolume(rs.getInt("volume"));

	            CartVO cartvo = new CartVO();
	            cartvo.setCartamount(rs.getInt("cartamount"));
	            cartvo.setCartno(rs.getInt("cartno"));
	            // cartno 를 끌고와야, 추후 계산 완료시 해당 카트를 삭제할 수 있음.
	            itemvo.setCartvo(cartvo);
 
	            getOrderItemList.add(itemvo);
	        }

	    } finally {
	        close();
	    }

	    return getOrderItemList;
	}
	
	
	// 로그인한 유저의 주문 내역의 총 페이지수 알아오기
	@Override
	public int getTotalPage(String id) throws SQLException {
		
		int totalPage = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " SELECT ceil(count(*) / 10) "	// 10 이 sizePerPage 이다.
					   + " FROM order_history "
					   + " WHERE id = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalPage = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return totalPage;
		
	}// end of public int getTotalPage(String id) throws SQLException----------------------------
	
	
	// 로그인한 본인의 주문목록에서 특정 페이지번호에 해당하는 내용들을 조회해오기
	@Override
	public List<Order_historyVO> select_order_paging(Map<String, String> paraMap) throws SQLException {
		
		List<Order_historyVO> ohList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " SELECT OH.orderno, OH.id, to_char(orderdate, 'yyyy-mm-dd') AS orderdate, "
					   + " 		  OH.totalamount, OH.rewarded, "
					   + " 		  NVL( "
					   + "            CASE "
					   + " 			  WHEN LENGTH(LISTAGG(I.itemname, ', ') WITHIN GROUP (ORDER BY I.itemname)) > 30 "
					   + "            THEN SUBSTR(LISTAGG(I.itemname, ', ') WITHIN GROUP (ORDER BY I.itemname), 1, 30) || '...' "
					   + "            ELSE LISTAGG(I.itemname, ', ') WITHIN GROUP (ORDER BY I.itemname) "
					   + "            END, '없음' "
					   + "        ) AS itemlist "
					   + " FROM order_history OH "
					   + " JOIN order_items OI ON OH.orderno = OI.ORDERNO "
					   + " JOIN item I ON OI.itemno = I.itemNo "
					   + " WHERE OH.id = ? "
					   + " GROUP BY OH.orderno, OH.id, OH.totalamount, OH.rewarded, OH.orderdate "
					   + " ORDER BY OH.orderno DESC "
					   + " OFFSET ? ROW "
					   + " FETCH NEXT ? ROW ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = 10;	// 한 페이지당 화면상에 보여줄 제품의 개수는 10 으로 한다.
			int offset = (currentShowPageNo - 1) * sizePerPage;	// 자바에서 미리 계산
			
			pstmt.setString(1, paraMap.get("id"));
			pstmt.setInt(2, offset);
			pstmt.setInt(3, sizePerPage);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				Order_historyVO ohvo = new Order_historyVO();
				
				ohvo.setOrderno(rs.getInt("orderno"));
				ohvo.setId(rs.getString("id"));
				ohvo.setOrderdate(rs.getString("orderdate"));
				ohvo.setTotalamount(rs.getInt("totalamount"));
				ohvo.setRewarded(rs.getInt("rewarded"));
				
				ohvo.setItemlist(rs.getString("itemlist"));	// 조인 통해서 주문내역 가져오기
				
				ohList.add(ohvo);
				
			}// end of while(rs.next())-----------------
			
		} finally {
			close();
		}
		
		return ohList;
		
	}// end of public List<Order_historyVO> select_order_paging(Map<String, String> paraMap) throws SQLException---------------------
	
	
	// 로그인한 유저의 주문 상세 내역 조회(select)
	@Override
	public List<Order_itemsVO> selectOrderDetail(Map<String, String> paraMap) throws SQLException {
		
		List<Order_itemsVO> oiList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " SELECT itemPhotoPath, itemName, volume, quantity, orderprice, totalamount "
					   + " FROM item I JOIN order_items OI ON I.itemNo = OI.itemno "
					   + " JOIN order_history OH ON OI.orderno = OH.orderno "
					   + " WHERE id = ? AND OH.orderno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("id"));
			pstmt.setInt(2, Integer.parseInt(paraMap.get("orderno")));
			
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			while(rs.next()) {
				cnt++;
				Order_itemsVO oivo = new Order_itemsVO();
				oivo.setQuantity(rs.getInt("quantity"));
				oivo.setOrderprice(rs.getInt("orderprice"));
				
				ItemVO ivo = new ItemVO();
				ivo.setItemPhotoPath(rs.getString("itemPhotoPath"));
				ivo.setItemName(rs.getString("itemName"));
				ivo.setVolume(rs.getInt("volume"));
				oivo.setIvo(ivo);
				
				Order_historyVO ohvo = new Order_historyVO();
				if(cnt == 1) {
					ohvo.setTotalamount(rs.getInt("totalamount"));
					oivo.setOhvo(ohvo);
				}
				
				oiList.add(oivo);
			}// end of while------------------
			
		} finally {
			close();
		}
		
		return oiList;
		
	}// end of public List<Order_itemsVO> selectOrderDetail(Map<String, String> paraMap) throws SQLException--------------

	//주문번호 채번하기
	@Override
	public int getOrderSequence() throws SQLException {
		int seq = 0;
		
		try {
			 conn = ds.getConnection();
				 
			 String sql = " select order_seq.nextval AS seq "
			 		    + " from dual";
				 
			 pstmt = conn.prepareStatement(sql);
				 
			 rs = pstmt.executeQuery();
				 
			 rs.next();
				 
			 seq = rs.getInt("seq");
				 
			} finally {
			  close();
		}
			
		return seq;
	}

			
	
	
}
