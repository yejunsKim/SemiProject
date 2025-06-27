package user.model;

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

import user.domain.UserVO;
import util.security.AES256;
import util.security.SecretMyKey;
import util.security.Sha256;

public class UserDAO_imple implements UserDAO {

	private DataSource ds;  // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다. 
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private AES256 aes; // 양방향일 때 사용!
	
	// 생성자
	public UserDAO_imple() {
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


	// 회원가입
	@Override
	public int registerUser(UserVO user) throws SQLException {
		int result = 0;
		
		try {
			// 각 사용자들이 데이터소스에서 커넥션을 하나씩 받을 수 있도록 conn(ection) 재선언.
			conn = ds.getConnection();  
			
			String sql = " insert into users (name, id, password, email, mobile, postcode, address, addressDetail, addressExtra) "
					+ "values ( ?, ?, ?, ?, ?, ?, ?, ?, ? ) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getId());
			pstmt.setString(3, Sha256.encrypt(user.getPassword()));
			pstmt.setString(4, aes.encrypt(user.getEmail()));
			pstmt.setString(5, aes.encrypt(user.getMobile()));
			pstmt.setString(6, user.getPostcode());
			pstmt.setString(7, user.getAddress());
			pstmt.setString(8, user.getAddressDetail());
			pstmt.setString(9, user.getAddressExtra());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return result;
	}

	@Override
	public String findUserid(Map<String, String> paraMap) throws SQLException {
		
		String id = null;
		
		try {
			
		  conn = ds.getConnection();
		  String sql = " select * from users "
		  			 + " where name = ? and email = ? ";
		  
		  pstmt = conn.prepareStatement(sql);
		  pstmt.setString(1, paraMap.get("name"));
		  pstmt.setString(2, aes.encrypt(paraMap.get("email")));
		  
		  rs = pstmt.executeQuery();
		  
			  if(rs.next()) { // 있으면
				  id = rs.getString("id"); //userid 에 userid를 담아서 보내야함
			  }	  
		  }
		  
		  catch(SQLException | GeneralSecurityException | UnsupportedEncodingException e) {
	         e.printStackTrace();	   
		  } finally {
		  	  close();
		  }
		
		return id;
	}

	// pwFind 했을 때, 해당 값이 있으면 1을 반환함.
	@Override
	public int pwFindUser(Map<String, String> paraMap) {
		
		int n = 0;
		
		try {
			
		  conn = ds.getConnection();
		  String sql = " select * from users "
		  			 + " where id = ? and email = ? ";
		  
		  pstmt = conn.prepareStatement(sql);
		  pstmt.setString(1, paraMap.get("id"));
		  pstmt.setString(2, aes.encrypt(paraMap.get("email")));
		  
		  rs = pstmt.executeQuery();
		  
		  if(rs.next()) {
			  n = 1;
		  }
		  else {
			  n = 0;
		  }

		  } catch(SQLException | GeneralSecurityException | UnsupportedEncodingException e) {
	         e.printStackTrace();	   
		  } finally {
		  	  close();
		  }
		
		return n;
	}


	@Override
	public boolean checkIdDuplicate(String id) throws SQLException {
		boolean isExists = true;
		// true >> id 가 존재한다는 뜻
		try {
			conn = ds.getConnection(); 
			// 아파치가 제공하는 데이터소스로 커넥션 완료.
			
			String sql = " select id " 
					+ " from users "
					+ " where id = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			isExists = rs.next();
			// false면 중복되지 않았다는 뜻.
		} finally {
			close();
		}
		return isExists;
	}


	@Override
	public boolean checkEmailDuplicate(String email) throws SQLException {
		boolean isExists = true;
		// true >> email이 존재한다는 뜻. 추후 복호화된 email.
		try {
			conn = ds.getConnection();
			
			String sql = " select id "
					+ "from users "
					+ "where email = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, aes.encrypt(email));
			
			rs = pstmt.executeQuery();
			
			isExists = rs.next();
			// rs 값이 나오지 않으면 false(중복x)
		  } catch(SQLException|GeneralSecurityException | UnsupportedEncodingException e ) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return isExists;
	}

	// 회원정보상세페이지 메소드 
	@Override
	public UserVO selectOneUser(String id) throws SQLException {
		UserVO user = null;
		
		try{
			conn = ds.getConnection();
			
			String sql = " select id, name, email, mobile, "
					+ "                postcode, address, addressDetail, addressExtra, "
					+ "                point, grade, to_char(registerday, 'yyyy-mm-dd') as registerday "
					+ "        from users "
					+ "        where ISDELETED = 'N'  and id = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				user = new UserVO();
				
				user.setId(rs.getString("id"));
				user.setName(rs.getString("name"));
				user.setEmail(aes.decrypt(rs.getString("email")));
				user.setMobile(aes.decrypt(rs.getString("mobile")));
				
				user.setPostcode(rs.getString("postcode"));
				user.setAddress(rs.getString("address"));
				user.setAddressDetail(rs.getString("addressDetail"));
				user.setAddressExtra(rs.getString("addressExtra"));
				
				user.setPoint(rs.getInt("point"));
				user.setGrade(rs.getString("grade"));
				user.setRegisterday(rs.getString("registerday"));
				
			} //end of if(rs.next())
			
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		}finally {
			close();
		}
		
		return user;
	} // end of 회원정보상세페이지


	//로그인
	@Override
	public UserVO login(Map<String, String> paraMap) throws SQLException {
		UserVO user = null;
		try {
			conn = ds.getConnection();
			
			String sql = " SELECT id, name, point, registerday, passwordChangeGap, email, mobile, postcode, "
					+ "       address, addressDetail, addressExtra, lastlogingap, isDormant "
					+ " FROM ( "
					+ "    SELECT id, name, point, registerday, "
					+ "           TRUNC(MONTHS_BETWEEN(SYSDATE, passwordChanged)) AS passwordChangeGap, "
					+ "           isDormant, email, mobile, postcode, "
					+ "           address, addressDetail, addressExtra "
					+ "    FROM Users "
					+ "    WHERE id = ? AND password like ? "
					+ ") U "
					+ " CROSS JOIN ( "
					+ "    SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, MAX(lastLogin))) AS lastlogingap "
					+ "    FROM login_history "
					+ "    WHERE id = ? "
					+ ") H ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("id"));
			pstmt.setString(2, Sha256.encrypt(paraMap.get("password")));
			pstmt.setString(3, paraMap.get("id"));

			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				System.out.println("로그인 되었음!!");
				user = new UserVO();
				
				user.setId(rs.getString("id"));
				user.setName(rs.getString("name"));
				user.setPoint(rs.getInt("point"));
				user.setRegisterday(rs.getString("registerday"));
				 
				if(rs.getInt("passwordChangeGap") > 3) {
					// 비밀번호를 변경한지 3개월이 넘었을 경우,
					user.setRequirePasswordChange(true);
				}
				user.setEmail(aes.decrypt(rs.getString("email")));
				user.setMobile(aes.decrypt(rs.getString("mobile")));
				user.setPostcode(rs.getString("postcode"));
				user.setAddress(rs.getString("address"));
				user.setAddressDetail(rs.getString("addressDetail"));
				user.setAddressExtra(rs.getString("addressExtra"));
				// ==== 휴면이 아닌 회원만 login_history(로그인기록) 테이블에 insert 하기 시작 ==== // 
				if( rs.getInt("lastlogingap") < 12 ) {
					sql = " insert into login_history(loginHistoryNo, id, ip) "
							+ " values(login_history_seq.nextval, ?, ?) ";
					 
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, paraMap.get("id"));
					pstmt.setString(2, paraMap.get("ip"));
					 
					pstmt.executeUpdate();
				 }// ==== 휴면이 아닌 회원만 login_history(로그인기록) 테이블에 insert 하기 끝 ==== //
				 else { // 마지막으로 로그인 한 날짜시간이 현재시각으로 부터 1년이 지났으면 휴면으로 지정 
					 user.setIsDormant("Y");
					 
					 if(rs.getString("isDormant") == "Y") {
					     // === tbl_member 테이블의 isDormant 컬럼의 값을 1로 변경하기 === //
						 sql = " update users set isDormant = 'Y' "
						 	 + " where id = ? ";
						 
						 pstmt = conn.prepareStatement(sql);
						 pstmt.setString(1, paraMap.get("id"));
						 
						 pstmt.executeUpdate();
					 }
				 }
			 }// end of if(rs.next())---------------------------
				
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return user;
	}


	//비밀번호수정
	public int pwdUpdate(Map<String, String> paraMap) throws SQLException {
		
		int result = 0;
		
		try {
			
		  conn = ds.getConnection();
		  String sql = " update users set password = ? "
		  			 + " where id = ? ";

		  pstmt = conn.prepareStatement(sql);
		  pstmt.setString(1, paraMap.get("new_password"));
		  pstmt.setString(2, paraMap.get("id"));
		  
		  result = pstmt.executeUpdate();
		  
		  } catch(SQLException e) {
	         e.printStackTrace();	   
		  } finally {
		  	  close();
		  }
		
		  return result;
	}

	// 회원정보수정
	@Override
	public int updateUser(UserVO user) throws SQLException {
		int result = 0;

		try {
			 conn = ds.getConnection();
			 
			 String sql = " update user set name = ? "
					    + "                     , password = ? "
					    + "                     , email = ? "
					    + "                     , mobile = ? "
					    + "                     , postcode = ? " 
					    + "                     , address = ? "
					    + "                     , addressDetail = ? "
					    + "                     , addressExtra = ? "
					    + "                     , lastpwdchangedate = sysdate "
					    + " where userid = ? ";
			 
			 pstmt = conn.prepareStatement(sql);
				
			 pstmt.setString(1, user.getName());
			 pstmt.setString(2, Sha256.encrypt(user.getPassword()) ); // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다.
			 pstmt.setString(3, aes.encrypt(user.getEmail()) );  // 이메일을 AES256 알고리즘으로 양방향 암호화 시킨다. 
			 pstmt.setString(4, aes.encrypt(user.getMobile()) ); // 휴대폰번호를 AES256 알고리즘으로 양방향 암호화 시킨다. 
			 pstmt.setString(5, user.getPostcode());
			 pstmt.setString(6, user.getAddress());
			 pstmt.setString(7, user.getAddressDetail());
			 pstmt.setString(8, user.getAddressExtra());
			 pstmt.setString(9, user.getId());
			 
			 result = pstmt.executeUpdate();
			 
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return result;		
	}
	
}

