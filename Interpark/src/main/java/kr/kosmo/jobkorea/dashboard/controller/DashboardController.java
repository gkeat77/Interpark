package kr.kosmo.jobkorea.dashboard.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kosmo.jobkorea.book.model.BookModel;
import kr.kosmo.jobkorea.book.model.CategoryModel;
import kr.kosmo.jobkorea.book.service.bookService;
import kr.kosmo.jobkorea.book.util.API;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;
import kr.kosmo.jobkorea.payment.service.PaymentService;
import kr.kosmo.jobkorea.supportD.model.NoticeDModel;
import kr.kosmo.jobkorea.supportD.service.NoticeDService;
import kr.kosmo.jobkorea.system.model.MenuModel;
import kr.kosmo.jobkorea.system.service.MenuService;

@Controller
public class DashboardController {

	/*@Autowired
	NoticeDService noticeDService;
	@Autowired
	PaymentService paymentService;*/

	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	bookService booksv;
	
	@Autowired
	MenuService menusv;
	
	
	@RequestMapping("index.do")
	public String initDashboard(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".initDashboard");
		
		/* hegoog */
		
		//탑 메뉴
		RegisterInfoModel member = (RegisterInfoModel)session.getAttribute("member");
		paramMap.clear();
		paramMap.put("menuType","top");  //메뉴 타입  (어디쓰는 메뉴인가)
		if(member != null){
			paramMap.put("menuAuth",member.getUser_type()); //(유저타입에 따른 메뉴 권한) 
		}
		List<MenuModel> topMenu = menusv.menuList(paramMap);
		session.setAttribute("topMenu", topMenu);
		
		logger.info("   - >>>>>>>>>>>>>>topMenu : " + topMenu);
		
		//헤더 전체 카테고리
		paramMap.clear();
		CategoryModel megaMenu = new CategoryModel();
		paramMap.put("cateClass","국내도서");
		megaMenu.setDomesticList(booksv.cateList(paramMap));
		paramMap.put("cateClass","외국도서");
		megaMenu.setForeignList(booksv.cateList(paramMap));
		paramMap.put("cateClass","음반");
		megaMenu.setCdList(booksv.cateList(paramMap));
		paramMap.put("cateClass","DVD");
		megaMenu.setDvdList(booksv.cateList(paramMap));
		
		session.setAttribute("megaMenu", megaMenu);
		logger.info("   - >>>>>>>>>>>>>>megaMenu : " + megaMenu);
		
		//헤더 메뉴
		paramMap.clear();
		paramMap.put("menuType","Main");
		List<MenuModel> mainMenu = menusv.menuList(paramMap);
		session.setAttribute("mainMenu", mainMenu);
		
		//랭킹 카테고리
		paramMap.clear();
		paramMap.put("level",0);
		List<CategoryModel> cateList= booksv.cateList(paramMap);
		model.addAttribute("cateList", cateList);
		
		//한정 상품
		BookModel limitGoods = booksv.limitGoods();
		logger.info(">>>>>>>>>limitGoods"+limitGoods);
		model.addAttribute("limitGoods", limitGoods);
		
		logger.info("+ end " + className + ".initDashboard");
		
		return "/index";
	}
	
	@RequestMapping("rank.do")
	@ResponseBody
	public Map<String, Object> rank(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info(">>>>>>>랭크컨트롤러");
		
		API api = new API();
		List<BookModel> rankList = new ArrayList<>();
		logger.info("contoller paramap: "+paramMap);
		
		rankList=(List<BookModel>)api.searchBook(paramMap).get("bookArr");
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("rankList", rankList);
		
		return resultMap;
	}
	
	
	@RequestMapping("mainGoods.do")
	@ResponseBody
	public Map<String, Object> mainGoods(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		//String type=(String)(paramMap.get("type"));
		
		logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>> 메인상품>>>>>>>>>>>>>>>>>>>>>>>>>>>> ");
		logger.info(paramMap);
		
		Map<String, Object> resultMap = new HashMap<>();
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize")); 
		int pageIndex = 0;

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		List<BookModel> goodsList= booksv.goodsList(paramMap);
		
		resultMap.put("mainGoods", goodsList );
		
		return resultMap;
	}
	
	

}