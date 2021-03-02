package kr.kosmo.jobkorea.ticketing.controller;


import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import kr.kosmo.jobkorea.ticketing.model.Boxof;
import kr.kosmo.jobkorea.ticketing.model.Db;
import kr.kosmo.jobkorea.ticketing.model.Qna;
import kr.kosmo.jobkorea.ticketing.model.Review;
import kr.kosmo.jobkorea.ticketing.service.IntroService;
import kr.kosmo.jobkorea.ticketing.service.QnaService;
import kr.kosmo.jobkorea.ticketing.service.ReviewService;
import kr.kosmo.jobkorea.ticketing.util.Helper;
import kr.kosmo.jobkorea.ticketing.util.PblpfrRequest;
import kr.kosmo.jobkorea.ticketing.util.XmlParse;

@Controller
@RequestMapping("/ticketing")
public class IntroController {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	// Get class name for logger
	private final String className = this.getClass().toString();	
	
	@Autowired
	IntroService introService;
	
	@RequestMapping("/intro.do")
	public String intro(Model model) throws Exception {
		
		// 예매상황판 데이터 가져오기 args =>(String stsType, String date, String cateCode, String area)
		LocalTime startBoxofs = LocalTime.now();
		List<Boxof> boxofs = introService.getBoxofs(LocalDate.now());
		
		LocalTime endBoxofs = LocalTime.now();
		ObjectMapper mapper = new ObjectMapper();
		String boxofsStr = mapper.writeValueAsString(boxofs);
		
		System.out.println("박스오피스로딩타임: "+Duration.between(startBoxofs, endBoxofs).getSeconds());
		

		model.addAttribute("boxofs", boxofs);
		model.addAttribute("boxofsStr", boxofsStr);

		
		return "ticketing/intro";
	}
	
}