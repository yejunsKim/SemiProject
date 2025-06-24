package shop.domain;

public class ItemVO {

	private int itemNo;
	private String itemName;
	private String itemPhotoPath;
	private String itemInfo;
	private int price;
	private int itemAmount;
	private int volume;
    private String company;
    private String infoImg;
    private int fk_category_no;
    
    public ItemVO() {}
    
    
	public ItemVO(int itemNo, String itemName, String itemPhotoPath, String itemInfo, int price, int itemAmount,
			int volume, String company, String infoImg, int fk_category_no) {
		super();
		this.itemNo = itemNo;
		this.itemName = itemName;
		this.itemPhotoPath = itemPhotoPath;
		this.itemInfo = itemInfo;
		this.price = price;
		this.itemAmount = itemAmount;
		this.volume = volume;
		this.company = company;
		this.infoImg = infoImg;
		this.fk_category_no = fk_category_no;
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
	public int getFk_category_no() {
		return fk_category_no;
	}
	public void setFk_category_no(int fk_category_no) {
		this.fk_category_no = fk_category_no;
	}
    
    
    
    
	
}
