ackage kr.kosmo.jobkorea.book.controller;


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
	public 	String goodsListPage(Model model, HttpServletRequest request) throws Exception {
		//상위 카테고리 불러오기
		Map<String,Object> paramMap = new HashMap<>();
		paramMap.put("level", 0);
		List<CategoryModel> cateUpperList= booksv.cateList(paramMap);
		
		//상위 카테고리에 하위 카테고리넣기
		for (int i = 0; i < cateUpperList.size(); i++) {
			paramMap.put("level", 1);
			paramMap.put("cateClass", cateUpperList.get(i).getCateClass());
			cateUpperList.get(i).setLowerCateList(booksv.cateList(paramMap));
		}
		model.addAttribute("cateList", cateUpperList);
		
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
		
		model.addAttribute("goods", booksv.goodsDetail(paramMap));
		
		return "book/goodsDetail";
	}
	
	// -------------ahn start-------------
	
	@ResponseBody
	@RequestMapping(value="/goCart.do" , method = RequestMethod.POST)
	public Map<String, Object> goCart(@RequestParam Map<String, Object> paramMap, HttpSession session, HttpServletRequest req) throws Exception {
		   Map<String, Object> resultMap = new HashMap<String, Object>();
		   String result="";
		   
		   String pId = (String) paramMap.get("pId");

		   RegisterInfoModel rm = (RegisterInfoModel) session.getAttribute("member");
		   if(rm != null) {
			   BookModel bookInfo = booksv.bookInfo(pId);
			   bookInfo.setLoginID(rm.getLoginID());
			   // 같은 상품이 있으면 add x
			   String cartBookTtitle = booksv.cartInfo(bookInfo);
			   if(bookInfo.getTitle().equals(cartBookTtitle)) {
				   result="cartAlready";
			   }else {
				   bookInfo.setLoginID(rm.getLoginID());
				   booksv.cartAdd(bookInfo);
				   result="success";
			   }
		   }else {
			   result="no";
		   }
		    
		   //resultMap.put("userCoupon", paymentService.getCouponOne(couponNo));
		   resultMap.put("resultMsg", result); 
		   return resultMap;
	   }
	
	// -------------ahn end-------------
	
}
