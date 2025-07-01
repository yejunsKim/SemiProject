package user.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import user.domain.UserVO;

public interface UserDAO {
	
	// 회원가입 페이지에서 가입하기 버튼을 눌렀을 경우 user를 insert하는 메소드
	public int registerUser(UserVO user) throws SQLException;
	
	// idFind 했을 때 map으로 가져옴
	String findUserid(Map<String, String> paraMap) throws SQLException;

	// pwFinduser 로 비밀번호 찾기시 있으면 1 반환
	int pwFindUser(Map<String, String> paraMap) throws SQLException;

	// pwFinduser 로 비밀번호 변경시 성공시 1 반환
	public int pwdUpdate(Map<String, String> paraMap) throws SQLException;

	// idCheck 버튼을 누를 시 id 중복 체크 메소드
	public boolean checkIdDuplicate(String id) throws SQLException;

	// idCheck 버튼을 누를 시 id 중복 체크 메소드
	public boolean checkEmailDuplicate(String email) throws SQLException;

	// 로그인 해욧
	public UserVO login(Map<String, String> paraMap) throws SQLException;
	
	// 회원정보수정
	public int updateUser(UserVO user) throws SQLException;

	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 회원에 대한 총 페이지 수 알아오기 //
	public int getTotalUser(Map<String, String> paraMap) throws SQLException;

	/* >>> 뷰단(userList.jsp)에서 "페이징 처리시 보여주는 순번 공식" 에서 사용하기 위해 
    검색이 있는 또는 검색이 없는 회원의 총개수 알아오기 시작 <<< */
    public int getTotalUserCount(Map<String, String> paraMap) throws SQLException;

	// **** 페이징 처리를 한 모든 회원 목록 또는 검색한 회원목록 보여주기 **** //
	public List<UserVO> select_User_paging(Map<String, String> paraMap) throws SQLException;

	// userDatail을 위한 id로 userVO 끌고오기.
	public UserVO selectUser(String id) throws SQLException;
}
