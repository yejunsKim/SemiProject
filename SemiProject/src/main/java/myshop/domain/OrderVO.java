package myshop.domain;

import java.util.List;

public class OrderVO {
    private int orderNo;           // 주문번호 (PK)
    private String id;             // 회원아이디 (FK)
    private String orderDate;      // 주문일자
    private int totalAmount;       // 총수량
    private int rewarded;          // 포인트

    private List<OrderItemVO> orderItemList; // 주문상세 목록

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
    public List<OrderItemVO> getOrderItemList() {
        return orderItemList;
    }
    public void setOrderItemList(List<OrderItemVO> orderItemList) {
        this.orderItemList = orderItemList;
    }
}