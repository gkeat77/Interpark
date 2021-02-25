package kr.kosmo.jobkorea.ticketing.controller;


import java.time.LocalDate;
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
public class ReviewController {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	// Get class name for logger
	private final String className = this.getClass().toString();	
	
	@Autowired
	ReviewService reviewService;
	
	@RequestMapping("/review.do")
	@ResponseBody
	public List<Review> getReviews(@RequestParam("mt20id") String mt20id)  {
		List<Review> reviews = null;
		
		reviews = reviewService.getReviews(mt20id);
		
		return reviews;
	}
	
	
}
