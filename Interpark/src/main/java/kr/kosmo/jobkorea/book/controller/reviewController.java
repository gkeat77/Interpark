package kr.kosmo.jobkorea.book.controller;


import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kosmo.jobkorea.book.model.BookModel;
import kr.kosmo.jobkorea.book.model.CategoryModel;
import kr.kosmo.jobkorea.book.model.reviewModel;
import kr.kosmo.jobkorea.book.service.bookService;
import kr.kosmo.jobkorea.book.service.reviewService;
import kr.kosmo.jobkorea.book.util.API;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/review/")
public class reviewController {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();	
	
	@Autowired
	reviewService revSv;
	
	@Autowired
	bookService booksv;
	
	
	@RequestMapping("regist.do")
	@ResponseBody
	public 	Map<String,Object> goodsListPage(Model model,@RequestParam Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		int count=revSv.reviewReg(paramMap);
		String Msg;
		if (count > 0){
			Msg="등록 되었습니다.";
		}else{
			Msg="등록 실패.";
		}
		
		Map<String,Object> resultMap = new HashMap<>();
		resultMap.put("resultMsg", Msg);
		resultMap.put("goodsInfo", booksv.goodsDetail(paramMap));
		
		logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>등록완료");
		return resultMap;
	}
	
	@RequestMapping("reviewList.do")
	public 	String goodsList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		//아이디정보 (좋아요 체크확인용)
		RegisterInfoModel rm = (RegisterInfoModel) session.getAttribute("member");
		if(rm != null) {
			paramMap.put("loginId", rm.getLoginID());}
		//페이지 정보 
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		List<reviewModel> reviewList= revSv.reviewList(paramMap);
		logger.info(">>>>>>>>>reviewList:"+reviewList);
		int totatCnt = revSv.reviewCount(paramMap);
		
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("totalCnt", totatCnt);
		
		return "book/reviewCallback";
	}
	
	@RequestMapping("likeUnlike.do")
	@ResponseBody
	public 	Map<String,Object> goodsDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info(">>>>>파람:"+paramMap);
		
		String Msg="";
		
		//아이디정보 (좋아요 체크용)
		RegisterInfoModel rm = (RegisterInfoModel) session.getAttribute("member");
		if(rm != null) {
			revSv.reviewLike(paramMap); //like 업데이트
			paramMap.put("loginId", rm.getLoginID());
			revSv.likeChk(paramMap); //like체크 테이블 insert/update
		}else{
			Msg= "로그인이 필요합니다";
		}
		
		Map<String,Object> resultMap = new HashMap<>();
		resultMap.put("Msg", Msg);
		
		return resultMap;
	}
	
	@RequestMapping("delete.do")
	@ResponseBody
	public 	Map<String,Object> deleteReview(Model model,@RequestParam Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		int count=revSv.reviewDel(paramMap);
		String Msg;
		if (count > 0){
			Msg="삭제 되었습니다.";
		}else{
			Msg="삭제 실패.";
		}
		
		Map<String,Object> resultMap = new HashMap<>();
		resultMap.put("resultMsg", Msg);
		resultMap.put("goodsInfo", booksv.goodsDetail(paramMap));
		
		logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>삭제완료");
		return resultMap;
	}
	
	
}
