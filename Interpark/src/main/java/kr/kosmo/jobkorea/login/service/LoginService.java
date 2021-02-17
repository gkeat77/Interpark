package kr.kosmo.jobkorea.login.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import kr.kosmo.jobkorea.login.model.Address;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;
import kr.kosmo.jobkorea.login.model.UsrMnuAtrtModel;
import kr.kosmo.jobkorea.login.model.UsrMnuChildAtrtModel;

public interface LoginService {
	
	/** 사용자 로그인 체크*/
	public String checkLogin(Map<String, Object> paramMap) throws Exception;
	
	/** 사용자 로그인 */
	public RegisterInfoModel loginProc(Map<String, Object> paramMap) throws Exception;
	
	/** 사용자 메뉴 권한 */
	public List<UsrMnuAtrtModel> listUsrMnuAtrt(Map<String, Object> paramMap) throws Exception;
	
	/**  사용자 자식 메뉴 권한 */
	public List<UsrMnuChildAtrtModel> listUsrChildMnuAtrt(Map<String, Object> paramMap) throws Exception;
	
	/** 사용자 ID 찾기 */
	public RegisterInfoModel selectFindId(Map<String, Object> paramMap) throws Exception;

	/** 사용자 PW 찾기 */
	public RegisterInfoModel selectFindPw(Map<String, Object> paramMap) throws Exception;

	/** 비밀번호 찾기 위한 아이디&이메일 유무 확인 전송**/
	public RegisterInfoModel findIE(Map<String, Object> paramMap) throws Exception;

	/** 비밀번호 재발급 **/
	public int findPassUpdate(Map<String, Object> paramMap) throws Exception;
	
	//아이디 찾기
	public String find_id(Map<String, String> paramMap) throws Exception;
	

	
	
}
