package myshop.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.SecretMyKey;

public class ProductDAO_imple implements ProductDAO {
	
	private DataSource ds;  // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다. 
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes; // AES256 양방향 통신을 위한 객체생성
	
	public ProductDAO_imple() {
		
		try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/semiproject");
			
			// aes = new AES256(String key) 에서 생성자를 가져온다음, 미리 만들어둔 암호화 키를 가져온다.
			aes = new AES256(SecretMyKey.KEY);
			// SecretMyKey은 우리가 만든 함호화 / 복호화 키이다.
			
		  } catch(NamingException e) {
			  e.printStackTrace();
		  } catch(UnsupportedEncodingException e) {
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

	@Override
	public String idFind(Map<String, String> paraMap) throws SQLException {
		
		String userid = null;
		
		try {
			
		  conn = ds.getConnection();
		  String sql = " select * from users "
		  			 + " where name = ? and mobile = ? ";
		  
		  pstmt = conn.prepareStatement(sql);
		  pstmt.setString(1, paraMap.get("name"));
		  pstmt.setString(2, paraMap.get("mobile"));
		  
		  rs = pstmt.executeQuery();
		  
			  if(rs.next()) { // 있으면
				  userid = rs.getString("userid"); //userid 에 userid를 담아서 보내야함
			  }	  
		  }
		  
		  catch(SQLException e) {
	         e.printStackTrace();	   
		  } finally {
		  	  close();
		  }
		
		return userid;
	}

}
