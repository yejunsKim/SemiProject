package user.model;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import user.domain.userVO;
import util.security.AES256;
import util.security.SecretMyKey;

public class userDAO_imple implements userDAO {


	private DataSource ds;  // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다. 
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private AES256 aes; // 양방향일 때 사용!
	
	// 생성자
	public userDAO_imple() {
		try {
			System.out.println("📌 DAO 생성자 진입");
			
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semiproject");
		    
		    aes = new AES256(SecretMyKey.KEY);
		    
		} catch(NamingException e) {
			System.out.println("❌ NamingException: " + e.getMessage());
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
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


	
	@Override
	public int registerUser(userVO user) throws SQLException {
		int result = 0;
		
		try {
			// 각 사용자들이 데이터소스에서 커넥션을 하나씩 받을 수 있도록 conn(ection) 재선언.
			conn = ds.getConnection();  
			
			String sql = " insert into users (name, id, password, email, mobile, postcode, address, addressDetail, addressExtra) "
					+ "values ( ?, ?, ?, ?, ?, ?, ?, ?, ? ) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getId());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getEmail());
			pstmt.setString(5, user.getMobile());
			pstmt.setString(6, user.getPostcode());
			pstmt.setString(7, user.getAddress());
			pstmt.setString(8, user.getDetailaddress());
			pstmt.setString(9, user.getExtraaddress());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return result;
	}

}
