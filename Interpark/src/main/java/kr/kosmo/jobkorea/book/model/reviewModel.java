package kr.kosmo.jobkorea.book.model;


public class reviewModel {
	
	private int rId;
	private int pId;
	private String loginId;
	private double rStar;
	private int rLike;
	private String rTitle;
	private String rContent;
	private String rDate;
	private String likeChk;
	
	
	public int getrId() {
		return rId;
	}
	public void setrId(int rId) {
		this.rId = rId;
	}
	public int getpId() {
		return pId;
	}
	public void setpId(int pId) {
		this.pId = pId;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public double getrStar() {
		return rStar;
	}
	public void setrStar(double rStar) {
		this.rStar = rStar;
	}
	public int getrLike() {
		return rLike;
	}
	public void setrLike(int rLike) {
		this.rLike = rLike;
	}
	public String getrTitle() {
		return rTitle;
	}
	public void setrTitle(String rTitle) {
		this.rTitle = rTitle;
	}
	public String getrContent() {
		return rContent;
	}
	public void setrContent(String rContent) {
		this.rContent = rContent;
	}

	public String getrDate() {
		return rDate;
	}
	public void setrDate(String rDate) {
		this.rDate = rDate;
	}
	
	public String getLikeChk() {
		return likeChk;
	}
	public void setLikeChk(String likeChk) {
		this.likeChk = likeChk;
	}
	@Override
	public String toString() {
		return "reviewModel [rId=" + rId + ", pId=" + pId + ", loginId=" + loginId + ", rStar=" + rStar + ", rLike="
				+ rLike + ", rTitle=" + rTitle + ", rContent=" + rContent + ", rDate=" + rDate + ", likeChk=" + likeChk
				+ "]";
	}
	
	
	
}
