package myshop.model;

import java.sql.SQLException;
import java.util.Map;

public interface ProductDAO {
	
	// idFind 했을 때 있으면 n = 1반환되어서 옴.
	String idFind(Map<String, String> paraMap) throws SQLException;

	
	
}
