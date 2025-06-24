package user.model;

import java.sql.SQLException;
import java.util.Map;

import user.domain.UserVO;

public interface UserDAO {
	
	// 회원가입 페이지에서 가입하기 버튼을 눌렀을 경우 user를 insert하는 메소드
	public int registerUser(UserVO user) throws SQLException;
	
	// idFind 했을 때 map으로 가져옴
	String findUserid(Map<String, String> paraMap) throws SQLException;

	// pwFind 했을 때, 해당 값이 있으면 1을 반환함.
	int pwFindUser(Map<String, String> paraMap) throws SQLException;

}
