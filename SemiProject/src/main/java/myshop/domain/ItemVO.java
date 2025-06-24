package myshop.domain;

public class ItemVO {
	
	private int itemNo;					// 제품번호
    private String itemName;			// 제품명
    private String itemPhotoPath ;		// 제품이미지
    private String itemInfo;			// 제품상세정보
    private int price;					// 제품 가격
    private int itemAmount;				// 재고
    private int volume;					// 용량
    private String company;				// 제조사명
    private String infoImg;				// 제품상세이미지
    private int fk_catagory_no;			// 카테고리번호 참조
    
    private CategoryVO categvo; 		// 카테고리VO
    
    public ItemVO() {}

	public ItemVO(int itemNo, String itemName, String itemPhotoPath, String itemInfo, int price, int itemAmount,
			int volume, String company, String infoImg, CategoryVO categvo, int fk_catagory_no) {
		this.itemNo = itemNo;
		this.itemName = itemName;
		this.itemPhotoPath = itemPhotoPath;
		this.itemInfo = itemInfo;
		this.price = price;
		this.itemAmount = itemAmount;
		this.volume = volume;
		this.company = company;
		this.infoImg = infoImg;
		this.categvo = categvo;
		this.fk_catagory_no = fk_catagory_no;
	}

	public int getItemNo() {
		return itemNo;
	}

	public void setItemNo(int itemNo) {
		this.itemNo = itemNo;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getItemPhotoPath() {
		return itemPhotoPath;
	}

	public void setItemPhotoPath(String itemPhotoPath) {
		this.itemPhotoPath = itemPhotoPath;
	}

	public String getItemInfo() {
		return itemInfo;
	}

	public void setItemInfo(String itemInfo) {
		this.itemInfo = itemInfo;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getItemAmount() {
		return itemAmount;
	}

	public void setItemAmount(int itemAmount) {
		this.itemAmount = itemAmount;
	}

	public int getVolume() {
		return volume;
	}

	public void setVolume(int volume) {
		this.volume = volume;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getInfoImg() {
		return infoImg;
	}

	public void setInfoImg(String infoImg) {
		this.infoImg = infoImg;
	}

	public CategoryVO getCategvo() {
		return categvo;
	}

	public void setCategvo(CategoryVO categvo) {
		this.categvo = categvo;
	}

	public int getFk_catagory_no() {
		return fk_catagory_no;
	}

	public void setFk_catagory_no(int fk_catagory_no) {
		this.fk_catagory_no = fk_catagory_no;
	}
    
    
	
	
	
    
    
    
}
