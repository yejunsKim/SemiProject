package myshop.domain;

public class CategoryVO {
	
	private int categoryNo;				// 카테고리번호
    private String categoryName;		// 카테고리명
    private String categoryImagePath;	// 카테고리이미지파일경로
    
    public CategoryVO() {}
    
    public CategoryVO(int categoryNo, String categoryName, String categoryImagePath) {
		this.categoryNo = categoryNo;
		this.categoryName = categoryName;
		this.categoryImagePath = categoryImagePath;
	}

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
