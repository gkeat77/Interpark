package kr.kosmo.jobkorea.login.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.login.model.LgnInfoModel;
import kr.kosmo.jobkorea.login.model.UsrMnuAtrtModel;
import kr.kosmo.jobkorea.login.model.UsrMnuChildAtrtModel;

public interface LoginDao {
	
	/** 사용자 로그인 체크*/
	public String checkLogin(Map<String, Object> paramMap);
	
	/** 사용자 로그인 */
	public LgnInfoModel selectLogin(Map<String, Object> paramMap);
	
	/**  사용자 메뉴 권한 */
	public List<UsrMnuAtrtModel> listUsrMnuAtrt(Map<String, Object> paramMap);
	
	/**  사용자 자식 메뉴 권한 */
	public List<UsrMnuChildAtrtModel> listUsrChildMnuAtrt(Map<String, Object> paramMap);
	
	/** 사용자 ID 찾기 */
	public LgnInfoModel selectFindId(Map<String, Object> paramMap);

	/** 사용자 PW 찾기 */
	public LgnInfoModel selectFindPw(Map<String, Object> paramMap);

	/** 이메일 유무 확인 ID 찾기 */
	public List<LgnInfoModel> findId(Map<String, Object> paramMap);

	/** 아이디 유무 확인 pass 전송**/
	public LgnInfoModel findPass(Map<String, Object> paramMap) throws Exception;
	
	/** 비밀번호 재발급 **/
	public int findPassUpdate(Map<String, Object> paramMap) throws Exception;	
}