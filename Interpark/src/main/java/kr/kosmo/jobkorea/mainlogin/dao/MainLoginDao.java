package kr.kosmo.jobkorea.mainlogin.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.mainlogin.model.MainChildUsrMnuModel;
import kr.kosmo.jobkorea.mainlogin.model.MainLoginInfoModel;
import kr.kosmo.jobkorea.mainlogin.model.MainUsrMnuModel;


public interface MainLoginDao {
	
	/* 사용자 로그인  체크*/
	public String checkMainLogin(Map<String, Object> paramMap);
	
	/* 사용자 로그인 */
	public MainLoginInfoModel MainLogin(Map<String, Object> paramMap);
	
	/* 사용자 메뉴 권한 */
	public List<MainUsrMnuModel> listMainUsrMnu(Map<String, Object> paramMap);
	
	/* 사용자 자식 메뉴 권한 */
	public List<MainChildUsrMnuModel> listMainChildUsrMnu(Map<String, Object> paramMap);
}
