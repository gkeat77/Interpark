package kr.kosmo.jobkorea.myPage.service;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.common.comnUtils.AESCryptoHelper;
import kr.kosmo.jobkorea.common.comnUtils.ComnUtil;
import kr.kosmo.jobkorea.myPage.dao.MyPageDao;
import kr.kosmo.jobkorea.login.model.Address;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;
import kr.kosmo.jobkorea.login.model.UsrMnuAtrtModel;
import kr.kosmo.jobkorea.login.model.UsrMnuChildAtrtModel;

@Service
public class MyPageServiceImpl implements MyPageService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired
	private MyPageDao dao;
	

	@Override
	public int memberInfo(Map<String, Object> paramMap) throws Exception {
		return dao.memberInfo(paramMap);
	}
	
	@Override
	public int deleteMember(Map<String, Object> paramMap) throws Exception{
		// TODO Auto-generated method stub
		return dao.deleteMember(paramMap);
	}

	@Override
	public List<Address> userAddress(Map<String, Object> paramMap) throws Exception {
		return dao.userAddress(paramMap);
	}

	@Override
	public int addAddress(Map<String, Object> paramMap) throws Exception {
		return dao.addAddress(paramMap);
	}

	@Override
	public int editAddress(Map<String, Object> paramMap) throws Exception {
		return dao.editAddress(paramMap);
	}

	//수정할 주소록 한개만 불러오기
	@Override
	public Address selectAddress(Map<String, Object> paramMap) throws Exception {
		return dao.selectAddress(paramMap);
	}

	//주소록 삭제
	@Override
	public int deleteAddress(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return dao.deleteAddress(paramMap);
	}
}
