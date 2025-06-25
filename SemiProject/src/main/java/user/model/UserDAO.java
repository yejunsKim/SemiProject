package user.model;

import java.sql.SQLException;
import java.util.Map;

import user.domain.UserVO;

public interface UserDAO {
	
	// 회원가입 페이지에서 가입하기 버튼을 눌렀을 경우 user를 insert하는 메소드
	public int registerUser(UserVO user) throws SQLException;
	
	// idFind 했을 때 map으로 가져옴
	String findUserid(Map<String, String> paraMap) throws SQLException;

	int pwFindUser(Map<String, String> paraMap) throws SQLException;

	public int pwdUpdate(Map<String, String> paraMap) throws SQLException;

	// idCheck 버튼을 누를 시 id 중복 체크 메소드
	public boolean checkIdDuplicate(String id) throws SQLException;

	// idCheck 버튼을 누를 시 id 중복 체크 메소드
	public boolean checkEmailDuplicate(String email) throws SQLException;
}
