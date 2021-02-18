package kr.kosmo.jobkorea.payment.model;

public class PaymentModel {

	private String cartNo;
	private String bookName;
	private int price;
	private int stock;
	private String bookImg;
	
	
	private String userName;
	private String userEmail;
	private String userPhone;
	private String userAddress1;
	private int userState;
	
	
	private String totalPrice;
	private String cartNos;
	
	private String payNo;
	
	private String loginID;
	
	private String regDt;
	
	private String couponName;
	private String couponNo;
	private String couponPrice;
	private String couponRate;
	private String couponNos;
	
	private String mileage;
	
	
	private String pId;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public String getpId() {
		return pId;
	}
	public void setpId(String pId) {
		this.pId = pId;
	}
	public String getMileage() {
		return mileage;
	}
	public void setMileage(String mileage) {
		this.mileage = mileage;
	}
	public String getCouponNos() {
		return couponNos;
	}
	public void setCouponNos(String couponNos) {
		this.couponNos = couponNos;
	}
	public String getCouponPrice() {
		return couponPrice;
	}
	public void setCouponPrice(String couponPrice) {
		this.couponPrice = couponPrice;
	}
	public String getCouponNo() {
		return couponNo;
	}
	public void setCouponNo(String couponNo) {
		this.couponNo = couponNo;
	}
	
	public String getCouponRate() {
		return couponRate;
	}
	public void setCouponRate(String couponRate) {
		this.couponRate = couponRate;
	}
	public String getCouponName() {
		return couponName;
	}
	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public int getUserState() {
		return userState;
	}
	public void setUserState(int userState) {
		this.userState = userState;
	}
	public String getPayNo() {
		return payNo;
	}
	public void setPayNo(String payNo) {
		this.payNo = payNo;
	}
	public String getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(String totalPrice) {
		this.totalPrice = totalPrice;
	}
	public String getCartNos() {
		return cartNos;
	}
	public void setCartNos(String cartNos) {
		this.cartNos = cartNos;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public String getUserAddress1() {
		return userAddress1;
	}
	public void setUserAddress1(String userAddress1) {
		this.userAddress1 = userAddress1;
	}
	
	public String getBookImg() {
		return bookImg;
	}
	public void setBookImg(String bookImg) {
		this.bookImg = bookImg;
	}
	public String getCartNo() {
		return cartNo;
	}
	public void setCartNo(String cartNo) {
		this.cartNo = cartNo;
	}
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	@Override
	public String toString() {
		return "PaymentModel [cartNo=" + cartNo + ", bookName=" + bookName + ", price=" + price + ", stock=" + stock
				+ ", bookImg=" + bookImg + "]";
	}
	
	
	
	
}


