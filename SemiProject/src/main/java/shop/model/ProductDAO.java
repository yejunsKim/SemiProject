package shop.model;

import java.sql.SQLException;
import java.util.List;

import shop.domain.CategoryVO;

public interface ProductDAO {

	// 메인페이지에 보여지는 카테고리(이미지파일경로)을 조회(select)하는 메소드
	List<CategoryVO> imageSelectAll() throws SQLException;
	


}
