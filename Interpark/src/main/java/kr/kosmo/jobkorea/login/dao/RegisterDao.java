package kr.kosmo.jobkorea.login.dao;

import java.util.Map;

import kr.kosmo.jobkorea.login.model.RegisterInfoModel;

public interface RegisterDao {
	
	/** 일반 회원 가입*/
	public int aregister(Map<String, Object> paramMap);
	
	/** 강사 회원 가입*/
	public int bregister(Map<String, Object> paramMap);
	
	/** 기업 회원 가입*/
	public int dregister(Map<String, Object> paramMap);
	
	/** id 증복 체크 **/
	public RegisterInfoModel id_check(Map<String, Object> paramMap)throws Exception;
	
}
