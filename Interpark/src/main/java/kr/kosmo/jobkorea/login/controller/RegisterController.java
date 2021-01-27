package kr.kosmo.jobkorea.login.controller;
import kr.kosmo.jobkorea.common.comnUtils.AESCryptoHelper;
import kr.kosmo.jobkorea.common.comnUtils.ComnUtil;
import java.util.Map;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kosmo.jobkorea.login.model.RegisterInfoModel;
import kr.kosmo.jobkorea.login.service.RegisterService;

/* 정수빈 작업 */
@Controller
public class RegisterController {

	@Autowired
	RegisterService registerService;
	
	@RequestMapping("aregister.do")
	@ResponseBody
	public String aregiste(Model result, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,  HttpServletResponse response, HttpSession session) throws Exception {
		paramMap.put("addr", (String)paramMap.get("addr") +","+(String)paramMap.get("addr_detail")+","+(String)paramMap.get("user_post"));
		paramMap.put("tel",  (String)paramMap.get("tel1") +"-"+(String)paramMap.get("tel2")       +"-"+(String)paramMap.get("tel3"));
		paramMap.put("birth",(String)paramMap.get("year") +    (String)paramMap.get("month")      +    (String)paramMap.get("day") );
		paramMap.put("pid",  (String)paramMap.get("pid1") +"-"+(String)paramMap.get("pid2"));
		//paramMap.put("pid",  AESCryptoHelper.encode( ComnUtil.AES_KEY, (String)paramMap.get("pid1") +"-"+(String)paramMap.get("pid2")));
		paramMap.put("mail", (String)paramMap.get("mail1")+"@"+(String)paramMap.get("mail2"));
		 
		registerService.aregister(paramMap);
		return null;
	}
	
	@RequestMapping("bregister.do")
	@ResponseBody
	public String bregiste(Model result, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		paramMap.put("addr", (String)paramMap.get("addr") +","+(String)paramMap.get("addr_detail")+","+(String)paramMap.get("user_post"));
		paramMap.put("tel",  (String)paramMap.get("tel1") +"-"+(String)paramMap.get("tel2")       +"-"+(String)paramMap.get("tel3"));
		paramMap.put("birth",(String)paramMap.get("year") +    (String)paramMap.get("month")      +    (String)paramMap.get("day") );
		paramMap.put("pid",  (String)paramMap.get("pid1") +"-"+(String)paramMap.get("pid2"));
		//paramMap.put("pid",  AESCryptoHelper.encode( ComnUtil.AES_KEY, (String)paramMap.get("pid1") +"-"+(String)paramMap.get("pid2")));
		paramMap.put("mail", (String)paramMap.get("mail1")+"@"+(String)paramMap.get("mail2"));
		
		registerService.bregister(paramMap);
		return null;
	}
	
	@RequestMapping("dregister.do")
	@ResponseBody
	public String dregiste(Model result, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		paramMap.put("comp_addr", (String)paramMap.get("comp_addr") +","+(String)paramMap.get("comp_addr1")+","+(String)paramMap.get("comp_addr2"));
		paramMap.put("tel",       (String)paramMap.get("tel1")      +"-"+(String)paramMap.get("tel2")      +"-"+(String)paramMap.get("tel3"));
		paramMap.put("comp_tel",  (String)paramMap.get("comp_tel1") +"-"+(String)paramMap.get("comp_tel2") +"-"+(String)paramMap.get("comp_tel3"));
		paramMap.put("birth",     (String)paramMap.get("year")          +(String)paramMap.get("month")     +    (String)paramMap.get("day") );
		paramMap.put("pid",  (String)paramMap.get("pid1") +"-"+(String)paramMap.get("pid2"));
		//paramMap.put("pid",  AESCryptoHelper.encode( ComnUtil.AES_KEY, (String)paramMap.get("pid1") +"-"+(String)paramMap.get("pid2")));
		paramMap.put("comp_mail", (String)paramMap.get("mail1")     +"@"+(String)paramMap.get("mail2"));

		registerService.dregister(paramMap);
		return null;
	}
	
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