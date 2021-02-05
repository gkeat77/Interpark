package kr.kosmo.jobkorea.login.controller;

import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import kr.kosmo.jobkorea.login.service.MailService;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;
import kr.kosmo.jobkorea.login.service.LoginService;

@Controller
@SessionAttributes("member")
public class LoginController {

   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   @Autowired
   LoginService loginService;
   
   @Autowired
   MailService mailService;

   /**
    * index 접속 시 로그인 페이지로 이동한다.
    * 
    * @param   Model result - Spring model object
    * @param   Map paramMap - Request Param object
    * @param   HttpServletRequest request - Servlet request object
    * @param   HttpServletResponse response - Servlet response object
    * @param   HttpSession session - Http session Object
    * @return   String - page navigator
    * @throws Exception
    */

   @RequestMapping("login.me")
   public String index(Model result, @RequestParam Map<String, String> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start LoginController.login.me");
      return "/login/login";
   }

   /**.
    * 사용자 로그인을 처리한다.
    * 
    * @param   Model result - Spring model object
    * @param   Map paramMap - Request Param object
    * @param   HttpServletRequest request - Servlet request object
    * @param   HttpServletResponse response - Servlet response object
    * @param   HttpSession session - Http session Object
    * @return   String - page navigator
    * @throws Exception
    */
   @RequestMapping("loginProc.do")
   @ResponseBody
   public Map<String, String> loginProc(@RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
	   
      logger.info("+ Start loginProc.do");
      logger.info("   - loginProc.do ParamMap : " + paramMap);

      // 사용자 로그인
      RegisterInfoModel rm = loginService.loginProc(paramMap);
      String result;
      String resultMsg;
      logger.info("   - rm : " + rm);
      if (rm != null) {
         
         result = "SUCCESS";
         resultMsg = "사용자 로그인 정보가 일치 합니다.";
         
         // 사용자 메뉴 권한 조회
         paramMap.put("userType", rm.getUser_type());
        
         session.setAttribute("member", rm);                //   로그인 ID
      } else {
         
         result = "FALSE";
         resultMsg = "사용자 로그인 정보가 일치하지 않습니다.";
      }
            
      Map<String, String> resultMap = new HashMap<String, String>();
      resultMap.put("result", result);
      resultMap.put("resultMsg", resultMsg);
      
      logger.info("+ End LoginController.loginProc.do");
      Enumeration se = session.getAttributeNames();
      while(se.hasMoreElements()){
    	  String getse = se.nextElement()+"";
    	  System.out.println("@@@@@@@ session : "+getse+" : " + session.getAttribute(getse));
    	  }

      return resultMap;
   }
  
   
   /**
    * 로그아웃
    * @param request
    * @param response
    * @param session
    * @return
    */
   @RequestMapping(value = "/loginOut.me")
   public String loginOut(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
                  
      session.invalidate();
      logger.info("+ End LoginController.loginOut.me");
      return "redirect:/login.me";
   }
   
   /**
    *  사용자 id,pw 찾기
    */
   @RequestMapping("selectFindInfo.do")
   @ResponseBody
   public Map<String, Object> selectFindInfo(@RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".selectFindInfo");
      
      logger.info("   - paramMap : " + paramMap);
     /* if(!paramMap.get("cpn_ctr").toString().equals("") && !paramMap.get("cpn_ctr").toString().equals("000")){
         paramMap.put("type", "P");
      }else if(!paramMap.get("eml").toString().equals("")){
         paramMap.put("type", "E");
      }
 */
      String result = "SUCCESS";
      String resultMsg = "조회 성공";
      RegisterInfoModel rm;
      if(paramMap.get("loginID") == null){
         // 사용자 id 조회
    	  rm = loginService.selectFindId(paramMap);
      }else{
         // 사용자 pw 조회
    	  rm = loginService.selectFindPw(paramMap);
      }
      
      Map<String, Object> resultMap = new HashMap<String, Object>();
      resultMap.put("result", result);
      resultMap.put("resultMsg", resultMsg);
      resultMap.put("rm", rm);
      
      logger.info("+ End " + className + ".selectFindInfo");
      
      return resultMap;
   }
   
   //아이디 찾기 페이지 이동
   @RequestMapping("ff.me")
   public String findI(Model result, @RequestParam Map<String, String> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {

      return "/login/findIdForm";
   }
   
   // id 찾기 
   @RequestMapping("findId.me")
   public String find_id(HttpServletResponse response, @RequestParam Map<String, String> paramMap, Model m, RegisterInfoModel vo) throws Exception{
	  String id = loginService.find_id(paramMap, response);
		 logger.info(" fdfdfdfdfdfd" + paramMap.get("mail"));
		 m.addAttribute("id", id);
		
		return "/login/findId";
	}
	
      
   // pass 찾기 이메일 발송
   @RequestMapping("findPass.do")
   @ResponseBody
   public Map<String, Object> findPass(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
	  
	   RegisterInfoModel rm = loginService.findPass(paramMap);
	  
	  if(rm.getMail() == ""||rm.getMail() == null){
		  paramMap.put("msg", "존재하지 않는 아이디거나 메일 등록이 안되어있습니다.");
		  return paramMap;
		  
	  }else{
		  // 받는 사람 이메일 저장
		  paramMap.put("email",rm.getMail());
		  
		  // 난수 생성 후 저장
		  paramMap.put("password", Integer.toString(((int)((Math.random()*99999)))));
		  int pwdUpdate = loginService.findPassUpdate(paramMap);
		  
     	  // 메일 전송
		  int pwdMail = mailService.findPass(paramMap);
		  
		  // 비밀번호 업데이트 성공
		  if( pwdUpdate==1 && pwdMail==1 ){
			paramMap.put("msg", "***"+rm.getMail().substring(3)+" 메일로 비밀번호가 전송 되었습니다.");
			return paramMap;
		  
		  // 비밀번호 업데이트 실패
		  }else{
			paramMap.put("password", paramMap.get("password"));
			pwdUpdate = loginService.findPassUpdate(paramMap);
			paramMap.put("msg", "메일로 비밀번호 전송 실패");
			return paramMap;
		  }
	  }
   }
   
  /* @RequestMapping(value = "findpw.do")
   @ResponseBody
   public void findPwPOST(@ModelAttribute RegisterInfoModel member, HttpServletResponse response) throws Exception{
	   loginService.findPw(response, member);
   }*/
   
   
 //회원정보 수정으로 이동
   @RequestMapping("my.me")
   public String my(Model result, @RequestParam Map<String, String> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
	   logger.info("+ Start LoginController.my.me+");
      return "/myPage/userInfo";
   }
   
   //회원정보 수정
   @RequestMapping("memberInfo.me")
	@ResponseBody
	public  Map<String, Object> memberInfo(Model result, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
	   logger.info("+ Start RegisterController memberInfo.me");
		paramMap.put("address", (String)paramMap.get("addr") +","+(String)paramMap.get("addr_detail")+","+(String)paramMap.get("user_post"));
		paramMap.put("tel",  (String)paramMap.get("phone1") +"-"+(String)paramMap.get("phone2")       +"-"+(String)paramMap.get("phone3"));
		paramMap.put("birth",(String)paramMap.get("year") +    (String)paramMap.get("month")      +    (String)paramMap.get("day") );
		
		int re;
		
		re = loginService.memberInfo(paramMap);
		if(re >0){
			logger.info("회원정보 수정 완료");
		}
		
		logger.info("+ End memberInfo.me");
		return null;
	}
   
 //주소록 수정으로 이동
   @RequestMapping("ca1.me")
   public String ad(HttpSession session) throws Exception {
	   logger.info("+ Start LoginController.ca1.me+");
      return "/myPage/changAddress";
   }
   
 //주소록 수정
   @RequestMapping("addAddress.me")
	@ResponseBody
	public  Map<String, Object> addAddress(Model result, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
	   logger.info("+ Start RegisterController memberInfo.me");
		paramMap.put("address", (String)paramMap.get("addr") +","+(String)paramMap.get("addr_detail")+","+(String)paramMap.get("user_post"));
		paramMap.put("tel",  (String)paramMap.get("phone1") +"-"+(String)paramMap.get("phone2")       +"-"+(String)paramMap.get("phone3"));
		
		
		RegisterInfoModel userVO = (RegisterInfoModel) session.getAttribute("member");
		 
		 
		    // 사용자 정보를 가져올 수 있다.
		    userVO.getLoginID();
		    logger.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + userVO.getLoginID());

		    paramMap.put("loginID", userVO.getLoginID());
		int re;
		
		re = loginService.addAddress(paramMap);
		if(re >0){
			logger.info("주소록 수정 완료");
		}
		
		logger.info("+ End memberInfo.me");
		return null;
	}
   
   
   
   
   
   
   
   
}