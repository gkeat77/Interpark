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
import kr.kosmo.jobkorea.ticketing.model.SeatInfo;
import kr.kosmo.jobkorea.ticketing.service.BookingService;
import kr.kosmo.jobkorea.ticketing.service.DetailService;
import kr.kosmo.jobkorea.ticketing.service.IntroService;
import kr.kosmo.jobkorea.ticketing.service.ListService;
import kr.kosmo.jobkorea.ticketing.service.QnaService;
import kr.kosmo.jobkorea.ticketing.service.ReviewService;
import kr.kosmo.jobkorea.ticketing.service.TicketingAdminService;
import kr.kosmo.jobkorea.ticketing.util.Helper;
import kr.kosmo.jobkorea.ticketing.util.PblpfrRequest;
import kr.kosmo.jobkorea.ticketing.util.XmlParse;

@Controller
@RequestMapping("/ticketing/admin")
public class TicketingAdminController {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	// Get class name for logger
	private final String className = this.getClass().toString();	
	
	@Autowired
	TicketingAdminService ticketingAdminService;
	
	//공연좌석 에다터 화면 띄우기
	@RequestMapping("/editseat.do")
	public String editSeat( HttpSession session ){
		
		//세션로그인 확인
		RegisterInfoModel member = (RegisterInfoModel)session.getAttribute("member");
		if(member == null) {
			return "redirect:/login/login.me";
		}
		//관리자 로그인 체크!!!

		
		return "ticketing/admin/editseat";
	}
	
	//해당공연에 해당하는 예약용 좌석정보 가져오기
	@RequestMapping("/getseatinfo.do")
	@ResponseBody
	public SeatInfo getseatinfo(String mt20id){
		SeatInfo info = new SeatInfo();
		
		return info;
	}
	
	//공연검색(공연제목으로)
	@RequestMapping("/searchprf.do")
	@ResponseBody
	public List<Db> searchPrf(@RequestParam("searchStr")String searchStr){
		List<Db> dbs = null;
		dbs = ticketingAdminService.searchPrf(searchStr);
		
		System.out.println("searchPrf => ");
		System.out.println(dbs);
		
		return dbs;
	}
	
	
}
