package kr.kosmo.jobkorea.login.model;

public class Address {

	private int a_ID;
	private String a_TITLE;
	private String a_AD1;
	private String a_AD2;
	private String a_AD3;
	private String a_PHONE1;
	private String a_PHONE2;
	private String a_PHONE3;
	private String a_NAME;
	private String loginID ;		//loginID
	private int che;
	
	public Address(){}

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public String getA_AD1() {
		return a_AD1;
	}

	public void setA_AD1(String a_AD1) {
		this.a_AD1 = a_AD1;
	}

	public String getA_AD2() {
		return a_AD2;
	}

	public void setA_AD2(String a_AD2) {
		this.a_AD2 = a_AD2;
	}

	public String getA_AD3() {
		return a_AD3;
	}

	public void setA_AD3(String a_AD3) {
		this.a_AD3 = a_AD3;
	}

	public int getA_ID() {
		return a_ID;
	}

	public void setA_ID(int a_ID) {
		this.a_ID = a_ID;
	}

	public String getA_NAME() {
		return a_NAME;
	}

	public void setA_NAME(String a_NAME) {
		this.a_NAME = a_NAME;
	}

	public String getA_PHONE1() {
		return a_PHONE1;
	}

	public void setA_PHONE1(String a_PHONE1) {
		this.a_PHONE1 = a_PHONE1;
	}

	public String getA_PHONE2() {
		return a_PHONE2;
	}

	public void setA_PHONE2(String a_PHONE2) {
		this.a_PHONE2 = a_PHONE2;
	}

	public String getA_PHONE3() {
		return a_PHONE3;
	}

	public void setA_PHONE3(String a_PHONE3) {
		this.a_PHONE3 = a_PHONE3;
	}

	public String getA_TITLE() {
		return a_TITLE;
	}

	public void setA_TITLE(String a_TITLE) {
		this.a_TITLE = a_TITLE;
	}

	public int getChe() {
		return che;
	}

	public void setChe(int che) {
		this.che = che;
	}

	@Override
	public String toString() {
		return "Address [loginID=" + loginID + ", a_AD1=" + a_AD1 + ", a_AD2=" + a_AD2 + ", a_AD3=" + a_AD3 + ", a_ID="
				+ a_ID + ", a_NAME=" + a_NAME + ", a_PHONE1=" + a_PHONE1 + ", a_PHONE2=" + a_PHONE2 + ", a_PHONE3="
				+ a_PHONE3 + ", a_TITLE=" + a_TITLE + ", che=" + che + "]";
	}

	
	
	
}
