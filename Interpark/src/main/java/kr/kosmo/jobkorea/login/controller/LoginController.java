package kr.kosmo.jobkorea.login.controller;

import java.io.PrintWriter;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import kr.kosmo.jobkorea.login.service.MailService;
import kr.kosmo.jobkorea.login.model.Address;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;
import kr.kosmo.jobkorea.login.service.LoginService;

@Controller
@RequestMapping("/login")
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

   @RequestMapping(value="/login.me", method = RequestMethod.GET)
   public String index(Model result, @RequestParam Map<String, String> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
	  
	   String referer = request.getHeader("Referer");
	   session.setAttribute("prevPage", referer);
	   logger.info(">>>>>>>>>>>>>>>>>>>>>>>referer1 : " + referer);
	   
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
   @RequestMapping(value="/loginProc.do", method = RequestMethod.POST)
   @ResponseBody
   public Map<String, Object> loginProc(@RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      logger.info("+ Start loginProc.do");
      logger.info("   - loginProc.do ParamMap : " + paramMap);
      String redirectUrl = (String) session.getAttribute("prevPage");
      logger.info(">>>>>>>>>>>>>>>>>>>>>>>referer2 : " + redirectUrl);
      
   /*   if (redirectUrl != null) {
          session.removeAttribute("prevPage");
      }
      */
      
      // 사용자 로그인!
      RegisterInfoModel rm = loginService.loginProc(paramMap);
      String result;
      String resultMsg;
      logger.info("   - rm : " + rm);
      
      if (rm != null) {
         
         result = "SUCCESS";
         resultMsg = "사용자 로그인 정보가 일치 합니다.";
         
         // 사용자 메뉴 권한 조회
         paramMap.put("userType", rm.getUser_type());
        
         session.setAttribute("member", rm);                
      } else {
         
         result = "FALSE";
         resultMsg = "사용자 로그인 정보가 일치하지 않습니다.";
      }
      
      Map<String, Object> resultMap = new HashMap<String, Object>();
      resultMap.put("result", result);
      resultMap.put("resultMsg", resultMsg);
      resultMap.put("redirectUrl", redirectUrl);
      
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
   @RequestMapping(value = "/logOut.do")
   public ModelAndView logOut(SessionStatus sessionStatus, HttpSession session) {
	   
		   logger.info("+ Start " + className + "logOut");
	      ModelAndView mav = new ModelAndView();
	      sessionStatus.setComplete();
	      session.invalidate();
	      logger.info("+ End " + className + "logOut");
	      mav.setViewName("redirect:/index.do");

      return mav;
   }
   
   /**
    *  사용자 id,pw 찾기
    */
   @RequestMapping(value="selectFindInfo.do", method = RequestMethod.POST)
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
   @RequestMapping(value="/ff.me")
   public String findI(Model result, @RequestParam Map<String, String> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {

      return "/login/findIdForm";
   }
   
   // id 찾기 
   @RequestMapping(value="/findId.me")
   public String find_id(HttpServletResponse response, @RequestParam Map<String, String> paramMap, Model m) throws Exception{
	  String id = loginService.find_id(paramMap);
	  m.addAttribute("id", id);
	  
	  response.setContentType("text/html; charset=UTF-8");
	  PrintWriter out = response.getWriter();
		if (id == null) {
			out.println("<script>alert('가입된 아이디가 없습니다.'); location.href=history.go(-1);</script>");
			out.flush();
			return null;
		} else {
			return "/login/findId";
		}
	}
   
 //비밀번호 찾기 페이지 이동
   @RequestMapping(value="/fp.me")
   public String findP() throws Exception {

      return "/login/findPwForm";
   }
	
   // pass 찾기 이메일 발송
   @RequestMapping(value="/findPass.me", method = RequestMethod.POST)
   @ResponseBody
   public Map<String, Object> findPass(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
	   logger.info("+ start " + className + ".findPass");
	   
	   RegisterInfoModel rm = loginService.findIE(paramMap);
	   logger.info("!!!!!!!!!!!"+rm);
	   if(rm == null){
		  paramMap.put("msg", false);
		  /*paramMap.put("msg", "존재하지 않는 아이디거나 메일 등록이 안되어있습니다.");*/
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
   
   
}