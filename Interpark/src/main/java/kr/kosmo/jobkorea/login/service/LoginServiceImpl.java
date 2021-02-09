package kr.kosmo.jobkorea.login.service;

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
import kr.kosmo.jobkorea.login.dao.LoginDao;
import kr.kosmo.jobkorea.login.model.Address;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;
import kr.kosmo.jobkorea.login.model.UsrMnuAtrtModel;
import kr.kosmo.jobkorea.login.model.UsrMnuChildAtrtModel;

@Service
public class LoginServiceImpl implements LoginService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired
	private LoginDao loginDao;
	
	/** 사용자 로그인 체크*/
	public String checkLogin(Map<String, Object> paramMap) throws Exception {
		return loginDao.checkLogin(paramMap);
	}
	
	/** 사용자 로그인 */
	public RegisterInfoModel loginProc(Map<String, Object> paramMap) throws Exception {
		//String password = paramMap.get("pwd").toString();
		
		//logger.info(" login before password : " + password);
		//AES 방식 암호화
		//password = AESCryptoHelper.encode( ComnUtil.AES_KEY, password);
		
		//logger.info(" login after password : " + password);
		//paramMap.put("pwd", password);
		return loginDao.selectLogin(paramMap);
	}
	
	
	/**  사용자 메뉴 권한 */
	public List<UsrMnuAtrtModel> listUsrMnuAtrt(Map<String, Object> paramMap) throws Exception {	
		return loginDao.listUsrMnuAtrt(paramMap);
	}
	

	/**  사용자 자식 메뉴 권한 */
	public List<UsrMnuChildAtrtModel> listUsrChildMnuAtrt(Map<String, Object> paramMap) throws Exception{
		return loginDao.listUsrChildMnuAtrt(paramMap);

	}

	/** 사용자 ID 찾기 */
	public RegisterInfoModel selectFindId(Map<String, Object> paramMap) throws Exception{
		return loginDao.selectFindId(paramMap);
	}

	/** 사용자 PW 찾기 */
	public RegisterInfoModel selectFindPw(Map<String, Object> paramMap) throws Exception{
		String password = paramMap.get("password").toString();
		//AES 방식 암호화
		password = AESCryptoHelper.encode( ComnUtil.AES_KEY, password);
		paramMap.put("password", password);
		return loginDao.selectFindPw(paramMap);
	}


	/** 아이디 유무 확인 pass 전송**/
	@Override
	public RegisterInfoModel findPass(Map<String, Object> paramMap) throws Exception {
		return loginDao.findPass(paramMap);
	}

	/** 비밀번호 재발급 **/
	@Override
	public int findPassUpdate(Map<String, Object> paramMap) throws Exception {
		return loginDao.findPassUpdate(paramMap);
	}

	//아이디 찾기
	@Override
	public String find_id(Map<String, String> paramMap, HttpServletResponse response) throws Exception {

		PrintWriter out = response.getWriter();
		String id = loginDao.find_id(paramMap);
		if (id == null) {
			out.println("<script>");
			out.println("alert('가입된 아이디가 없습니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			return null;
		} else {
			return id;
		}
	}

	//회원정보 수정
		@Override
		public int memberInfo(Map<String, Object> paramMap) throws Exception{
			// TODO Auto-generated method stub
			return loginDao.memberInfo(paramMap);
		}

		
	//회원 정보 중 주소 추가
	@Override
	public int addAddress(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return loginDao.addAddress(paramMap);
	}
	
	//Adress 테이블에서 정보 가져오기
	@Override
	public List<Address> userAddress(Map<String, Object> paramMap) throws Exception{
		// TODO Auto-generated method stub
		return loginDao.userAddress(paramMap);
	}

	//회원 정보 중 주소 수정
	@Override
	public int editAddress(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return loginDao.editAddress(paramMap);
	}
		
}
