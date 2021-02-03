package kr.kosmo.jobkorea.login.model;

public class RegisterInfoModel {

	private String loginID ;		//loginID
	private String user_type;		//user_type
	private String name;			//NAME
	private String password;		//password
	private String birth;			//M_BIRTH
	private String mail;			//M_EMAIL
	private String addres;
	private String user_post;
	private String addr;
	private String addr_detail;
	private String join_date;		//M_REGDATE
	private String pid;
	private String std_Id;
	private String rs_fname;
	private String rs_url;
	private String rs_fsize;
	private String phone1;			//M_PHONE1
	private String phone2;			//M_PHONE2
	private String phone3;			//M_PHONE3
	private String account;			//M_ACCOUNT 계좌번호
	private int mileage;			//M_MILEAGE
	private int totalpay;		//M_PAY 총 구매금액
	private String bkname;		//M_BKNAME 은행이름
	private String status;		//M_STATUS 회원가입상태
	private int a_id;		//A_ID 배송지 번호
	private String grade;		//G_ID 회원등급
	private int che;
	
	public RegisterInfoModel(){}

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public String getAddres() {
		return addres;
	}

	public void setAddres(String addres) {
		this.addres = addres;
	}

	public String getUser_post() {
		return user_post;
	}

	public void setUser_post(String user_post) {
		this.user_post = user_post;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getAddr_detail() {
		return addr_detail;
	}

	public void setAddr_detail(String addr_detail) {
		this.addr_detail = addr_detail;
	}

	public String getJoin_date() {
		return join_date;
	}

	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getStd_Id() {
		return std_Id;
	}

	public void setStd_Id(String std_Id) {
		this.std_Id = std_Id;
	}

	public String getRs_fname() {
		return rs_fname;
	}

	public void setRs_fname(String rs_fname) {
		this.rs_fname = rs_fname;
	}

	public String getRs_url() {
		return rs_url;
	}

	public void setRs_url(String rs_url) {
		this.rs_url = rs_url;
	}

	public String getRs_fsize() {
		return rs_fsize;
	}

	public void setRs_fsize(String rs_fsize) {
		this.rs_fsize = rs_fsize;
	}

	public String getPhone1() {
		return phone1;
	}

	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}

	public String getPhone2() {
		return phone2;
	}

	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}

	public String getPhone3() {
		return phone3;
	}

	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public int getMileage() {
		return mileage;
	}

	public void setMileage(int mileage) {
		this.mileage = mileage;
	}

	public int getTotalpay() {
		return totalpay;
	}

	public void setTotalpay(int totalpay) {
		this.totalpay = totalpay;
	}

	public String getBkname() {
		return bkname;
	}

	public void setBkname(String bkname) {
		this.bkname = bkname;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getA_id() {
		return a_id;
	}

	public void setA_id(int a_id) {
		this.a_id = a_id;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public int getChe() {
		return che;
	}

	public void setChe(int che) {
		this.che = che;
	}

	@Override
	public String toString() {
		return "RegisterInfoModel [loginID=" + loginID + ", user_type=" + user_type + ", name=" + name + ", password="
				+ password + ", birth=" + birth + ", mail=" + mail + ", addres=" + addres + ", user_post=" + user_post
				+ ", addr=" + addr + ", addr_detail=" + addr_detail + ", join_date=" + join_date + ", pid=" + pid
				+ ", std_Id=" + std_Id + ", rs_fname=" + rs_fname + ", rs_url=" + rs_url + ", rs_fsize=" + rs_fsize
				+ ", phone1=" + phone1 + ", phone2=" + phone2 + ", phone3=" + phone3 + ", account=" + account
				+ ", mileage=" + mileage + ", totalpay=" + totalpay + ", bkname=" + bkname + ", status=" + status
				+ ", a_id=" + a_id + ", grade=" + grade + ", che=" + che + "]";
	}
	
	
	
}
