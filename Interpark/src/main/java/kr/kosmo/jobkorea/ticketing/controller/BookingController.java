package kr.kosmo.jobkorea.ticketing.controller;


import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
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

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import kr.kosmo.jobkorea.login.model.RegisterInfoModel;
import kr.kosmo.jobkorea.ticketing.model.Booking;
import kr.kosmo.jobkorea.ticketing.model.Boxof;
import kr.kosmo.jobkorea.ticketing.model.Db;
import kr.kosmo.jobkorea.ticketing.model.Qna;
import kr.kosmo.jobkorea.ticketing.model.Review;
import kr.kosmo.jobkorea.ticketing.service.BookingService;
import kr.kosmo.jobkorea.ticketing.service.DetailService;
import kr.kosmo.jobkorea.ticketing.service.IntroService;
import kr.kosmo.jobkorea.ticketing.service.ListService;
import kr.kosmo.jobkorea.ticketing.service.QnaService;
import kr.kosmo.jobkorea.ticketing.service.ReviewService;
import kr.kosmo.jobkorea.ticketing.util.Helper;
import kr.kosmo.jobkorea.ticketing.util.PblpfrRequest;
import kr.kosmo.jobkorea.ticketing.util.XmlParse;

@Controller
@RequestMapping("/ticketing")
public class BookingController {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	// Get class name for logger
	private final String className = this.getClass().toString();	
	
	@Autowired
	DetailService detailService;
	@Autowired
	BookingService bookingService;
	
	@RequestMapping("/booking.do")
	public String booking( Booking booking, Model model, HttpSession session ){
		
		//세션로그인 확인
		RegisterInfoModel member = (RegisterInfoModel)session.getAttribute("member");
		if(member == null) {
			return "redirect:/login/login.me";
		}
		//좌석선택을 위한 자료 가져오기
		//인수: 공연ID(mt20id),공연날짜(date),공연요일(day),상영시간(times)
		String loginID = member.getLoginID();
		booking.setLoginID(loginID);
		//공연상세 조회
		Db db = detailService.getDetail(booking.getMt20id());
		
		//json string 변환
		Gson gson = new Gson();
		String bookingStr = gson.toJson(booking);
		String dbStr = gson.toJson(db);
		
		model.addAttribute("booking",booking);
		model.addAttribute("bookingStr",bookingStr);
		model.addAttribute("db", db);
		model.addAttribute("dbStr", dbStr);
		
		return "ticketing/booking";
	}
	
	
}
