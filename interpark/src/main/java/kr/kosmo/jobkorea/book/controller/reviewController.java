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
import kr.kosmo.jobkorea.book.service.bookService;
import kr.kosmo.jobkorea.book.service.reviewService;
import kr.kosmo.jobkorea.book.util.API;

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
	reviewService revsv;
	
	
	@RequestMapping("goodsListPage.do")
	public 	String goodsListPage(Model model, HttpServletRequest request) throws Exception {
		return "book/goodsList";
	}
	
	@RequestMapping("goodsList.do")
	public 	String goodsList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		return "book/goodsListCallback";
	}
	
	@RequestMapping("goodsDetail.do")
	public 	String goodsDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		return "book/goodsDetail";
	}
	
}
