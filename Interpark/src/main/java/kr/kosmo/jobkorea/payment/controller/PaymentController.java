package kr.kosmo.jobkorea.payment.controller;

import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.kosmo.jobkorea.book.model.BookModel;
import kr.kosmo.jobkorea.book.service.bookService;
import kr.kosmo.jobkorea.common.comnUtils.ComnUtil;
import kr.kosmo.jobkorea.login.model.RegisterInfoModel;
import kr.kosmo.jobkorea.payment.model.Criteria;
import kr.kosmo.jobkorea.payment.model.PageMaker;
import kr.kosmo.jobkorea.payment.model.PaymentModel;
import kr.kosmo.jobkorea.payment.service.PaymentService;
import kr.kosmo.jobkorea.system.service.MenuService;

@Controller
public class PaymentController {

	@Autowired
	PaymentService paymentService;
	
	@Autowired
	bookService booksv;
	
	@Autowired
	MenuService menuService;
	
	
	private final Logger logger = LogManager.getLogger(this.getClass());

   
   @RequestMapping("/cartList.do")
   public ModelAndView index(Model model, @RequestParam Map<String, String> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {

	   ModelAndView mav = new ModelAndView();
	   RegisterInfoModel rm = (RegisterInfoModel) session.getAttribute("member");
	   
	   String pId = request.getParameter("pId");
	   String bookStock = request.getParameter("bookStock");
	   // 도서상품 -> buy버튼 
	   if(pId != null) {
		   // session이 없을 떄
		   if(ComnUtil.isEmpty(rm)) {
			   mav.setViewName("/payment/cartList");
		   }else {
			   // cart에 존재하는지 check 후 insert
			   BookModel bookInfo = new BookModel();
			   bookInfo = booksv.bookInfo(pId);
			   bookInfo.setLoginID(rm.getLoginID());
			   String cartBookTtitle = booksv.cartInfo(bookInfo);
			   if(bookInfo.getTitle().equals(cartBookTtitle)) { // check
				   mav.addObject("check", 1);
				   mav.setViewName("/payment/cartList"); // 빈 카트로 페이지 이동해서 jsp해서 해결
			   }else {
				   bookInfo.setLoginID(rm.getLoginID());
				   bookInfo.setStock(Integer.parseInt(bookStock));
				   booksv.cartAdd(bookInfo);
				   
				   // cartList
				   String loginID = rm.getLoginID();
				   mav.addObject("cartList", paymentService.getCartList(loginID));
				   mav.addObject("cartCnt",paymentService.getCartList(loginID).size());
				   //mav.setViewName("/payment/cartList");
				   mav.setViewName("redirect:/cartList.do");
			   }
		   }
		 
	   }else {
		   if(rm != null) {
			   String loginID = rm.getLoginID();
			   mav.addObject("cartList", paymentService.getCartList(loginID));
			   mav.addObject("cartCnt",paymentService.getCartList(loginID).size());
			   mav.setViewName("/payment/cartList");
		   }else {
			   mav.setViewName("/payment/cartList");
		   }
	  }
      logger.info("+ Start Payment.cartList.do");
      return mav;
   }
   
   
   @ResponseBody
   @RequestMapping(value="/cartDel.do" , method = RequestMethod.POST)
	public String cartDel(HttpSession session, HttpServletRequest req) throws Exception {
		String result = null;
		paymentService.cartDel(req.getParameter("cartNo"));
		result= "success";
		return result;
	}
   

   // book to payment
   // 기존꺼는 쓰면 카트에 담긴 애들도 같이 payment에 떠서
   // 카트에 담지 않고 결제 다 되면 카트에 담는다??
   // 결제 버튼 눌렸을 떄 카트 insert구현되게 payment또 따로
   
   @RequestMapping(value="/directPayment.do" , method = RequestMethod.POST)
	public ModelAndView directPayment(HttpSession session, HttpServletRequest req, PaymentModel vo) throws Exception {
	   logger.info("+ Start Payment.directPayment.do");
	   ModelAndView mav = new ModelAndView();

	   RegisterInfoModel rm = (RegisterInfoModel) session.getAttribute("member");
   
	   // session이 없을 떄
	   if(ComnUtil.isEmpty(rm)) {
		   mav.setViewName("/payment/cartList");
	   }else {
		   // userInfo
		   RegisterInfoModel userInfo = new RegisterInfoModel();
		   userInfo = paymentService.userInfo(rm.getLoginID());
		   mav.addObject("userInfo", userInfo);
		   String loginID = rm.getLoginID();
		   // address
		   mav.addObject("userAddress",paymentService.getUserAddress(userInfo));
		   // coupon
		   mav.addObject("getCoupon",paymentService.getCoupon(loginID));
		   // book
		   BookModel bookInfo = new BookModel();
		   bookInfo = booksv.bookInfo(vo.getpId());
		   bookInfo.setStock(vo.getStock());
		   mav.addObject("bookInfo",bookInfo);
		   // 카트 insert
		   bookInfo.setLoginID(rm.getLoginID());
		   booksv.cartAdd(bookInfo);
		   
		   mav.setViewName("payment/directPayment");
	   }
	   return mav;
	}
  
   
   
   
   // cart to payment
   @RequestMapping(value="/paymentForm.do" , method = RequestMethod.POST)
	public ModelAndView paymentForm(HttpSession session, HttpServletRequest req) throws Exception {
	   logger.info("+ Start Payment.paymentForm.do");
	   ModelAndView mav = new ModelAndView();

	   // cartList 값이 수정되었을 수도 있으므로 stock update
	   String cartNos = req.getParameter("cartNos");
	   String[] cartNosArray = cartNos.split(",");
	   

	   String cartStocks = req.getParameter("cartStocks");
	   String[] cartStocksArray = cartStocks.split(",");
	   
	   for (int i = 0; i < cartStocksArray.length; i++) {
		   PaymentModel vo = new PaymentModel();
		   vo.setStock(Integer.parseInt(cartStocksArray[i]));
		   vo.setCartNo(cartNosArray[i]);
		   paymentService.cartUpdate(vo);
	   }
	   
	   
	   // userInfo
	   // session으로 뿌렸었는데 마일리지는 실시간으로 적용이 안되는거 같아서 service작성
	   RegisterInfoModel rm = (RegisterInfoModel) session.getAttribute("member");
	   RegisterInfoModel userInfo = new RegisterInfoModel();
	   userInfo = paymentService.userInfo(rm.getLoginID());
	   mav.addObject("userInfo", userInfo);
	   String loginID = rm.getLoginID();
	   
	   // address
	   mav.addObject("userAddress",paymentService.getUserAddress(userInfo));
	   // total
	   String totalPrice = req.getParameter("totalPrice");
	   //getCart
	   HashMap<String, Object> map = new HashMap<String, Object>();
	   map.put("cartNos", cartNosArray);
	   map.put("loginID", loginID);
	   
	   // 각 카트에 담인 애들 결되되면 카트리스트에 보이지 않게 하기 위해서
	   mav.addObject("totalPrice",totalPrice);
	   // 결제 테이블에 카트 번호 전달 하기 위해서 
	   mav.addObject("cartNos",cartNos);
	   mav.addObject("cartList",paymentService.payCartList(map));
	   mav.addObject("cartCnt",paymentService.getCartList(rm.getLoginID()).size());
	   // 쿠폰
	   mav.addObject("getCoupon",paymentService.getCoupon(loginID));
	   mav.setViewName("payment/payment");
	   return mav;
	}
   
   
   
   // book to pay
   @RequestMapping(value="/directPay.do", method = RequestMethod.POST)
   public ModelAndView directPay(Model model, @RequestParam Map<String, String> paramMap, HttpServletRequest request, PaymentModel vo,
         HttpServletResponse response, HttpSession session) throws Exception {
	  logger.info("+ Start Payment.payment.do"); 
	  ModelAndView mav = new ModelAndView();
	  
	  String dcPrice = request.getParameter("couponPrice");
	  String oldMileage = request.getParameter("oldMileage");
	  String [] arr = request.getParameterValues("cc");
	  String paymentSw = request.getParameter("paymentSw");
	  int result = Integer.parseInt(paymentSw); 
	  
	  RegisterInfoModel rm = (RegisterInfoModel) session.getAttribute("member");
	  vo.setLoginID(rm.getLoginID());
	  
	  if(result==1) {		// mileage x, coupon x
		  vo.setMileage("0");
		  logger.info("result1");
	  }else if(result==2){ 	// mileage o, coupon x
		  paymentService.mileageDeduction(vo);
		  vo.setMileage(vo.getUseMileage());
		  logger.info("result2");
	  }else if(result==3){	// mileage x, coupon o
		  logger.info("result3");
		  for (int i = 0; i < arr.length; i++) {
			  System.out.println(dcPrice);
			  paymentService.useCoupon(arr[i]);
		  }
		  vo.setMileage("0");
	  }else if(result==4) {	// mileage o, coupon o
		  for (int i = 0; i < arr.length; i++) {
			  paymentService.useCoupon(arr[i]);
		  }
		  paymentService.mileageDeduction(vo); 	 
		  vo.setMileage(vo.getUseMileage());	// 다시 set
		  logger.info("result4");
	  }
	  
	  // direct
	  // 카트에서 p_id에 해당애는 애 1개
	  String sw = request.getParameter("sw");
	  paymentService.directPay(vo, sw);
	  
	  
	  // userTable 반영 (적립되는애 그냥 더해주면 되네)
	  RegisterInfoModel userInfo = paymentService.userInfo(vo.getLoginID());
	  vo.setBalanceMileage(Integer.toString(userInfo.getMileage()+ Integer.parseInt(vo.getEarnedMileage())));
	  paymentService.mileageSet(vo);
	  
	  mav.addObject("userInfo",vo);
	  mav.setViewName("payment/paymentResult");
      return mav;
   }
   
   
   
   
   //cart to pay
   @RequestMapping(value="/payment.do", method = RequestMethod.POST)
   public ModelAndView payment(Model model, @RequestParam Map<String, String> paramMap, HttpServletRequest request, PaymentModel vo,
         HttpServletResponse response, HttpSession session) throws Exception {
	  logger.info("+ Start Payment.payment.do"); 
	  ModelAndView mav = new ModelAndView();
	  
	  String dcPrice = request.getParameter("couponPrice");
	  String oldMileage = request.getParameter("oldMileage");
	  String [] arr = request.getParameterValues("cc");
	  String paymentSw = request.getParameter("paymentSw");
	  int result = Integer.parseInt(paymentSw); 
	  
	  RegisterInfoModel rm = (RegisterInfoModel) session.getAttribute("member");
	  vo.setLoginID(rm.getLoginID());
	  
	  if(result==1) {		// mileage x, coupon x
		  vo.setMileage("0");
		  logger.info("result1");
	  }else if(result==2){ 	// mileage o, coupon x
		  paymentService.mileageDeduction(vo);
		  vo.setMileage(vo.getUseMileage());
		  logger.info("result2");
	  }else if(result==3){	// mileage x, coupon o
		  logger.info("result3");
		  for (int i = 0; i < arr.length; i++) {
			  System.out.println(dcPrice);
			  paymentService.useCoupon(arr[i]);
		  }
		  vo.setMileage("0");
	  }else if(result==4) {	// mileage o, coupon o
		  for (int i = 0; i < arr.length; i++) {
			  paymentService.useCoupon(arr[i]);
		  }
		  paymentService.mileageDeduction(vo); 	 
		  vo.setMileage(vo.getUseMileage());	// 다시 set
		  logger.info("result4");
	  }
	  
	  paymentService.payment(vo);
	  // userTable 반영 (적립되는애 그냥 더해주면 되네)
	  RegisterInfoModel userInfo = paymentService.userInfo(vo.getLoginID());
	  vo.setBalanceMileage(Integer.toString(userInfo.getMileage()+ Integer.parseInt(vo.getEarnedMileage())));
	  paymentService.mileageSet(vo);
	  
	  mav.addObject("userInfo",vo);
	  mav.setViewName("payment/paymentResult");
      return mav;
   }

   @RequestMapping(value="/adminInfo.do", method = RequestMethod.GET)
   public ModelAndView admin(Criteria cri, Model mode, HttpSession session
   		, @RequestParam(value="searchKey", required=false)String searchKey
   		) throws ParseException {
   	
	ModelAndView mav = new ModelAndView();
	
	RegisterInfoModel rm = (RegisterInfoModel) session.getAttribute("member");
	if(ComnUtil.isEmpty(rm)) {
		mav.setViewName("login/login");
	}else if(rm.getLoginID().equals("admin")) {
		// 배송중 -> 배송완료 처리
				List<PaymentModel> regDt = paymentService.getRegDt();
				SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd-HH:mm", Locale.KOREA);
				String format_time1 = f.format (System.currentTimeMillis());
				for(PaymentModel ad :regDt) {
					Date d1 = f.parse(format_time1);
					Date d2 = f.parse(ad.getRegDt());
					long diff = d1.getTime() - d2.getTime();
					long mm = diff / 60000;
					long hh = diff / 3600000;
					if(hh>48) {
						paymentService.completeDelivery(ad.getPayNo());
					}
				}
			    // search
			    if(searchKey != null) {
			    	mav.addObject("list", paymentService.goSearch(searchKey));
			    }else {    // paging
			    	PageMaker pageMaker = new PageMaker();
			        pageMaker.setCri(cri);
			        pageMaker.setTotalCount(paymentService.countUser());
			        
			        List<Map<String,Object>> list = paymentService.pagingUser(cri);
			        mav.addObject("list", list);
			        mav.addObject("pageMaker", pageMaker);
			    }
			   	// cart
			   	//mav.addObject("cartList", paymentService.getCartList());
			   	//mav.addObject("cartCnt",paymentService.getCartList().size());
			    
				
			   	mav.setViewName("payment/admin");
	}
	else {
		mav.setViewName("index");
	}
   	return mav;
   }
   
   
   
   @ResponseBody
   @RequestMapping(value="/userDetail.do" , method = RequestMethod.POST)
	public Map<String, Object> userDetail(@RequestParam Map<String, Object> paramMap, PaymentModel vo, HttpSession session, HttpServletRequest req) throws Exception {
	   Map<String, Object> resultMap = new HashMap<String, Object>();
	   String result="";
	   resultMap.put("userOrders", paymentService.userDetail(paramMap));
	   result="success";
	   resultMap.put("resultMsg", result); 
		return resultMap;
   }


   @ResponseBody
   @RequestMapping(value="/cartDelAll.do" , method = RequestMethod.POST)
	public String cartDelAll(HttpSession session, HttpServletRequest req,@RequestParam(value="val[]") List<Integer> vals) throws Exception {
		String result = null;
		
		for(int i=0; i<vals.size() ;i++){
	        String cartNo = Integer.toString(vals.get(i));
	        paymentService.cartDel(cartNo);
	    }
		
		result= "success";
		return result;
	}
   
   
   @ResponseBody
   @RequestMapping(value="/goDelivery.do" , method = RequestMethod.POST)
	public Map<String, Object> goDelivery(@RequestParam Map<String, Object> paramMap, PaymentModel vo, HttpSession session, HttpServletRequest req) throws Exception {
	   Map<String, Object> resultMap = new HashMap<String, Object>();
	   String result="";
	   System.out.println(paramMap.get("payNo"));
	   String payNo = (String) paramMap.get("payNo");
	   paymentService.goDelivery(payNo);
	   //resultMap.put("userOrders", paymentService.userDetail(paramMap));
	   result="success";
	   resultMap.put("resultMsg", result); 
		return resultMap;
   }
   
   
   

   
   @ResponseBody
   @RequestMapping(value="/orderShow.do" , method = RequestMethod.POST)
	public Map<String, Object> orderShow(@RequestParam Map<String, Object> paramMap, PaymentModel vo, HttpSession session, HttpServletRequest req) throws Exception {
	   Map<String, Object> resultMap = new HashMap<String, Object>();
	   String result="";
	   
	   // getCartNo 하니까 1,2,3 이면 1만 가지고 와서 payNo가지고 옴
	   String payNo = (String) paramMap.get("payNo");
	   // getCartNos
	   PaymentModel  cartNos =paymentService.orderShow(payNo);
	   String[] cartNosArray = cartNos.getCartNos().split(",");
	   
	   HashMap<String, Object> map = new HashMap<String, Object>();
	   map.put("cartNos", cartNosArray);
	   
	   result="success";
	   resultMap.put("cartList",paymentService.orderCarts(map));
	   resultMap.put("totalPrice",cartNos.getPrice());
	   resultMap.put("resultMsg", result); 
		return resultMap;
   }
   
   
   
   @ResponseBody
   @RequestMapping(value="/goCancel.do" , method = RequestMethod.POST)
	public Map<String, Object> goCancel(@RequestParam Map<String, Object> paramMap, PaymentModel vo, HttpSession session, HttpServletRequest req) throws Exception {
	   Map<String, Object> resultMap = new HashMap<String, Object>();
	   String result="";
	   String payNo = (String) paramMap.get("payNo");
	   
	   // 쿠폰 && 카트 복귀
	   PaymentModel CancelCoupon =paymentService.orderShow(payNo);
	   paymentService.detailCoupon(CancelCoupon);
	  
	   String[] cartNosArray = CancelCoupon.getCartNos().split(",");
	   for (int i = 0; i < cartNosArray.length; i++) {
		   // 카트 복귀 보류
		   //paymentService.cartUpdate3(cartNosArray[i]);
	   }
	   
	   paymentService.goCancel(payNo);
	   result="success";
	   resultMap.put("resultMsg", result); 
		return resultMap;
   }
   
   

   @ResponseBody
   @RequestMapping(value="/couponOne.do" , method = RequestMethod.POST)
	public Map<String, Object> couponOne(@RequestParam Map<String, Object> paramMap, PaymentModel vo, HttpSession session, HttpServletRequest req) throws Exception {
	   Map<String, Object> resultMap = new HashMap<String, Object>();
	   String result="";
	   String couponNo = (String) paramMap.get("couponNo");
	   resultMap.put("userCoupon", paymentService.getCouponOne(couponNo));
	   result="success";
	   resultMap.put("resultMsg", result);
	   
	   return resultMap;
   }
   
   
   @RequestMapping(value="/statistics.do", method = RequestMethod.GET)
   public ModelAndView statistics (Model mode, HttpSession session
   		, @RequestParam(value="searchKey", required=false)String searchKey
   		) throws ParseException {
   	
	ModelAndView mav = new ModelAndView();
	
	RegisterInfoModel rm = (RegisterInfoModel) session.getAttribute("member");
	if(ComnUtil.isEmpty(rm)) {
		mav.setViewName("login/login");
	}else if(rm.getLoginID().equals("admin")) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map = (HashMap<String, Object>) paymentService.defaultChart();

		
		ArrayList<String> days = (ArrayList<String>) map.get("days");
		ArrayList<String> total = (ArrayList<String>) map.get("total");
	
		mav.addObject("days", days);
		mav.addObject("total", total);
		mav.setViewName("payment/statistics");
		// aside
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("menuHigh", "");
		session.setAttribute("menu", menuService.adminList(paramMap));
	}
	else {
		mav.setViewName("index");
	}
   	return mav;
   }
   
   
   @ResponseBody
   @RequestMapping(value="/goStatistics.do" , method = RequestMethod.POST)
	public Map<String, Object> goStatistics(@RequestParam Map<String, Object> paramMap, PaymentModel vo, HttpSession session, HttpServletRequest req) throws Exception {
	   Map<String, Object> resultMap = new HashMap<String, Object>();
	   String result="";
	   HashMap<String, Object> map = new HashMap<String, Object>();
	   map = (HashMap<String, Object>) paymentService.goChart(paramMap);
	   
	   ArrayList<String> days = (ArrayList<String>) map.get("days");
	   ArrayList<String> total = (ArrayList<String>) map.get("total");
	   resultMap.put("days2", days);
	   resultMap.put("total2", total);
	   
	   
	   result="success";
	   resultMap.put("resultMsg", result); 
	   
		return resultMap;
   }
   

	
	@ResponseBody
	@RequestMapping(value="/goCart.do" , method = RequestMethod.POST)
	public Map<String, Object> goCart(@RequestParam Map<String, Object> paramMap, HttpSession session, HttpServletRequest req) throws Exception {
		   Map<String, Object> resultMap = new HashMap<String, Object>();
		   String result="";
		   
		   String pId = (String) paramMap.get("pId");
		   String bookStock = (String) paramMap.get("bookStock");
		   RegisterInfoModel rm = (RegisterInfoModel) session.getAttribute("member");
		   if(rm != null) {
			   BookModel bookInfo = new BookModel();
			   bookInfo = booksv.bookInfo(pId);
			   bookInfo.setLoginID(rm.getLoginID());
			   // 같은 상품이 있으면 add x
			   String cartBookTtitle = booksv.cartInfo(bookInfo);
			   System.out.println(bookInfo.getTitle());
			   if(bookInfo.getTitle().equals(cartBookTtitle)) {
				   result="cartAlready";
			   }else {
				   bookInfo.setLoginID(rm.getLoginID());
				   bookInfo.setStock(Integer.parseInt(bookStock));
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
	
	
	@RequestMapping(value="/userInfo.do", method = RequestMethod.GET)
	   public ModelAndView userInfo (Model mode, HttpSession session, HttpServletRequest req
			   , @RequestParam(value="userSw", required=false)String userSw
	   		) throws ParseException {
	   	
		ModelAndView mav = new ModelAndView();
		int result=0;
		
		RegisterInfoModel rm = (RegisterInfoModel) session.getAttribute("member");
		if(ComnUtil.isEmpty(rm)) {
			mav.setViewName("login/login");
		}else{
			if(!ComnUtil.isEmpty(userSw)){
				int sw = Integer.parseInt(userSw);
				String loginID = rm.getLoginID();
				
				if(sw == 2 ) {
					String addressCheck = paymentService.addressCheck(loginID);
					if(addressCheck.equals("X")) {
						mav.addObject("address", paymentService.userInfo(loginID));
					}else {
						mav.addObject("addressS", paymentService.userAddressS(loginID));
					}
					result=2;
				}
				if(sw == 4 ) {
					mav.addObject("buyList", paymentService.buyList(loginID));
					result=4;
				}
				if(sw == 5 ) {
					mav.addObject("orders", paymentService.userOrders(loginID));
					result=5;
				}
			}
			mav.addObject("result", result);
			
			mav.setViewName("payment/userInfo");
		}
	   	return mav;
	   }
	

	

	
	@ResponseBody
	@RequestMapping(value="/userCancel.do" , method = RequestMethod.POST)
	public Map<String, Object> userCancel(@RequestParam Map<String, Object> paramMap, HttpSession session, HttpServletRequest req) throws Exception {
		   Map<String, Object> resultMap = new HashMap<String, Object>();
		   String result="";
		   
		   RegisterInfoModel rm = (RegisterInfoModel) session.getAttribute("member");
		   String loginID = rm.getLoginID();
		   paymentService.userCancel(paramMap, loginID);
		   
		   result="success";
		   resultMap.put("resultMsg", result); 
		   return resultMap;
	   }
	
	

	
	@ResponseBody
	@RequestMapping(value="/addAddress.do" , method = RequestMethod.POST)
	public Map<String, Object> addAddress(@RequestParam Map<String, Object> paramMap, HttpSession session, HttpServletRequest req) throws Exception {
		   Map<String, Object> resultMap = new HashMap<String, Object>();
		   String result="";
		   
		   RegisterInfoModel rm = (RegisterInfoModel) session.getAttribute("member");
		   String loginID = rm.getLoginID();
		   paramMap.put("loginID",loginID);
		   paymentService.addAddress(paramMap);
		   
		   result="success";
		   resultMap.put("resultMsg", result); 
		   return resultMap;
	   }
	

	@ResponseBody
	@RequestMapping(value="/delAddress.do" , method = RequestMethod.POST)
	public Map<String, Object> delAddress(@RequestParam Map<String, Object> paramMap, HttpSession session, HttpServletRequest req) throws Exception {
		   Map<String, Object> resultMap = new HashMap<String, Object>();
		   String result="";
		   
		   RegisterInfoModel rm = (RegisterInfoModel) session.getAttribute("member");
		   String loginID = rm.getLoginID();
		   paramMap.put("loginID",loginID);

		   int check = paymentService.delAddress(paramMap);
		   if(check == 1) {
			   result="user테이블의 주소입니다";
		   }else {
			   result="success";
		   }
		   
		   resultMap.put("resultMsg", result); 
		   return resultMap;
	   }
	
	

	@ResponseBody
	@RequestMapping(value="/defaultAddress.do" , method = RequestMethod.POST)
	public Map<String, Object> defaultAddress(@RequestParam Map<String, Object> paramMap, HttpSession session, HttpServletRequest req) throws Exception {
		   Map<String, Object> resultMap = new HashMap<String, Object>();
		   String result="";
		   
		   RegisterInfoModel rm = (RegisterInfoModel) session.getAttribute("member");
		   String loginID = rm.getLoginID();
		   paramMap.put("loginID",loginID);

		   paymentService.defaultAddress(paramMap);
		   
		   result="success";
		   resultMap.put("resultMsg", result); 
		   return resultMap;
	   }
	

	@RequestMapping(value="/adminOrders.do", method = RequestMethod.GET)
	   public ModelAndView adminOrders (Model mode, HttpSession session, HttpServletRequest req, Criteria cri
			   , @RequestParam(value="adminSw", required=false)String adminSw
	   		) throws ParseException {
	   	
		ModelAndView mav = new ModelAndView();
		int result=0;
		
		RegisterInfoModel rm = (RegisterInfoModel) session.getAttribute("member");
		if(ComnUtil.isEmpty(rm)) {
			mav.setViewName("login/login");
		}else if(rm.getLoginID().equals("admin")) {
		
			if(!ComnUtil.isEmpty(adminSw)){
				int sw = Integer.parseInt(adminSw);
				String loginID = rm.getLoginID();
				
				if(sw == 1 ) {
					//mav.addObject("orders", paymentService.adminOrders());
					PageMaker pageMaker = new PageMaker();
			        pageMaker.setCri(cri);
			        pageMaker.setTotalCount(paymentService.countOrders());
			        
			        List<Map<String,Object>> list = paymentService.adminOrdersPaging(cri);
			        mav.addObject("list", list);
			        mav.addObject("pageMaker", pageMaker);
			        
			        
					result=1;
				}
				if(sw == 4 ) {
					result=4;
				}
				if(sw == 5 ) {
					result=5;
				}
			}
			}else {
			}
			mav.addObject("result", result);
			mav.setViewName("payment/adminInfo");
	   	return mav;
	   }
	
	

	@RequestMapping(value="/adminCoupon.do", method = RequestMethod.GET)
	   public ModelAndView adminCoupon(Criteria cri, Model mode, HttpSession session
	   		, @RequestParam(value="searchKey", required=false)String searchKey
	   		) throws ParseException {
	   	
		ModelAndView mav = new ModelAndView();
		
		RegisterInfoModel rm = (RegisterInfoModel) session.getAttribute("member");
		if(ComnUtil.isEmpty(rm)) {
			mav.setViewName("login/login");
		}else if(rm.getLoginID().equals("admin")) {
			// 배송중 -> 배송완료 처리
					List<PaymentModel> regDt = paymentService.getRegDt();
					SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd-HH:mm", Locale.KOREA);
					String format_time1 = f.format (System.currentTimeMillis());
					for(PaymentModel ad :regDt) {
						Date d1 = f.parse(format_time1);
						Date d2 = f.parse(ad.getRegDt());
						long diff = d1.getTime() - d2.getTime();
						long mm = diff / 60000;
						long hh = diff / 3600000;
						if(hh>48) {
							paymentService.completeDelivery(ad.getPayNo());
						}
					}
				    // search
				    if(searchKey != null) {
				    	mav.addObject("list", paymentService.goSearch(searchKey));
				    }else {    // paging
				    	PageMaker pageMaker = new PageMaker();
				        pageMaker.setCri(cri);
				        pageMaker.setTotalCount(paymentService.countUser());
				        
				        List<Map<String,Object>> list = paymentService.pagingUser(cri);
				        mav.addObject("list", list);
				        mav.addObject("pageMaker", pageMaker);
				    }
				   	// cart
				   	//mav.addObject("cartList", paymentService.getCartList());
				   	//mav.addObject("cartCnt",paymentService.getCartList().size());
				   	mav.setViewName("payment/adminCoupon");
					
		}
		else {
			mav.setViewName("index");
		}
	   	return mav;
	   }

	

	   @ResponseBody
	   @RequestMapping(value="/showCoupon.do" , method = RequestMethod.POST)
		public Map<String, Object> showCoupon(@RequestParam Map<String, Object> paramMap, PaymentModel vo, HttpSession session, HttpServletRequest req) throws Exception {
		   Map<String, Object> resultMap = new HashMap<String, Object>();
		   String result="";
		   resultMap.put("showCoupon", paymentService.showCoupon());
		   result="success";
		   resultMap.put("resultMsg", result); 
			return resultMap;
	   }
	

	   @ResponseBody
	   @RequestMapping(value="/payCoupon.do" , method = RequestMethod.POST)
		public Map<String, Object> payCoupon(@RequestParam Map<String, Object> paramMap, PaymentModel vo, HttpSession session, HttpServletRequest req) throws Exception {
		   Map<String, Object> resultMap = new HashMap<String, Object>();
		   String result="";
		   //resultMap.put("showCoupon", paymentService.showCoupon());
		   String couponCheck= paymentService.couponCheck(paramMap);
			if(couponCheck.equals("X")) {
				// 쿠폰을 지급받지 않았다면
				paymentService.insertCoupon(paramMap);
				result="success";
			}else {
				result="쿠폰을 지급 받았습니다";
			}
		   
		   resultMap.put("resultMsg", result); 
			return resultMap;
	   }
	   
	   @ResponseBody
	   @RequestMapping(value="/modifyAddress.do" , method = RequestMethod.POST)
		public Map<String, Object> modifyAddress(@RequestParam Map<String, Object> paramMap, PaymentModel vo, HttpSession session, HttpServletRequest req) throws Exception {
		   Map<String, Object> resultMap = new HashMap<String, Object>();
		   String result="";

		   RegisterInfoModel rm = (RegisterInfoModel) session.getAttribute("member");
		   String loginID = rm.getLoginID();
		   paramMap.put("loginID",loginID);
		   
		   paymentService.modifyAddress(paramMap);
		   
		   result="success";
		   
		   resultMap.put("resultMsg", result); 
			return resultMap;
	   }
	   
	   @ResponseBody
	   @RequestMapping(value="/getAddress.do" , method = RequestMethod.POST)
		public Map<String, Object> getAddress(@RequestParam Map<String, Object> paramMap, PaymentModel vo, HttpSession session, HttpServletRequest req) throws Exception {
		   Map<String, Object> resultMap = new HashMap<String, Object>();
		   String result="";
		   
		   resultMap.put("userAddress", paymentService.getAddress(paramMap));
		   
		   result="success";
		   resultMap.put("resultMsg", result); 
			return resultMap;
	   }
	   
	
}


