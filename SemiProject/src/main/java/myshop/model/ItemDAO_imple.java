package myshop.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import myshop.domain.CartVO;
import myshop.domain.CategoryVO;
import myshop.domain.Delivery_addressVO;
import myshop.domain.ItemVO;
import myshop.domain.Order_historyVO;
import myshop.domain.Order_itemsVO;
import myshop.domain.ReviewVO;
import user.domain.UserVO;
import util.security.AES256;
import util.security.SecretMyKey;


public class ItemDAO_imple implements ItemDAO {
	
	private DataSource ds;  // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다. 
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private AES256 aes; // 양방향일 때 사용!
	
	// 생성자
	public ItemDAO_imple() {
		
		try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/semiproject");
			
			aes = new AES256(SecretMyKey.KEY);
		} catch(NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
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
			
			String sql = " SELECT C.cartno, I.itemPhotoPath, I.itemName, I.price, I.itemAmount, C.cartamount,  I.itemNo, "
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
				ivo.setItemNo(rs.getInt("itemNo"));
				
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
	
	

	// 로그인 유저의 장바구니 조회.	
	@Override
	public List<ItemVO> getOrderItemList(String[] itemNoArr) throws SQLException {

	    List<ItemVO> getOrderItemList = new ArrayList<>();

	    try {
	        conn = ds.getConnection();

	        StringBuilder placeholders = new StringBuilder();
	        for (int i = 0; i < itemNoArr.length; i++) {
	            placeholders.append("?");
	            if (i < itemNoArr.length - 1) {
	                placeholders.append(",");
	            }
	        }

	        String sql = " select itemno, itemname, ITEMPHOTOPATH, price, volume "
	        		   + " from item "
	                   + " where itemno in ( "+ placeholders.toString()+" ) ";
	        
	        pstmt = conn.prepareStatement(sql);

	        for (int i = 0; i < itemNoArr.length; i++) {
	            pstmt.setString(i + 1, itemNoArr[i]);
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
				
				ohvo.setOrderno(rs.getString("orderno"));
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
			
			String sql = " SELECT itemPhotoPath, itemName, volume, quantity, orderprice, totalamount, rewarded"
					   + "		, D.email, D.address, D.addressdetail, D.addressextra, D.deliveryno "
					   + " FROM item I JOIN order_items OI ON I.itemNo = OI.itemno "
					   + " JOIN order_history OH ON OI.orderno = OH.orderno "
					   + " JOIN delivery_address D ON OI.deliveryno = D.deliveryno "
					   + " WHERE OH.id = ? AND OH.orderno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("id"));
			pstmt.setString(2, paraMap.get("orderno"));
			
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			while(rs.next()) {
				cnt++;
				Order_itemsVO oivo = new Order_itemsVO();
				oivo.setQuantity(rs.getInt("quantity"));
				oivo.setOrderprice(rs.getInt("orderprice"));
				
				Delivery_addressVO davo = new Delivery_addressVO();
				if(cnt == 1) {
					davo.setEmail(aes.decrypt(rs.getString("email"))); // 주문배송지의 이메일을 가져옴.
					davo.setAddress(rs.getString("address"));
					davo.setAddressdetail(rs.getString("addressdetail"));
					davo.setAddressextra(rs.getString("addressextra"));
					davo.setDeliveryno(rs.getInt("deliveryno"));
					oivo.setDelivery_addressVO(davo); // 주문배송지를 order_item에 삽입
				}
				ItemVO ivo = new ItemVO();
				ivo.setItemPhotoPath(rs.getString("itemPhotoPath"));
				ivo.setItemName(rs.getString("itemName"));
				ivo.setVolume(rs.getInt("volume"));
				oivo.setIvo(ivo);
				
				Order_historyVO ohvo = new Order_historyVO();
				if(cnt == 1) {
					ohvo.setTotalamount(rs.getInt("totalamount"));
					ohvo.setRewarded(rs.getInt("rewarded"));
					oivo.setOhvo(ohvo);
				}
				
				oiList.add(oivo);
			}// end of while------------------
			
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (GeneralSecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close();
		}
		
		return oiList;
		
	}// end of public List<Order_itemsVO> selectOrderDetail(Map<String, String> paraMap) throws SQLException--------------

		      	 


		//주문번호 채번하기
		@Override
		public int get_order_seq() throws SQLException {
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

		

		// 로그인한 사용자가 해당 제품을 구매했는지 알아오기
		   @Override
		   public boolean isOrder(Map<String, String> paraMap) throws SQLException {

		      boolean bool = false;
		      
		      try {
		         conn = ds.getConnection();
		         
		         String sql = " SELECT orderitemno "
		                  + " FROM ORDER_ITEMS I JOIN ORDER_HISTORY H "
		                  + " ON I.ORDERNO = H.ORDERNO "
		                  + " WHERE H.id = ? AND I.itemno = ? ";
		         
		         pstmt = conn.prepareStatement(sql);
		         pstmt.setString(1, paraMap.get("fk_id"));
		         pstmt.setString(2, paraMap.get("fk_itemNo"));
		         
		         rs = pstmt.executeQuery();
		         
		         bool = rs.next();
		         
		         System.out.println(">>> DAO isOrder() 확인용 : " + paraMap);
		               
		      } finally {
		         close();
		      }
		      
		      return bool;
		      
		   }


		   // 특정 사용자가 특정 제품에 대해 상품후기를 입력하기(insert)
		   @Override
		   public int addReview(ReviewVO reviewVO) throws SQLException {

		      int n = 0;
		      
		      try {
		         conn = ds.getConnection();
		         
		         String sql = " insert into reviews(reviewid, fk_id, fk_itemno, content, createdat) "
		                  + " values(review_seq.nextval, ?, ?, ?, default) ";
		                  
		         pstmt = conn.prepareStatement(sql);
		         pstmt.setString(1, reviewVO.getFk_id());
		         pstmt.setInt(2, reviewVO.getFk_itemNo());
		         pstmt.setString(3, reviewVO.getContent());
		         
		         n = pstmt.executeUpdate();
		         
		      } finally {
		         close();
		      }
		      
		      return n;
		      
		   }

		// 리뷰 조회하기(select)  
		   @Override
		   public List<ReviewVO> reviewList(String fk_itemNo, int startRow, int endRow) throws SQLException{
		       List<ReviewVO> reviewList = new ArrayList<>();
		       try {
		           conn = ds.getConnection();

		           String sql = 
		               " SELECT reviewId, fk_id, name, content, createdAt " +
		               " FROM ( " +
		               "    SELECT R.reviewId, R.fk_id, U.name, R.content, " +
		               "           TO_CHAR(R.createdAt, 'yyyy-mm-dd hh24:mi:ss') AS createdAt, " +
		               "           ROW_NUMBER() OVER (ORDER BY R.reviewId DESC) AS rn " +
		               "    FROM reviews R " +
		               "    JOIN users U ON R.fk_id = U.id " +
		               "    WHERE R.fk_itemNo = ? " +
		               " ) " +
		               " WHERE rn BETWEEN ? AND ? ";

		           pstmt = conn.prepareStatement(sql);
		           pstmt.setString(1, fk_itemNo);
		           pstmt.setInt(2, startRow);
		           pstmt.setInt(3, endRow);

		           rs = pstmt.executeQuery();
		           while(rs.next()) {
		               ReviewVO reviewvo = new ReviewVO();
		               reviewvo.setReviewId(rs.getInt("reviewId"));
		               reviewvo.setFk_id(rs.getString("fk_id"));

		               UserVO uservo = new UserVO();
		               uservo.setName(rs.getString("name"));
		               reviewvo.setUserVO(uservo);

		               reviewvo.setContent(rs.getString("content"));
		               reviewvo.setCreatedAt(rs.getString("createdAt"));

		               reviewList.add(reviewvo);
		           }
		       } finally {
		           close();
		       }
		       return reviewList;
		   }

		   //리뷰페이지수
			@Override
			public int getReviewCount(String fk_itemNo) throws SQLException {
			    int count = 0;
			    try {
			        conn = ds.getConnection();
			        String sql = "SELECT COUNT(*) FROM reviews WHERE fk_itemNo = ?";
			        pstmt = conn.prepareStatement(sql);
			        pstmt.setString(1, fk_itemNo);

			        rs = pstmt.executeQuery();
			        if (rs.next()) {
			            count = rs.getInt(1);
			        }

			    } finally {
			        close();
			    }
			    return count;
			
		}


		
		// 리뷰 삭제하기 (delete)
		@Override
		public int reviewDel(String reviewId) throws SQLException {
			
			int n = 0;
		      
		      try {
		         conn = ds.getConnection();
		         
		         String sql = " delete from reviews "
		                  + " where reviewId = ? ";
		                  
		         pstmt = conn.prepareStatement(sql);
		         pstmt.setString(1, reviewId);
		         
		         n = pstmt.executeUpdate();
		         
		      } finally {
		         close();
		      }
		      
		      return n;
			
		}//end of public int reviewDel(String review_seq) throws SQLException 

		//리뷰 수정하기 (update)
		@Override
		public int reviewUpdate(Map<String, String> paraMap) throws SQLException {
			
			int n = 0;
		      
		      try {
		         conn = ds.getConnection();
		         
		         String sql = " update reviews set content = ? "
		                  + "                               , createdAt = sysdate "
		                  + " where reviewId = ? ";
		                  
		         pstmt = conn.prepareStatement(sql);
		         pstmt.setString(1, paraMap.get("content"));
		         pstmt.setString(2, paraMap.get("reviewId"));
		         
		         n = pstmt.executeUpdate();
		         
		      } finally {
		         close();
		      }
		      
		      return n;
			
		}//end of public int reviewUpdate(String review_seq) throws SQLException

		   
		   @Override
		   public int likeAdd(Map<String, String> paraMap) throws SQLException {
		       int result = 0;
		       
		       String sql =" select count(*)  AS LIKECNT "+
	                    "          from  review_reactions"+
	                    "          where fk_reviewId = ?  and fk_id = ? ";
		       
		       try {
		           conn = ds.getConnection();
		           pstmt = conn.prepareStatement(sql);
		           pstmt.setString(1, paraMap.get("fk_reviewId"));
		           pstmt.setString(2, paraMap.get("fk_id"));
		           
		           rs = pstmt.executeQuery();
		           if(rs.next() && rs.getInt("LIKECNT") > 0) {
		        	   
		               // 이미 좋아요 눌렀음 -> 삭제
		               sql = "DELETE FROM review_reactions"
		               		+ " WHERE fk_reviewId = ? and fk_id = ? ";
		               
		               pstmt = conn.prepareStatement(sql);
		               pstmt.setString(1, paraMap.get("fk_reviewId"));
			           pstmt.setString(2, paraMap.get("fk_id"));

		               
		               pstmt.executeUpdate();
		               result = 0; // 좋아요 취소
		           } else {
		               // 좋아요 추가
		        	    sql = " insert into review_reactions(fk_id, fk_reviewId) "
				         		+ " values(?, ?) ";
				         
				         
				         pstmt = conn.prepareStatement(sql);
				         pstmt.setString(1, paraMap.get("fk_id") );
				         pstmt.setString(2, paraMap.get("fk_reviewId"));
				         
		              
		               pstmt.executeUpdate();
		               result = 1; // 좋아요 추가
		           }
		       } finally {
		           close();
		       }
		       return result;
		   }
		
		// 리뷰 좋아요 수 조회
		   @Override
		   public Map<String, Integer> getLikeCount(String reviewId) throws SQLException {
		       Map<String, Integer> map = new HashMap<>(); 
		       System.out.println(">>> getLikeCount reviewId = " + reviewId);

		       try {
		           conn = ds.getConnection();
		           String sql = 
		               " SELECT count(*) AS LIKECNT " +
		               " FROM review_reactions " +
		               " WHERE fk_reviewId = ? ";

		           pstmt = conn.prepareStatement(sql);
		           pstmt.setString(1, reviewId);

		           rs = pstmt.executeQuery();
		           if (rs.next()) {
		               int cnt = rs.getInt("LIKECNT");
		               System.out.println(">>> like count for reviewId "+reviewId+" = "+cnt);
		               map.put("likecnt", cnt);
		           } else {
		               System.out.println(">>> no rows found for reviewId "+reviewId);
		               map.put("likecnt", 0);
		           }
		       } finally {
		           close();
		       }

		       return map;
		   }




	@Override
	   public List<ItemVO> searchItemsByName(String searchID, int start, int len) throws SQLException {
	       List<ItemVO> list = new ArrayList<>();

	       try {
	           conn = ds.getConnection();
	           String sql = "SELECT * FROM ( " +
	                        " SELECT ROWNUM AS rnum, a.* FROM ( " +
	                        " SELECT itemno, itemname, itemphotopath, price, volume " +
	                        " FROM item WHERE itemname LIKE ? ORDER BY itemno DESC " +
	                        ") a ) " +
	                        "WHERE rnum BETWEEN ? AND ?";

	           pstmt = conn.prepareStatement(sql);
	           pstmt.setString(1, "%" + searchID + "%");
	           pstmt.setInt(2, start);
	           pstmt.setInt(3, start + len - 1);

	           rs = pstmt.executeQuery();
	           while (rs.next()) {
	               ItemVO vo = new ItemVO();
	               vo.setItemNo(rs.getInt("itemno"));
	               vo.setItemName(rs.getString("itemname"));
	               vo.setItemPhotoPath(rs.getString("itemphotopath"));
	               vo.setPrice(rs.getInt("price"));
	               vo.setVolume(rs.getInt("volume"));
	               list.add(vo);
	           }
	       } finally {
	           close();
	       }

	       return list;
	   }
	
	@Override
	   public int getSearchResultCount(String searchID) throws SQLException {
	       int count = 0;

	       try {
	           conn = ds.getConnection();
	           String sql = "SELECT COUNT(*) AS cnt FROM item WHERE itemname LIKE ?";
	           pstmt = conn.prepareStatement(sql);
	           pstmt.setString(1, "%" + searchID + "%");
	           rs = pstmt.executeQuery();

	           if (rs.next()) {
	               count = rs.getInt("cnt");
	           }
	       } finally {
	           close();
	       }

	       return count;
	   }


	// 카테고리별주문 통계정보 알아오기
	@Override
	public List<Map<String, String>> myPurchase_byCategory(String id) throws SQLException {

		List<Map<String, String>> myPurchase_map_List = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " WITH "
					   + " OH AS "
					   + " ( SELECT orderNo "
					   + "   FROM order_history "
					   + " ) "
					   + " , "
					   + " OI AS "
					   + " ( SELECT orderNo, ITEMNO, quantity, orderPrice "
					   + "   FROM order_items "
					   + " ) "
					   + " SELECT C.categoryName "
					   + "      , COUNT(*) AS CNT "
					   + "      , SUM(OI.quantity * OI.orderPrice) AS SUMPAY"
					   + "      , ROUND( SUM(OI.quantity * OI.orderPrice) / (SELECT SUM(OI.quantity * OI.orderPrice) "
					   + "            										 FROM OH JOIN order_items OI "
					   + "													 ON OH.orderNo = OI.orderNo) * 100, 2) AS SUMPAY_PCT "
					   + " FROM OI JOIN OH "
					   + " ON OH.orderNo = OI.orderNo "
					   + " JOIN item I "
					   + " ON OI.ITEMNO = I.ITEMNO "
					   + " JOIN category C "
					   + " ON I.fk_category_no = C.categoryNo "
					   + " GROUP BY C.categoryName "
					   + " ORDER BY SUMPAY DESC ";
			
			pstmt = conn.prepareStatement(sql);
	         
			rs = pstmt.executeQuery();
	                  
			while(rs.next()) {
				String categoryname = rs.getString("categoryname");
	            String cnt = rs.getString("CNT");
	            String sumpay = rs.getString("SUMPAY");
	            String sumpay_pct = rs.getString("SUMPAY_PCT");
	            
	            Map<String, String> map = new HashMap<>();
	            map.put("categoryname", categoryname);
	            map.put("cnt", cnt);
	            map.put("sumpay", sumpay);
	            map.put("sumpay_pct", sumpay_pct);
	            
	            myPurchase_map_List.add(map);
			}
			
		} finally {
			close();
		}
		
		return myPurchase_map_List;
	}


	// 카테고리별 월별주문 통계정보 알아오기
	@Override
	public List<Map<String, String>> myPurchase_byMonth_byCategory(String id) throws SQLException {

		List<Map<String, String>> myPurchase_map_List = new ArrayList<>();
	      
		try {
			conn = ds.getConnection();
	         
			String sql = " WITH "
					   + " OH AS "
					   + " (SELECT orderno, orderdate "
					   + "  FROM order_history "
					   + " ), "
					   + " OI AS "
					   + " (SELECT orderNo, ITEMNO, quantity, orderPrice "
					   + "  FROM order_items "
					   + " ) "
					   + " SELECT C.categoryName "
					   + "      , COUNT(*) AS CNT"
					   + "		, SUM(OI.quantity * OI.orderPrice) AS SUMPAY "
					   + "      , ROUND( SUM(OI.quantity * OI.orderPrice)/(SELECT SUM(OI.quantity * OI.orderPrice) "
					   + "                                                 FROM OH JOIN OI "
					   + "												   ON OH.orderNo = OI.orderNo) * 100, 2) AS SUMPAY_PCT "
					   + "      , SUM(DECODE(TO_CHAR(OH.orderdate, 'mm'), '01', OI.quantity * OI.orderPrice, 0)) AS M_01 "
					   + "      , SUM(DECODE(TO_CHAR(OH.orderdate, 'mm'), '02', OI.quantity * OI.orderPrice, 0)) AS M_02 "
					   + "      , SUM(DECODE(TO_CHAR(OH.orderdate, 'mm'), '03', OI.quantity * OI.orderPrice, 0)) AS M_03 "
					   + "      , SUM(DECODE(TO_CHAR(OH.orderdate, 'mm'), '04', OI.quantity * OI.orderPrice, 0)) AS M_04 "
					   + "      , SUM(DECODE(TO_CHAR(OH.orderdate, 'mm'), '05', OI.quantity * OI.orderPrice, 0)) AS M_05 "
					   + "      , SUM(DECODE(TO_CHAR(OH.orderdate, 'mm'), '06', OI.quantity * OI.orderPrice, 0)) AS M_06 "
					   + "      , SUM(DECODE(TO_CHAR(OH.orderdate, 'mm'), '07', OI.quantity * OI.orderPrice, 0)) AS M_07 "
					   + "      , SUM(DECODE(TO_CHAR(OH.orderdate, 'mm'), '08', OI.quantity * OI.orderPrice, 0)) AS M_08 "
					   + "      , SUM(DECODE(TO_CHAR(OH.orderdate, 'mm'), '09', OI.quantity * OI.orderPrice, 0)) AS M_09 "
					   + "      , SUM(DECODE(TO_CHAR(OH.orderdate, 'mm'), '10', OI.quantity * OI.orderPrice, 0)) AS M_10 "
					   + "      , SUM(DECODE(TO_CHAR(OH.orderdate, 'mm'), '11', OI.quantity * OI.orderPrice, 0)) AS M_11 "
					   + "      , SUM(DECODE(TO_CHAR(OH.orderdate, 'mm'), '12', OI.quantity * OI.orderPrice, 0)) AS M_12 "
					   + " FROM OI JOIN OH "
					   + " ON OH.orderNo = OI.orderNo "
					   + " JOIN item I "
					   + " ON OI.ITEMNO = I.itemNo "
					   + " JOIN category C "
					   + " ON I.fk_category_no = C.categoryNo "
					   + " GROUP BY C.categoryName "
					   + " ORDER BY SUMPAY DESC ";
	         
			pstmt = conn.prepareStatement(sql);
	         
			rs = pstmt.executeQuery();
	                  
			while(rs.next()) {
				String categoryname = rs.getString("categoryname");
	            String cnt = rs.getString("CNT");
	            String sumpay = rs.getString("SUMPAY");
	            String sumpay_pct = rs.getString("SUMPAY_PCT");
	            String m_01 = rs.getString("M_01");
	            String m_02 = rs.getString("M_02");
	            String m_03 = rs.getString("M_03");
	            String m_04 = rs.getString("M_04");
	            String m_05 = rs.getString("M_05");
	            String m_06 = rs.getString("M_06");
	            String m_07 = rs.getString("M_07");
	            String m_08 = rs.getString("M_08");
	            String m_09 = rs.getString("M_09");
	            String m_10 = rs.getString("M_10");
	            String m_11 = rs.getString("M_11");
	            String m_12 = rs.getString("M_12");
	            
	            Map<String, String> map = new HashMap<>();
	            map.put("categoryname", categoryname);
	            map.put("cnt", cnt);
	            map.put("sumpay", sumpay);
	            map.put("sumpay_pct", sumpay_pct);
	            map.put("m_01", m_01);
	            map.put("m_02", m_02);
	            map.put("m_03", m_03);
	            map.put("m_04", m_04);
	            map.put("m_05", m_05);
	            map.put("m_06", m_06);
	            map.put("m_07", m_07);
	            map.put("m_08", m_08);
	            map.put("m_09", m_09);
	            map.put("m_10", m_10);
	            map.put("m_11", m_11);
	            map.put("m_12", m_12);
	            
	            myPurchase_map_List.add(map);
			} // end of while----------------------------------
	                  
		} finally {
			close();
		}
	      
		return myPurchase_map_List;   
	      
	}


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
	//주문 배송지번호 채번하기
	@Override
	public int getDeliverySequence() throws SQLException {
		int seq = 0;
		
		try {
			 conn = ds.getConnection();
				 
			 String sql = " select delivery_seq.nextval AS seq "
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
	
	// 트랜잭션으로 주문 insert & 재고감소 & 장바구니삭제 & 포인트적립
	@Override
	public int insertOrderUpdate(Map<String, Object> paraMap) throws SQLException {
		
		int isSuccess = 0;
	    int n1=0, n2=0, n3=0, n4=0, n5=0;	      
    
	    try {
	         conn = ds.getConnection();
	         conn.setAutoCommit(false);
	         //String 얻어오기
	         String id = (String)paraMap.get("id");
	         String orderNo = (String) paraMap.get("orderNo"); // 주문코드는 문자열로 유지
	         // 사실상 orderCode인 셈.
	         int deliverNo = (Integer) paraMap.get("deliverNo");
	         int totalAmount = Integer.parseInt((String) paraMap.get("totalAmount"));
	         int usePoint = Integer.parseInt((String) paraMap.get("usePoint"));
	         int getPoint = Integer.parseInt((String) paraMap.get("getPoint"));
	
	         
	         //Object 얻어오기
	         String[] cartNoArr = ((String[]) paraMap.get("cartNoArr"));
	         String[] itemNoArr = ((String[])paraMap.get("itemNoArr"));
	         String[] quantityArr = ((String[])paraMap.get("quantityArr"));
	         int[] itemEachPriceArr = ((int[])paraMap.get("itemEachPriceArr"));
	
	         // 주문 insert
	         String sql = " insert into order_history(orderNo, id, orderDate, totalAmount, rewarded) "
	         		+ " values(?, ? , sysdate, ? , ? ) ";
	         
	         pstmt= conn.prepareStatement(sql);
	      	
	         pstmt.setString(1, orderNo); // 사실상 orderCode인 셈.
	         pstmt.setString(2, id);
	         pstmt.setInt(3, totalAmount);
	         pstmt.setInt(4, getPoint); 	        
	         
	         n1= pstmt.executeUpdate();
	         pstmt.close();
	          
	      	if(n1==1) { 
	      	// 주문상세내역(order_items)이 insert되었다면,
	      	// 주문 배송지 (delivery_address)도 insert 해주기
	      		sql = " insert into delivery_address (deliveryNo, id, postcode, address, addressDetail, addressExtra, email) "
	        		  		+ " values (?, ?, ?, ?, ?, ?, ?) ";
	      		pstmt = conn.prepareStatement(sql);

	      		pstmt.setInt(1, deliverNo);
	      		pstmt.setString(2, id);
	      		pstmt.setString(3, (String)paraMap.get("postcode"));
	      		pstmt.setString(4, (String)paraMap.get("address"));
	      		pstmt.setString(5, (String)paraMap.get("addressDetail"));
	      		pstmt.setString(6, (String)paraMap.get("addressExtra"));
	      		pstmt.setString(7, aes.encrypt((String)paraMap.get("email")));

	      		n2= pstmt.executeUpdate();
	      		pstmt.close();
	      	}
	      	if(n2==1) {
	      	  int cnt =0;
	      		
	          for(int i=0; i<itemNoArr.length; i++) {
	        	  
        		  sql = " insert into order_items (orderItemNo, orderNo, itemNo, quantity, orderPrice"
        		  		+ "							, deliveryNo) "
        		  		+ " values (order_item_seq.nextval, ?, ?, ?, ?, ?) ";
        		  
        		  pstmt = conn.prepareStatement(sql);
                  pstmt.setString(1, orderNo);
                  pstmt.setString(2, itemNoArr[i]);
                  pstmt.setInt(3, Integer.parseInt(quantityArr[i]));
                  pstmt.setInt(4, itemEachPriceArr[i]);
                  pstmt.setInt(5, deliverNo);
                  pstmt.executeUpdate();
                  pstmt.close();
        		  System.out.println("itemEachPriceArr[i]>>"+itemEachPriceArr[i]);
                 // 재고 감소
                  sql = "UPDATE item SET itemAmount = itemAmount - ? WHERE itemNo = ?";
                  pstmt = conn.prepareStatement(sql);
                  pstmt.setInt(1, Integer.parseInt(quantityArr[i]));
                  pstmt.setString(2, itemNoArr[i]);
                  pstmt.executeUpdate();
                  pstmt.close();
                
                  cnt++;
        	  }
        	  if(cnt == cartNoArr.length) {
                  n3 = 1;
              }
	      	}
        	  
        	  // 장바구니 삭제
	      	if(n3 == 1) {
	      	    StringBuilder placeholders = new StringBuilder();
	      	    for (int i = 0; i < cartNoArr.length; i++) {
	      	        placeholders.append("?");
	      	        if (i < cartNoArr.length - 1) {
	      	            placeholders.append(",");
	      	        }
      	    }

	      	    sql = "DELETE FROM cart WHERE cartno IN (" + placeholders.toString() + ")";
	      	    pstmt = conn.prepareStatement(sql);
	      	    for (int i = 0; i < cartNoArr.length; i++) {
	      	        pstmt.setString(i + 1, cartNoArr[i]);
	      	    }
	
	      	    n4 = pstmt.executeUpdate();
	      	    pstmt.close();
	
	      	    if (n4 >= cartNoArr.length) {
	      	        n4 = 1;
	      	    }
	      	}
		  
			//사용자 포인트 적립
			if(n4==1) {
				sql = " update users set point = point + ? "
				  	+ " where id = ? ";
				  
				pstmt= conn.prepareStatement(sql);
				pstmt.setInt(1, getPoint - usePoint);
				pstmt.setString(2, id);
				n5 = pstmt.executeUpdate();
				pstmt.close();
			}
		    System.out.println("n1="+n1+" n2="+n2+" n3="+n3+" n4="+n4+" n5="+n5);
		    if(n1*n2*n3*n4*n5 == 1) {
				
			conn.commit();
			
			conn.setAutoCommit(true); // 자동커밋으로 전환 
			
			//	System.out.println("~~~ 확인용 n1*n2*n3*n4*n5 : " + n1*n2*n3*n4*n5);
			//	~~~ 확인용 n1*n2*n3*n4*n5 : 1 
			
			isSuccess = 1;
		}
        	  
        	  
	    } catch(SQLException e) {
			e.printStackTrace();
		    System.out.println("n1="+n1+" n2="+n2+" n3="+n3+" n4="+n4+" n5="+n5);

			conn.rollback();
			
			conn.setAutoCommit(true); // 자동커밋으로 전환 
			
			isSuccess = 0;
			
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (GeneralSecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close();
		}
		
		return isSuccess;
	}

}
