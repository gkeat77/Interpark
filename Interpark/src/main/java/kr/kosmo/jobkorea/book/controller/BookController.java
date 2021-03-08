package kr.kosmo.jobkorea.book.controller;


import org.apache.log4j.LogManager;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.kosmo.jobkorea.book.model.BookModel;
import kr.kosmo.jobkorea.book.model.CategoryModel;
import kr.kosmo.jobkorea.book.service.bookService;
import kr.kosmo.jobkorea.book.util.API;
import kr.kosmo.jobkorea.common.comnUtils.ComnUtil;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/book/")
public class BookController {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();	
	
	@Autowired
	bookService booksv;
	
	@RequestMapping("goodsListPage.do")
	public 	String goodsListPage(Model model, HttpServletRequest request ,@RequestParam Map<String, Object> paramMap) throws Exception {
		logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>리스트 스타트>>>>>>>>>>>>>>>>>>"+paramMap);
		String searchKey = (String)paramMap.get("searchKey");
		if(searchKey !=null){
			model.addAttribute("searchKey",searchKey );
		}
		String cateClass = (String)paramMap.get("cateClass");
		if(cateClass !=null){
			model.addAttribute("cateClass",cateClass );
			logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>카테클래스 세팅>>>>>>>>>>>>>>>>>>");
		}
		String categoryId = (String)paramMap.get("categoryId");
		if(categoryId !=null){
			model.addAttribute("categoryId",categoryId );
			logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>카테아이디 세팅>>>>>>>>>>>>>>>>>>");
		}
		String serviceType = (String)paramMap.get("serviceType");
		logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>서비스 타입>>>>>>>>>>>>>>>>>>:"+serviceType);
		if(serviceType !=null){
			model.addAttribute("serviceType",serviceType );
			logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>서비스 타입 모델에실음>>>>>>>>>>>>>>>>>>");
		}
		paramMap.clear();
		//상위 카테고리 불러오기
		paramMap.put("level", 0);
		List<CategoryModel> cateUpperList= booksv.cateList(paramMap);
		
		
		//상위 카테고리에 하위 카테고리넣기
		for (int i = 0; i < cateUpperList.size(); i++) {
			paramMap.put("level", 1);
			paramMap.put("cateClass", cateUpperList.get(i).getCateClass());
			cateUpperList.get(i).setLowerCateList(booksv.cateList(paramMap));
		}
		model.addAttribute("cateList", cateUpperList);
		
		logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>리스트 끝>>>>>>>>>>>>>>>>>>");
		
		return "book/goodsList";
	}
	
	@RequestMapping("goodsList.do")
	public 	String goodsList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info(">>>>>>>>>>paramMap"+paramMap);
		
		List<BookModel> goodsList = new ArrayList<>();
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize")); 
		int pageIndex = (currentPage - 1) * pageSize;

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);

		goodsList = booksv.goodsList(paramMap);
		logger.info(goodsList);
		
		int totalCnt= booksv.goodsCount(paramMap);
		
		model.addAttribute("goodsList", goodsList);
		model.addAttribute("totalCnt", totalCnt);
		
		return "book/goodsListCallback";
	}
	
	@RequestMapping("goodsDetail.do")
	public 	String goodsDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		//상품 상세정보
		BookModel goods= booksv.goodsDetail(paramMap);
		model.addAttribute("goods", goods);
		//연관 상품 리스트
		paramMap.put("categoryId", goods.getCategoryId());
		List<BookModel> relateGoods = booksv.relateGoods(paramMap);
		
		if(relateGoods.size() < 3 ){
			logger.info(">>>>>>>해당 카테고리 목록이 3개보다 적습니다. 대분류로 불러옵니다");
			paramMap.put("cateClass", goods.getCategoryId().substring(0, 1));
			relateGoods =booksv.relateGoods(paramMap);
		}
		
		model.addAttribute("relate",relateGoods);
		
		return "book/goodsDetail";
	}
}
