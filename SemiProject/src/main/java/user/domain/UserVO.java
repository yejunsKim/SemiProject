package user.domain;

public class UserVO {
	
	private String id;
	private String password;    // 비밀번호 (SHA-256 암호화 대상)
	private String name;
	private String email;  // 이메일 (AES-256 암호화/복호화 대상)
	private String mobile; // 연락처 (AES-256 암호화/복호화 대상) 
	private String postcode;
	private String address;
	private String addressDetail;
	private String addressExtra;

	private int point;  
	private String grade;   // bronze silver gold
	private String registerday; 
	private String passwordChanged; // 마지막으로 암호를 변경한 날짜  
	private String isDeleted;  // 회원탈퇴유무   N: 사용가능(가입중) / Y:사용불능(탈퇴)
	private String isDormant;    // 휴면유무  N : 활동중  /  Y : 휴면중 
	
	
	// DAO 구현의 sql로 받아온 3개월 비밀번호 주기를 알아온 인스턴스
	private boolean requirePasswordChange = false;
	// 마지막으로 암호를 변경한 날짜가 3개월 지났다면 true이고 아니라면 false
	public boolean isRequirePasswordChange() {
		return requirePasswordChange;
	}
	public void setRequirePasswordChange(boolean requirePwdChange) {
		this.requirePasswordChange = requirePwdChange;
	}
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddressDetail() {
		return addressDetail;
	}
	public void setAddressDetail(String addressDetail) {
		this.addressDetail = addressDetail;
	}
	public String getAddressExtra() {
		return addressExtra;
	}
	public void setAddressExtra(String addressExtra) {
		this.addressExtra = addressExtra;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getRegisterday() {
		return registerday;
	}
	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}
	public String getIsDeleted() {
		return isDeleted;
	}
	public void setIsDeleted(String isDeleted) {
		this.isDeleted = isDeleted;
	}
	public String getIsDormant() {
		return isDormant;
	}
	public void setIsDormant(String isDormant) {
		this.isDormant = isDormant;
	}
	public String getPasswordChanged() {
		return passwordChanged;
	}
	public void setPasswordChanged(String passwordChanged) {
		this.passwordChanged = passwordChanged;
	}
	

	
	
} 