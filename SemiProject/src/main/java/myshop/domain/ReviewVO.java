package myshop.domain;

import user.domain.UserVO;

public class ReviewVO {
	
		private int reviewId; //작성번호
		private String  id; //회원아이디
		private int itemNo; //제품번호
		private String content; //후기내용
		private String  createdAt; //작성일자
		    
		private UserVO userVO;
		private ItemVO itemVO;
		public int getReviewId() {
			return reviewId;
		}
		public void setReviewId(int reviewId) {
			this.reviewId = reviewId;
		}
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public int getItemNo() {
			return itemNo;
		}
		public void setItemNo(int itemNo) {
			this.itemNo = itemNo;
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
