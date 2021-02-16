package kr.kosmo.jobkorea.myPage.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.login.model.Address;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;
import kr.kosmo.jobkorea.login.model.UsrMnuAtrtModel;
import kr.kosmo.jobkorea.login.model.UsrMnuChildAtrtModel;

public interface MyPageDao {
	
	/** 회원정보 수정*/
	public int memberInfo(Map<String, Object> paramMap) throws Exception;
	
	/** 회원탈퇴*/
	public int deleteMember(Map<String, Object> paramMap)throws Exception;
	
	//회원 정보 중 주소 추가
	public int addAddress(Map<String, Object> paramMap) throws Exception;

	//주소록에 회원 주소록 가져오기
	public List<Address> userAddress(Map<String, Object> paramMap) throws Exception;

	//수정할 주소록 한개만 불러오기
	public Address selectAddress(Map<String, Object> paramMap) throws Exception;
	
	//회원 정보 중 주소 수정
	public int editAddress(Map<String, Object> paramMap) throws Exception;

	//주소록 삭제
	public int deleteAddress(Map<String, Object> paramMap)throws Exception;





	
	
}