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
import kr.kosmo.jobkorea.book.service.bookService;
import kr.kosmo.jobkorea.book.util.API;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/api")
public class APIController {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	@Autowired
	bookService booksv;

	@RequestMapping("bookInfoSave.do")
	@ResponseBody
	public 	Map<String, Object> bookInfoSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		API api = new API();
		List<BookModel> bookArr = new ArrayList<>();
		
		logger.info("파라미터: "+paramMap);
		
		//서비스 지정 ( search , bestSeller ,recommend , newBook)
		String service = (String)paramMap.get("service"); 
		
		//상위 카테고리 지정 (domestic, foreign, recode, dvd)
		String category=(String)paramMap.get("category");
		//String category="foreign";
		
		//지정된 카테고리 품목 DB에서 삭제
		String cateNum=api.DelCateNum(category); // 카테고리 앞자리 가져오기
		//int deleteCount = booksv.delete(cateNum); //해당 카테고리 품목 삭제
		
		//logger.info("deleteCount"+deleteCount);
	
		//하위 카테고리 번호 리스트 받아오기
		List<String> categoryList = new ArrayList<>();
		categoryList=booksv.cateList(category);
		
		
		//api에서 해당 카테고리 책 정보 받아오기 
		for (int i = 0; i < categoryList.size(); i++) {
		bookArr= api.bookInfoSave(service, categoryList.get(i).toString());
		logger.info("bookArr"+bookArr);
		//책정보 db insert
		if(bookArr.size() <= 0){
			
		}else{
			paramMap.put("bookArr",bookArr);
			//int insertCount = booksv.insert(paramMap);
			//logger.info("insertCount"+insertCount);
		}	
		
		}
		String resultMsg="업데이트 완료";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultMsg", resultMsg);
		
		return resultMap;
	}
	
	
	
	@RequestMapping("searchBook.do")
	public 	String searchBook(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		API api = new API();
		List<BookModel> bookArr = new ArrayList<>();
		//paramMap.put("query", "삼국지");
		//paramMap.put("start", "3");
		
		
		logger.info("contoller paramap: "+paramMap);
		
		bookArr=api.searchBook(paramMap);
		
		
		String resultMsg="업데이트 완료";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultMsg", resultMsg);
		
		model.addAttribute("list", bookArr);
		logger.info("모델에 실었다");
		return "notice/ANotice";
	}

}
