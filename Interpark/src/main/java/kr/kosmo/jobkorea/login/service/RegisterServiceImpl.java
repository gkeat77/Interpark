package kr.kosmo.jobkorea.login.service;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

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
	public int aregister(RegisterInfoModel member) throws Exception {
		return registerDao.aregister(member);
	}
	
	/** 일반 회원 가입*/
	@Override
	public int aregister(Map<String, Object> paramMap) throws Exception {
		return registerDao.aregister(paramMap);
	}
	
	//회원가입시 주소록에 주소 넣기
	@Override
	public void aregister2(Map<String, Object> paramMap) {
		registerDao.aregister2(paramMap);
		
	}

	/** id 중복 체크*/
	@Override
	public RegisterInfoModel id_check(Map<String, Object> paramMap) throws Exception {
		return registerDao.id_check(paramMap);
	}

	/** email 중복 체크*/
	@Override
	public RegisterInfoModel email_check(Map<String, Object> paramMap) throws Exception {
		
		return registerDao.email_check(paramMap); 
		}
	
	
	


	
	



	



	
}
