package myshop.domain;

import user.domain.UserVO;

public class ReviewReactionVO {

	private String fk_id; //회원아이디
	private int	fk_reviewId;	//리뷰번호 -seq
	
	private UserVO userVO;
	private ReviewVO reviewVO;
	
	public String getFk_id() {
		return fk_id;
	}
	public void setFk_id(String fk_id) {
		this.fk_id = fk_id;
	}
	public int getFk_reviewId() {
		return fk_reviewId;
	}
	public void setFk_reviewId(int fk_reviewId) {
		this.fk_reviewId = fk_reviewId;

	}
	public UserVO getUserVO() {
		return userVO;
	}
	public void setUserVO(UserVO userVO) {
		this.userVO = userVO;
	}
	public ReviewVO getReviewVO() {
		return reviewVO;
	}
	public void setReviewVO(ReviewVO reviewVO) {
		this.reviewVO = reviewVO;
	}
	
	
	
	
	
}
