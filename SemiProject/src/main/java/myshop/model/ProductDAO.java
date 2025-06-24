package myshop.model;

import java.sql.SQLException;
import java.util.Map;

public interface ProductDAO {
	
	// idFind 했을 때 map으로 가져옴
	String findUserid(Map<String, String> paraMap) throws SQLException;

	// pwFind 했을 때, 해당 값이 있으면 1을 반환함.
	int pwFindUser(Map<String, String> paraMap) throws SQLException;

	
	
}
