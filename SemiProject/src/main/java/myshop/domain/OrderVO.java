package myshop.domain;

public class OrderVO {

	
	int orderNo;	//주문코드
	String id; //회원 아이디
	String  orderDate; //주문일자
	int	 totalAmount;  //수량
	int  rewarded; //결제금액 별 포인트
	int   oiNo; //주문상세일련번호
	int   itemNo;//제품번호
	int quantity; //수량
	int orderPrice; //판매가
	int deliveryNo; //배송코드
	
	
	
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	public int getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(int totalAmount) {
		this.totalAmount = totalAmount;
	}
	public int getRewarded() {
		return rewarded;
	}
	public void setRewarded(int rewarded) {
		this.rewarded = rewarded;
	}
	public int getOiNo() {
		return oiNo;
	}
	public void setOiNo(int oiNo) {
		this.oiNo = oiNo;
	}
	public int getItemNo() {
		return itemNo;
	}
	public void setItemNo(int itemNo) {
		this.itemNo = itemNo;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getOrderPrice() {
		return orderPrice;
	}
	public void setOrderPrice(int orderPrice) {
		this.orderPrice = orderPrice;
	}
	public int getDeliveryNo() {
		return deliveryNo;
	}
	public void setDeliveryNo(int deliveryNo) {
		this.deliveryNo = deliveryNo;
	}
	   

}
