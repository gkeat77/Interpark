package kr.kosmo.jobkorea.book.controller;


import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
@RequestMapping("/book/")
public class BookController {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();	
	
	@Autowired
	bookService booksv;
	
	//책 등록 페이지 이동
	@RequestMapping("regPage.do")
	public 	String bookList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		model.addAttribute("cateList", booksv.cateList());
		return "book/bookSelect";
	}
	// 책 검색
	@RequestMapping("search.do")
	public 	String searchBook(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		API api = new API();
		List<BookModel> bookArr = new ArrayList<>();
		logger.info("contoller paramap: "+paramMap);
		
		bookArr=(List<BookModel>)api.searchBook(paramMap).get("bookArr");
		int total =Integer.parseInt(api.searchBook(paramMap).get("total").toString());
		
		logger.info("bookArr: "+bookArr);
		logger.info("total: "+total);
		
		String resultMsg="업데이트 완료";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultMsg", resultMsg);
		
		model.addAttribute("list", bookArr);
		model.addAttribute("totalCnt",total);
		return "book/bookList";
	}
	//책 선택 후 상품정보 입력 페이지이동
	@RequestMapping("select.do")
	public 	String selectBookInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		API api = new API();
		BookModel book = new BookModel();
		
		book = api.selectBookInfo(paramMap);
		logger.info("선택 책정보:"+book);
		
		model.addAttribute("book", book);
		
		return "book/goodsReg";
	}
	
	//책정보 DB 등록
	@RequestMapping("regist.do")
	@ResponseBody
	public 	Map<String, Object> regist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("받아온"+paramMap);
		API api = new API();
		
		//itemID로 책정보받아오기
		BookModel book = new BookModel();
		book = api.selectBookInfo(paramMap);
		paramMap.put("book", book);
		logger.info("책 넣엇다"+paramMap);
		
		int count=booksv.BookRegister(paramMap,request);
/*		if(count >0){
			reAttr.addFlashAttribute("msg","상품이 등록되었습니다.");
		}else{
			reAttr.addFlashAttribute("msg","상품이 등록실패.");
		}
		*/
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result","SUCCESS");
		
		return resultMap;
	}
	

}