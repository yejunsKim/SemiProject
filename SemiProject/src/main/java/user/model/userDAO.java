package user.model;

import java.sql.SQLException;

import user.domain.userVO;

public interface userDAO {
	// 회원가입 페이지에서 가입하기 버튼을 눌렀을 경우 user를 insert하는 메소드
	public int registerUser(userVO user) throws SQLException;

}
