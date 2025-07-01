package myshop.domain;

public class CartVO {
	
	private int cartno;				// 장바구니 번호
	private String fk_users_id;		// 주문자 id
	private int fk_item_no;   		// 제품 번호
	private int cartamount;   		// 제품 수량
	private String cartdate;		// 등록 날짜
	
	private ItemVO ivo;				// 제품 객체 정보
	
	public CartVO() {}
	
	public CartVO(int cartno, String fk_users_id, int fk_item_no, int cartamount, String cartdate) {
		super();
		this.cartno = cartno;
		this.fk_users_id = fk_users_id;
		this.fk_item_no = fk_item_no;
		this.cartamount = cartamount;
		this.cartdate = cartdate;
	}

	public int getCartno() {
		return cartno;
	}

	public void setCartno(int cartno) {
		this.cartno = cartno;
	}

	public String getFk_users_id() {
		return fk_users_id;
	}

	public void setFk_users_id(String fk_users_id) {
		this.fk_users_id = fk_users_id;
	}

	public int getFk_item_no() {
		return fk_item_no;
	}

	public void setFk_item_no(int fk_item_no) {
		this.fk_item_no = fk_item_no;
	}

	public int getCartamount() {
		return cartamount;
	}

	public void setCartamount(int cartamount) {
		this.cartamount = cartamount;
	}

	public String getCartdate() {
		return cartdate;
	}

	public void setCartdate(String cartdate) {
		this.cartdate = cartdate;
	}

	public ItemVO getIvo() {
		return ivo;
	}

	public void setIvo(ItemVO ivo) {
		this.ivo = ivo;
	}
	
	
	
	
}
