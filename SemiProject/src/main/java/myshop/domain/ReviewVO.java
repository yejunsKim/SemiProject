package myshop.domain;

import user.domain.UserVO;

public class ReviewVO {
	
		private int reviewId; //작성번호 -seq
		private String  fk_id; //회원아이디
		private int fk_itemNo; //제품번호
		private String content; //후기내용
		private String  createdAt; //작성일자 -sysdate
		    
		private UserVO userVO;
		private ItemVO itemVO;
		
		public int getReviewId() {
			return reviewId;
		}
		public void setReviewId(int reviewId) {
			this.reviewId = reviewId;
		}
		public String getFk_id() {
			return fk_id;
		}
		public void setFk_id(String fk_id) {
			this.fk_id = fk_id;
		}
		public int getFk_itemNo() {
			return fk_itemNo;
		}
		public void setFk_itemNo(int fk_itemNo) {
			this.fk_itemNo = fk_itemNo;

		}
		public String getContent() {
			return content;
		}
		public void setContent(String content) {
			this.content = content;
		}
		public String getCreatedAt() {
			return createdAt;
		}
		public void setCreatedAt(String createdAt) {
			this.createdAt = createdAt;
		}
		public UserVO getUserVO() {
			return userVO;
		}
		public void setUserVO(UserVO userVO) {
			this.userVO = userVO;
		}
		public ItemVO getItemVO() {
			return itemVO;
		}
		public void setItemVO(ItemVO itemVO) {
			this.itemVO = itemVO;
		}
		
		
}
