package kr.kosmo.jobkorea.myPage.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import kr.kosmo.jobkorea.login.model.Address;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;
import kr.kosmo.jobkorea.login.model.UsrMnuAtrtModel;
import kr.kosmo.jobkorea.login.model.UsrMnuChildAtrtModel;

public interface MyPageService {
	
	/** 회원 정보 수정*/
	public int memberInfo(Map<String, Object> paramMap) throws Exception;
	
	/** 회원탈퇴*/
	public int deleteMember(Map<String, Object> paramMap)throws Exception;
	
	//주소록 페이지에 회원의 주소록 목록 불러오기
	public List<Address> userAddress(Map<String, Object> paramMap) throws Exception;
	
	//수정할 주소록 한개만 불러오기
	public Address selectAddress(Map<String, Object> paramMap) throws Exception;
	
	//주소록 추가
	public int addAddress(Map<String, Object> paramMap) throws Exception;
	
	//주소록 수정
	public int editAddress(Map<String, Object> paramMap) throws Exception;
	
	//주소록 삭제
	public int deleteAddress(Map<String, Object> paramMap) throws Exception;

	

}
