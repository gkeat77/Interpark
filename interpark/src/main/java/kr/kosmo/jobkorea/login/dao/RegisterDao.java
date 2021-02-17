package kr.kosmo.jobkorea.login.dao;

import java.util.Map;

import kr.kosmo.jobkorea.login.model.RegisterInfoModel;

public interface RegisterDao {
	
	/** 일반 회원 가입*/
	public int aregister(Map<String, Object> paramMap)throws Exception;
	
	public int aregister(RegisterInfoModel member);
	
	public void aregister2(Map<String, Object> paramMap);
	
	/** id 증복 체크 **/
	public RegisterInfoModel id_check(Map<String, Object> paramMap)throws Exception;

	/** email 중복 체크*/
	public RegisterInfoModel email_check(Map<String, Object> paramMap)throws Exception;

	
}
