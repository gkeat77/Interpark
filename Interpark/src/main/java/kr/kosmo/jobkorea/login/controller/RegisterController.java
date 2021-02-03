package kr.kosmo.jobkorea.login.controller;
import kr.kosmo.jobkorea.common.comnUtils.ComnUtil;
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

import kr.kosmo.jobkorea.login.model.RegisterInfoModel;
import kr.kosmo.jobkorea.login.service.RegisterService;

@Controller
public class RegisterController {
	// Set logger
	   private final Logger logger = LogManager.getLogger(this.getClass());

	   // Get class name for logger
	   private final String className = this.getClass().toString();
	   

	@Autowired
	RegisterService registerService;
	
	
	 @RequestMapping(value="reg.do", method = RequestMethod.GET)
	   public String index(Model result, @RequestParam Map<String, String> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {

	      logger.info("+ Start RegisterController.reg.do");
	  
	      return "/login/register";
	   }
	 
	@RequestMapping("aregister.do")
	@ResponseBody
		public String aregiste(Model result, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,  HttpServletResponse response, HttpSession session) throws Exception {
			
		 	logger.info("+ Start aregister.do");
			paramMap.put("addr", (String)paramMap.get("addr") +","+(String)paramMap.get("addr_detail")+","+(String)paramMap.get("user_post"));
			paramMap.put("tel",  (String)paramMap.get("tel1") +"-"+(String)paramMap.get("tel2")       +"-"+(String)paramMap.get("tel3"));
			paramMap.put("birth",(String)paramMap.get("year") +    (String)paramMap.get("month")      +    (String)paramMap.get("day") );
			 
			registerService.aregister(paramMap);
			logger.info("+ End aregister.do");
			return null;
	 }
	 
 	/*@RequestMapping("aregister.do")
	@ResponseBody
	public String aregiste(RegisterInfoModel member, Model m, HttpServletRequest request, @RequestParam String user_post, 
			@RequestParam String addr,@RequestParam String addr_detail, @RequestParam String tel1, @RequestParam String tel2, 
			@RequestParam String tel3, @RequestParam String year, @RequestParam String month, @RequestParam String day,
			HttpServletResponse response) throws Exception {
		
		String address = addr + addr_detail + user_post;
		String tel = tel1 + tel2 + tel3;
		String birth = year + month + day;
		
		member.setAddres(address);
		member.setBirth(birth);
		member.setPhone1(tel);
		
		int re = registerService.aregister(member);

		if(re > 0){
			logger.info("회원등록 성공");
		}else{
			logger.info("회원등록 실패");
		}
		
		return "/login/login";
	}*/
	
	@RequestMapping("id_check.do")
	@ResponseBody
	public  Map<String, Object> id_check(Model result, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		if(registerService.id_check(paramMap).getChe()==1){
			
			paramMap.put("OK", "N");
			return paramMap;
		}else{
			paramMap.put("OK", "Y");
			return paramMap;
		}
	}
	

}