package myshop.model;

import java.sql.SQLException;
import java.util.Map;

public interface ProductDAO {
	
	// idFind 했을 때 map으로 가져옴
	String findUserid(Map<String, String> paraMap) throws SQLException;

	
	
}
