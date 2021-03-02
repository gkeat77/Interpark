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
import org.springframework.web.bind.annotation.SessionAttributes;

import kr.kosmo.jobkorea.login.model.RegisterInfoModel;
import kr.kosmo.jobkorea.login.service.RegisterService;

@Controller
@RequestMapping("/register")
public class RegisterController {
	// Set logger
	   private final Logger logger = LogManager.getLogger(this.getClass());

	   // Get class name for logger
	   private final String className = this.getClass().toString();
	   

	@Autowired
	RegisterService registerService;
	
	
	 @RequestMapping(value="/reg.re")
	   public String index(Model result, @RequestParam Map<String, String> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {

	      logger.info("+ Start RegisterController.reg.me");
	      String mail = request.getParameter("mail");
	      logger.info("asdfdfsadfsdfddas : " + mail);
	      result.addAttribute("mail", mail);
	      return "/login/register";
	   }
	 
	@RequestMapping(value="/aregister.re", method = RequestMethod.POST)
	@ResponseBody
		public String aregiste(@RequestParam Map<String, Object> paramMap, HttpServletRequest request,  HttpServletResponse response, HttpSession session) throws Exception {
			
		 	logger.info("+ Start aregister.do");
			paramMap.put("address", (String)paramMap.get("addr") +","+(String)paramMap.get("addr_detail")+","+(String)paramMap.get("user_post"));
			paramMap.put("tel",  (String)paramMap.get("phone1") +"-"+(String)paramMap.get("phone2")       +"-"+(String)paramMap.get("phone3"));
			paramMap.put("birth",(String)paramMap.get("year") +    (String)paramMap.get("month")      +    (String)paramMap.get("day") );
			
			int re;
			
			re = registerService.aregister(paramMap);
			if(re >0){
				//registerService.aregister2(paramMap);
			}
			logger.info("+ End aregister.do");
			return null;
	 }
	
	@RequestMapping(value="/id_check.re", method = RequestMethod.POST)
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
	
	//가입 여부 확인
	@RequestMapping(value="/chre.re")
	public String chre() throws Exception {

      logger.info("+ Start RegisterController.chre.me");
  
      return "/login/checkRegister";
	}
	
	@RequestMapping(value="/email_check.re")
	public String email_check(Model m, HttpServletRequest request, HttpServletResponse response,@RequestParam Map<String, Object> paramMap) throws Exception {
		String mail = request.getParameter("mail");
		if(registerService.email_check(paramMap).getChe()>0){
			m.addAttribute("email", "no");
			m.addAttribute("OK1", "가입된 이메일이 있습니다.");
			m.addAttribute("OK2", "아이디가 기억나지 않는다면 아이디 찾기를 진행해주세요.");
			logger.info("?????????????????" + m);
			logger.info("중복된 이메일 있음");
			return "/login/ckRe";
		}else{
			m.addAttribute("email", "YES");
			m.addAttribute("OK3", "가입된 이메일이 없습니다.");
			m.addAttribute("OK4", "이 이메일로 회원가입을 진행해주세요.");
			m.addAttribute("mail", mail);
			logger.info("중복된 이메일 없음");
			logger.info(mail);
			return "/login/ckRe";
		}
	}
	
	
	
}