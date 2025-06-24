package shop.domain;

public class CategoryVO {
	
	private int categoryNo; 		//카테고리코드
	private String categoryName;		//카테고리명
	private String categoryImagePath;	//카테고리이미지경로
	
	
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getCategoryImagePath() {
		return categoryImagePath;
	}
	public void setCategoryImagePath(String categoryImagePath) {
		this.categoryImagePath = categoryImagePath;
	}
	

	
	
	

}
