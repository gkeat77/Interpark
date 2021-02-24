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
import kr.kosmo.jobkorea.book.service.bookAdminService;
import kr.kosmo.jobkorea.book.util.API;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/bookAdmin/")
public class BookAdminController {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();	
	
	@Autowired
	bookAdminService booksv;
	
	
	//책 등록 페이지 이동
	@RequestMapping("regPage.do")
	public 	String bookList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		model.addAttribute("cateList", booksv.cateList());
		return "bookAdmin/bookList";
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
		return "bookAdmin/bookListCallback";
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
		
		return "bookAdmin/goodsReg";
	}
	
	//책정보 DB 등록
	@RequestMapping("regist.do")
	@ResponseBody
	public 	Map<String, Object> regist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("받아온"+paramMap);
		//API api = new API();
		
		//itemID로 책정보받아오기
/*		BookModel book = new BookModel();
		book = api.selectBookInfo(paramMap);
		paramMap.put("book", book);
		logger.info("책 넣엇다"+paramMap);*/
		
		int count=booksv.BookRegister(paramMap,request);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(count>0){
			resultMap.put("result","등록되었습니다.");
		}else{
			resultMap.put("result","등록 실패.");
		}
		return resultMap;
	}
	
	
	@RequestMapping("goodsListPage.do")
	public 	String goodsListPage(Model model, HttpServletRequest request) throws Exception {
		
		return "bookAdmin/goodsList";
	}
	
	@RequestMapping("goodsList.do")
	public 	String goodsList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
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
		
		return "bookAdmin/goodsListCallback";
	}
	
	@RequestMapping("goodsDetail.do")
	public 	String goodsDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		model.addAttribute("goods", booksv.goodsDetail(paramMap));
		
		return "bookAdmin/goodsDetail";
	}
	
	@RequestMapping("updateGoodsInfo.do")
	@ResponseBody
	public 	Map<String, Object> updateGoodsInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("받아온"+paramMap);
		
		int count=booksv.updateGoodsInfo(paramMap,request);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(count>0){
			resultMap.put("result","수정되었습니다.");
		}else{
			resultMap.put("result","수정 실패.");
		}
		return resultMap;
	}
	
	@RequestMapping("deleteGoods.do")
	@ResponseBody
	public 	Map<String, Object> deleteGoods(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("받아온"+paramMap);
		
		int count=booksv.deleteGoods(paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(count>0){
			resultMap.put("result","삭제되었습니다.");
		}else{
			resultMap.put("result","삭제 실패.");
		}
		return resultMap;
	}
	
	@RequestMapping("deleteImg.do")
	@ResponseBody
	public 	Map<String, Object> deleteImg(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("받아온"+paramMap);
		
		int count=booksv.deleteImg(paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(count>0){
			resultMap.put("result","이미지가 삭제되었습니다.");
		}else{
			resultMap.put("result","이미지 삭제 실패.");
		}
		return resultMap;
	}
	
	

}
