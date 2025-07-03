package myshop.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import myshop.domain.CartVO;
import myshop.domain.CategoryVO;
import myshop.domain.ItemVO;

public interface ItemDAO {

	// 상품의 전체 개수를 알아온다.
	int totalCount() throws SQLException;
	
	// 메인페이지에 보여지는 카테고리(이미지파일경로)을 조회(select)하는 메소드
	List<CategoryVO> imageSelectAll() throws SQLException;
	
	// 카테고리별 상품의 전체 개수를 알아온다.
	int totalCount(String categoryNo) throws SQLException;
	
	// 더보기 방식(페이징처리)으로 상품정보를 8개씩 잘라서(start ~ end) 조회해오기 
	List<ItemVO> selectBycategoryName(Map<String, String> paraMap) throws SQLException;
	
	// 카테고리별 더보기 방식(페이징처리)으로 상품정보를 8개씩 잘라서(start ~ end) 조회해오기 
	List<ItemVO> selectBycategoryName2(Map<String, String> paraMap) throws SQLException;
	
	// 해당 카테고리번호에 맞는 카테고리명 가져오기
	String getCategoryName(String categoryNo) throws SQLException;
	
	// 제품 1개 상세 정보 가져오기
	ItemVO selectOneItemByItemNo(int itemNo) throws SQLException;	// <- ItemDAO 
	
	// 장바구니 담기 
	int insertCartOne(Map<String, String> paraMap) throws SQLException;
	
	// 장바구니 목록 가져오기(select)
	List<CartVO> selectItemCart(String fk_users_id) throws SQLException;

	//카테고리 조회
	List<CategoryVO> getCategoryList() throws SQLException;

	//제품번호 채번하기
	int getItemNo() throws SQLException;

	//제품정보 insert하기(제품등록)
	int itemInsert(ItemVO itemVO) throws SQLException;
	
	// 장바구니에서 특정 제품 삭제하기
	int cartDelete(String cartno) throws SQLException;
	
	// 장바구니 테이블에서 선택 제품의 주문량 변경시키기
	int amountUpdate(Map<String, String> paraMap) throws SQLException;
	
	// 장바구니 모두 비우기
	int cartAllDelete(String id) throws SQLException;

	 //로그인 유저의 장바구니 조회.	
	public List<ItemVO> getOrderItem(String id, String[] selectedCartNoArray)throws SQLException;

	int getSearchResultCount(String searchID) throws SQLException;

	List<ItemVO> searchItemsByName(String searchID, int start, int len) throws SQLException;

	

		
}
