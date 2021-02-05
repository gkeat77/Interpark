package kr.kosmo.jobkorea.login.service;

import java.util.Map;

import kr.kosmo.jobkorea.login.model.RegisterInfoModel;

/* 정수빈 작업 */
public interface RegisterService {
	/** 회원 가입*/
	public int aregister(RegisterInfoModel member)throws Exception;
	public int aregister(Map<String, Object> paramMap) throws Exception;
	public void aregister2(Map<String, Object> paramMap);
	
	/** id 증복 체크 **/
	public RegisterInfoModel id_check(Map<String, Object> paramMap)throws Exception;
	
}
