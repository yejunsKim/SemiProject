package myshop.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import myshop.domain.CategoryVO;
import myshop.domain.ItemVO;

public interface ItemDAO {

	// 상품의 전체 개수를 알아온다.
	int totalCount() throws SQLException;
	
	// 카테고리별 상품의 전체 개수를 알아온다.
	int totalCount(String categoryNo) throws SQLException;
	
	// 더보기 방식(페이징처리)으로 상품정보를 8개씩 잘라서(start ~ end) 조회해오기 
	List<ItemVO> selectBycategoryName(Map<String, String> paraMap) throws SQLException;
	
	// 카테고리별 더보기 방식(페이징처리)으로 상품정보를 8개씩 잘라서(start ~ end) 조회해오기 
	List<ItemVO> selectBycategoryName2(Map<String, String> paraMap) throws SQLException;
	
	// 메인페이지에 보여지는 카테고리(이미지파일경로)을 조회(select)하는 메소드
	List<CategoryVO> imageSelectAll() throws SQLException;
	
	// 해당 카테고리번호에 맞는 카테고리명 가져오기
	String getCategoryName(String categoryNo) throws SQLException;
	
}
