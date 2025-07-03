package myshop.domain;

public class OrderItemVO {
    private int orderItemNO;       // 주문상세번호 (PK) - seq
    private int orderNo;    // 주문번호 (FK) 
    private int itemNo;     // 제품번호 (FK)
    private int quantity;   // 주문수량
    private int orderPrice; // 주문 당시 가격
    private int deliveryNo; // 배송코드 (FK)

    public int getOiNo() {
        return orderItemNO;
    }
    public void setOiNo(int oiNo) {
        this.orderItemNO = oiNo;
    }
    public int getOrderNo() {
        return orderNo;
    }
    public void setOrderNo(int orderNo) {
        this.orderNo = orderNo;
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