package kr.kosmo.jobkorea.myPage.controller;

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
import kr.kosmo.jobkorea.myPage.service.MyPageService;

@Controller
@SessionAttributes("member")
@RequestMapping("/mypage")
public class MyPageController {

   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   @Autowired
   MyPageService mService;
   
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
   
 //회원정보 수정으로 이동
   @RequestMapping(value="/my.my")
   public String my() throws Exception {
	   logger.info("+ Start LoginController.my.my+");
      return "/myPage/userInfo";
   }
   
   //회원정보 수정
   @RequestMapping(value="/memberInfo.my", method = RequestMethod.POST)
	@ResponseBody
	public  Map<String, Object> memberInfo(Model result, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
	   logger.info("+ Start RegisterController memberInfo.my");
		paramMap.put("address", (String)paramMap.get("addr") +","+(String)paramMap.get("addr_detail")+","+(String)paramMap.get("user_post"));
		paramMap.put("tel",  (String)paramMap.get("phone1") +"-"+(String)paramMap.get("phone2")       +"-"+(String)paramMap.get("phone3"));
		paramMap.put("birth",(String)paramMap.get("year") +    (String)paramMap.get("month")      +    (String)paramMap.get("day") );
		
		int re;
		re = mService.memberInfo(paramMap);
		if(re >0){
			logger.info("회원정보 수정 완료");
		}
		
		logger.info("+ End memberInfo.me");
		return null;
	}
   
   //회원탈퇴
   @RequestMapping(value="/bye.my")
   public String bye() throws Exception {
	   logger.info("+ End bye.me");
	   return "/myPage/deleteMember";
   }
   
 //회원탈퇴
   @RequestMapping(value="/deleteMember.my", method = RequestMethod.POST)
   @ResponseBody
   public  Map<String, Object> deleteMember(RegisterInfoModel m,@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
	   logger.info("+ Start RegisterController deleteMember.me");
	   
	   RegisterInfoModel member = (RegisterInfoModel) session.getAttribute("member");
	   
	   //세션 비밀번호
	   String oldPass = member.getPassword();
	   logger.info("oldPassoldPassoldPassoldPass"+oldPass);
	   logger.info("oldPassoldPassoldPassoldPass"+member.getPassword());
	   //사용자 입력 비밀번호
	   String newPass = m.getPassword();
	   logger.info("newPassnewPassnewPassnewPassnewPass"+newPass);
	   
	   Map<String, Object> rMap = new HashMap<String, Object>();
	   
	   if(!(oldPass.equals(newPass))){
		   rMap.put("result", false);
		   return rMap;
	   }
	   paramMap.put("loginID", member.getLoginID());
	    
	   int re;
		re = mService.deleteMember(paramMap);
		if(re >0){
			logger.info("회원탈퇴 완료");
		}
		
		logger.info("+ End deleteMember.me");
		return null;
	}
   
 //주소록 목록
   @RequestMapping(value="/addList.my")
	public  String addList(Model m, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
	   logger.info("+ Start RegisterController addList.me");
		
	   // 세션에 있는 유저 id값 가져오기
	   RegisterInfoModel userVO = (RegisterInfoModel) session.getAttribute("member");
	   userVO.getLoginID();
	    logger.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + userVO.getLoginID());

	    paramMap.put("loginID", userVO.getLoginID());
	    
	    
	    List<Address> ad = mService.userAddress(paramMap);
	    logger.info("@@@@@@@@@@@@@@@@@@@@@@@@@" + ad);
	    m.addAttribute("ad",ad);
	   
		logger.info("+ End addList.me");
		return "/myPage/changAddress";
	}
   
   //주소록 추가
   @RequestMapping(value="/addAddress.my", method = RequestMethod.POST)
   @ResponseBody
   public  Map<String, Object> addAddress(Model result, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
	   logger.info("+ Start RegisterController addAddress.me");
	   RegisterInfoModel userVO = (RegisterInfoModel) session.getAttribute("member");
	   userVO.getLoginID();
	   paramMap.put("loginID", userVO.getLoginID());
	   int re= mService.addAddress(paramMap);
	   if(re >0){
		   logger.info("주소록 추가 완료");
	   }
	   logger.info("+ End addAddress.me");
	   return null;
   }
   
   //주소 조회 후 수정페이지로 이동
   @RequestMapping(value="/selectAddress.my")
   public  String selectAddress(@RequestParam("a_id") int a_id, @RequestParam Map<String, Object> paramMap, Model m, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
	   paramMap.put("a_ID", a_id);
	   Address ad = mService.selectAddress(paramMap);
	   
	   m.addAttribute("ad", ad);
	   
	   logger.info("+++++++++++" + ad);
	   logger.info("+ End selectAddress.me");
	   return "/myPage/editAddress";

   }
   
   //주소록 수정
   @RequestMapping(value="/editAddress.my", method = RequestMethod.POST)
   @ResponseBody
   public  Map<String, Object> editAddress(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
	   logger.info("+++++++++++++ Start RegisterController editAddress.me");
	   RegisterInfoModel userVO = (RegisterInfoModel) session.getAttribute("member");
	   userVO.getLoginID();
	   paramMap.put("loginID", userVO.getLoginID());
	   
	   //Address ad = mService.selectAddress(a_id);
	   int re= mService.editAddress(paramMap);
	   if(re >0){
		   logger.info("주소록 수정 완료");
	   }
	   logger.info("+ End editAddress.my");
	   return null;
   }
   
 //주소록 삭제
   @RequestMapping(value="/deleteAddress.my", method = RequestMethod.POST)
   @ResponseBody
   public  Map<String, Object> deleteAddress(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
	   logger.info("+++++++++++++ Start RegisterController deleteAddress.my");
	   int re=  mService.deleteAddress(paramMap);
	   if(re > 0){
		   logger.info("주소록 삭제 완료");
	   }
	   logger.info("+ End deleteAddress.my");
	   return null;
   }
   
   
   
   
   
   
   
   
   
}