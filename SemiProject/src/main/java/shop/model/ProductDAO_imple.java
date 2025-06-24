package shop.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import shop.domain.CategoryVO;

public class ProductDAO_imple implements ProductDAO{

	private DataSource ds;  // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다. 
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자
	public ProductDAO_imple() {
		
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
			if(rs    != null) {rs.close();	  rs=null;}
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


	
	
}
