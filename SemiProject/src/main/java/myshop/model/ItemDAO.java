package myshop.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import myshop.domain.ItemVO;

public interface ItemDAO {

	// 카테고리별 상품의 전체 개수를 알아온다.
	int totalTenCount(int i) throws SQLException;
	
	// 더보기 방식(페이징처리)으로 상품정보를 8개씩 잘라서(start ~ end) 조회해오기 
	List<ItemVO> selectBycategoryName(Map<String, String> paraMap) throws SQLException;
	
	
	
}
