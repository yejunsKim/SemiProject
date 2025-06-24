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

import myshop.domain.CategoryVO;
import myshop.domain.ItemVO;


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
	
	
	// 카테고리별 상품의 전체 개수를 알아온다.
	@Override
	public int totalTenCount(int i) throws SQLException {
		
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
			
			String sql = " SELECT itemno, itemName, itemphotopath, iteminfo, price, itemamount, volume, company, infoimg, categoryname "
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
				ivo.setItemInfo(rs.getString("iteminfo"));
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
	
}
