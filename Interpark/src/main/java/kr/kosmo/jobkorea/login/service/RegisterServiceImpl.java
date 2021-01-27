package kr.kosmo.jobkorea.login.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.login.dao.RegisterDao;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;

@Service
public class RegisterServiceImpl implements RegisterService{
	
	@Autowired
	private RegisterDao registerDao;
	
	/** 일반 회원 가입*/
	@Override
	public String aregister(Map<String, Object> paramMap) throws Exception {
		registerDao.aregister(paramMap);
		return null;
	}

	/** 강사 회원 가입*/
	@Override
	public String bregister(Map<String, Object> paramMap) throws Exception {
		registerDao.bregister(paramMap);
		return null;
	}
	
	/** 관리자 회원 가입*/
	@Override
	public String dregister(Map<String, Object> paramMap) throws Exception {
		registerDao.dregister(paramMap);
		return null;
	}

	/** id 중복 체크*/
	@Override
	public RegisterInfoModel id_check(Map<String, Object> paramMap) throws Exception {
		return registerDao.id_check(paramMap);
	}
}
