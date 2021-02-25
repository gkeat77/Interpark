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
import kr.kosmo.jobkorea.ticketing.service.ListService;
import kr.kosmo.jobkorea.ticketing.service.QnaService;
import kr.kosmo.jobkorea.ticketing.service.ReviewService;
import kr.kosmo.jobkorea.ticketing.util.Helper;
import kr.kosmo.jobkorea.ticketing.util.PblpfrRequest;
import kr.kosmo.jobkorea.ticketing.util.XmlParse;

@Controller
@RequestMapping("/ticketing")
public class ListController {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	// Get class name for logger
	private final String className = this.getClass().toString();	
	
	@Autowired
	ListService listService;
	
	@RequestMapping("/list.do")
	public String list(PblpfrRequest request, Model model) throws Exception {
		Map<String, String> cateName = new HashMap<>();
		cateName.put("AAAA", "연극");
		cateName.put("AAAB", "뮤지컬");
		cateName.put("BBBA", "무용");
		cateName.put("CCCA", "클래식");
		cateName.put("CCCB", "오페라");
		// request내용 채우기(공연시작일, 공연종료일, ...)
		// 현재페이지와 페이지당 목록수는 받아옴
		
		String dateFrom = Helper.getDateStr(LocalDate.now());//공연시작일
		String dateTo = "20211231";//공연종료일
		request.setStdata(dateFrom);
		request.setEddate(dateTo);
		
		List<Db> dbs = listService.getList(request);
		
		ObjectMapper mapper = new ObjectMapper();
		String dbsStr = mapper.writeValueAsString(dbs);
		
		if(request.getShcate() != null){
			model.addAttribute("category", cateName.get(request.getShcate()));
		}
		
		model.addAttribute("dbs", dbs);
		model.addAttribute("dbsStr", dbsStr);
		
		return "ticketing/list";
	}
	
}
