package kr.kosmo.jobkorea.login.model;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class RegisterInfoModel {

	private String loginID ;
	private String user_type;
	private String name;
	private String password;
	private String tel;
	private String sex;
	private String birth;
	private String mail;
	private String addr;
	private String join_date;
	private String pid;
	private String std_Id;
	private String rs_fname;
	private String rs_url;
	private String rs_fsize;
	private String comp_name;
	private String comp_addr;
	private String comp_tel;
	private String comp_mail;
	
	//정이안 registerList.jsp 사용
	private String lec_name;//강의명
	private String std_num; // 학번
	private String atd;//출석률
	
	private int che;
}
