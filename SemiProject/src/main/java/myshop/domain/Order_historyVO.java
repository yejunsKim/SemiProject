package myshop.domain;

public class Order_historyVO {
	
	private int orderno;      
	private String id;
	private String orderdate;
	private int totalamount;
	private int rewarded;
	
	private String itemlist; // 주문 상품 목록: "향수1, 향수2, 향수3..."

	public String getItemlist() {
		return itemlist;
	}

	public void setItemlist(String itemlist) {
		this.itemlist = itemlist;
	}

	public int getOrderno() {
		return orderno;
	}

	public void setOrderno(int orderno) {
		this.orderno = orderno;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getOrderdate() {
		return orderdate;
	}

	public void setOrderdate(String orderdate) {
		this.orderdate = orderdate;
	}

	public int getTotalamount() {
		return totalamount;
	}

	public void setTotalamount(int totalamount) {
		this.totalamount = totalamount;
	}

	public int getRewarded() {
		return rewarded;
	}

	public void setRewarded(int rewarded) {
		this.rewarded = rewarded;
	}
	
	
	
	
}
