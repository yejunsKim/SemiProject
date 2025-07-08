package myshop.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import myshop.domain.CartVO;
import myshop.domain.CategoryVO;
import myshop.domain.ItemVO;
import myshop.domain.Order_historyVO;
import myshop.domain.Order_itemsVO;

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

	// 30일 지난 장바구니 항목 먼저 삭제
	void deleteOldCart(String fk_users_id) throws SQLException;
	
	// 로그인한 유저의 주문 내역의 총 페이지수 알아오기
	int getTotalPage(String id) throws SQLException;

	int getSearchResultCount(String searchID) throws SQLException;

	List<ItemVO> searchItemsByName(String searchID, int start, int len) throws SQLException;

	//로그인 유저의 장바구니 조회.	
	public List<ItemVO> getOrderItem(String id, String[] selectedCartNoArray) throws SQLException;
	
	// 로그인한 본인의 주문목록에서 특정 페이지번호에 해당하는 내용들을 조회해오기
	List<Order_historyVO> select_order_paging(Map<String, String> paraMap) throws SQLException;
	
	// 로그인한 유저의 주문 상세 내역 조회(select)
	List<Order_itemsVO> selectOrderDetail(Map<String, String> paraMap) throws SQLException;

	//주문번호 채번하기
	public int getOrderSequence() throws SQLException;
	
	public int getDeliverySequence() throws SQLException;
	
	public int insertOrderUpdate(Map<String, Object> paraMap) throws SQLException;
	
	// 순수 item 리스트만 추출, cart관련 없음.
	public List<ItemVO> getOrderItemList(String[] itemNoArr) throws SQLException;
	
	
}
