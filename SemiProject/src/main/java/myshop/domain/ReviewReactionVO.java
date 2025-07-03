package myshop.domain;

import user.domain.UserVO;

public class ReviewReactionVO {

	private String id; //회원아이디
	private int	reviewId;	//리뷰번호 -seq
	
	private UserVO userVO;
	private ReviewVO reviewVO;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getReviewId() {
		return reviewId;
	}
	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
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
