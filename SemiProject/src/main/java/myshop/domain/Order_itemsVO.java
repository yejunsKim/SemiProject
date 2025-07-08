package myshop.domain;

public class Order_itemsVO {
	
	private int orderitemno;
	private String orderno;
	private int itemno;
	private int quantity;
	private int orderprice;
	private int deliveryno;
	private Delivery_addressVO delivery_addressVO;
	
	
	public Delivery_addressVO getDelivery_addressVO() {
		return delivery_addressVO;
	}
	public void setDelivery_addressVO(Delivery_addressVO delivery_addressVO) {
		this.delivery_addressVO = delivery_addressVO;
	}
	private ItemVO ivo;
	private Order_historyVO ohvo;
	
	public ItemVO getIvo() {
		return ivo;
	}
	public void setIvo(ItemVO ivo) {
		this.ivo = ivo;
	}
	public Order_historyVO getOhvo() {
		return ohvo;
	}
	public void setOhvo(Order_historyVO ohvo) {
		this.ohvo = ohvo;
	}
	public int getOrderitemno() {
		return orderitemno;
	}
	public void setOrderitemno(int orderitemno) {
		this.orderitemno = orderitemno;
	}
	public String getOrderno() {
		return orderno;
	}
	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	public int getItemno() {
		return itemno;
	}
	public void setItemno(int itemno) {
		this.itemno = itemno;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getOrderprice() {
		return orderprice;
	}
	public void setOrderprice(int orderprice) {
		this.orderprice = orderprice;
	}
	public int getDeliveryno() {
		return deliveryno;
	}
	public void setDeliveryno(int deliveryno) {
		this.deliveryno = deliveryno;
	}
	
}
