package kr.kosmo.jobkorea.ticketing.controller;


import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.kosmo.jobkorea.book.service.bookService;
import kr.kosmo.jobkorea.ticketing.model.Boxof;
import kr.kosmo.jobkorea.ticketing.service.IntroService;
import kr.kosmo.jobkorea.ticketing.util.XmlParse;

@Controller
@RequestMapping("/ticketing")
public class IntroController {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();	
	
	@RequestMapping("/intro.do")
	public String intro(Model model) throws Exception {
		
		LocalDate now = LocalDate.now();
		String date = now.getYear()+"";
		date += (now.getMonthValue() < 10 ? "0"+now.getMonthValue() : now.getMonthValue());
		date += (now.getDayOfMonth() < 10 ? "0"+now.getDayOfMonth() : now.getDayOfMonth());
		
		// 예매상황판 데이터 가져오기
		List<Boxof> boxofs = XmlParse.getBoxofs("month", date, null, null);//String stsType, String date, String cateCode, String area
		ObjectMapper mapper = new ObjectMapper();
		String boxofsStr = mapper.writeValueAsString(boxofs);

		model.addAttribute("boxofs", boxofs);
		model.addAttribute("boxofsStr", boxofsStr);

		
		return "ticketing/intro";
	}
	

}
