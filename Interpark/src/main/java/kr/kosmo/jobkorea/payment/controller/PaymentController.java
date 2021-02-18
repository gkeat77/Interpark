package kr.kosmo.jobkorea.payment.controller;

import java.io.PrintWriter;
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

@Controller
public class PaymentController {

	@Autowired
	PaymentService paymentService;
	
	@Autowired
	bookService booksv;
	
	private final Logger logger = LogManager.getLogger(this.getClass());

   
   @RequestMapping("/cartList.do")
   public ModelAndView index(Model model, @RequestParam Map<String, String> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {

	   ModelAndView mav = new ModelAndView();
	   RegisterInfoModel rm = (RegisterInfoModel) session.getAttribute("member");
	   
	   String pId = request.getParameter("pId");
	   // 도서상품 -> buy버튼 
	   if(pId != null) {
		   // cart에 존재하는지 check 후 insert
		   BookModel bookInfo = booksv.bookInfo(pId);
		   String cartBookTtitle = booksv.cartInfo(pId);
		   if(bookInfo.getTitle().equals(cartBookTtitle)) { // check
			   mav.addObject("check", 1);
			   mav.setViewName("/payment/cartList"); // 빈 카트로 페이지 이동해서 jsp해서 해결
		   }else {
			   bookInfo.setLoginID(rm.getLoginID());
			   booksv.cartAdd(bookInfo);
			   
			   // cartList
			   String loginID = rm.getLoginID();
			   mav.addObject("cartList", paymentService.getCartList(loginID));
			   mav.addObject("cartCnt",paymentService.getCartList(loginID).size());
			   mav.setViewName("/payment/cartList");
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
   

   
   @RequestMapping(value="/paymentForm.do" , method = RequestMethod.POST)
	public ModelAndView paymentForm(HttpSession session, HttpServletRequest req) throws Exception {
	   logger.info("+ Start Payment.paymentForm.do");
	   ModelAndView mav = new ModelAndView();

	   // cartList 값이 수정되었을 수도 있으므로 stock update
	   String cartNos = req.getParameter("cartNos");
	   String[] cartNosArray = cartNos.split(",");
	   

	   String cartStocks = req.getParameter("cartStocks");
	   String[] cartStocksArray = cartStocks.split(",");
	   
	   String mileages = req.getParameter("mileages");
	   String[] mileagesArray = mileages.split(",");
	   for (int i = 0; i < cartStocksArray.length; i++) {
		   PaymentModel vo = new PaymentModel();
		   vo.setStock(Integer.parseInt(cartStocksArray[i]));
		   vo.setCartNo(cartNosArray[i]);
		   vo.setMileage(mileagesArray[i]);
		   paymentService.cartUpdate(vo);
	   }
	   
	   
	   // userInfo
	   RegisterInfoModel rm = (RegisterInfoModel) session.getAttribute("member");
	   mav.addObject("userInfo", rm);
	   String loginID = rm.getLoginID();
	   
	   // total
	   String totalPrice = req.getParameter("totalPrice");
	   //getCart
	   HashMap<String, Object> map = new HashMap<String, Object>();
	   map.put("cartNos", cartNosArray);
	   
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
   
   
   

   @RequestMapping(value="/payment.do", method = RequestMethod.POST)
   public ModelAndView payment(Model model, @RequestParam Map<String, String> paramMap, HttpServletRequest request, PaymentModel vo,
         HttpServletResponse response, HttpSession session) throws Exception {
	  logger.info("+ Start Payment.payment.do"); 
	  ModelAndView mav = new ModelAndView();
	  
	  String dcPrice = request.getParameter("couponPrice");
	  String [] arr = request.getParameterValues("cc");
	  
	  if(!dcPrice.equals("0")) {
		  // 할인을 받았다면
		  for (int i = 0; i < arr.length; i++) {
			  paymentService.useCoupon(arr[i]);
		  }
	  }
	  paymentService.payment(vo);
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
	   String fromDt = (String) paramMap.get("fromDt");
	   String toDt = (String) paramMap.get("toDt");
	   
	   
	   //resultMap.put("userCoupon", paymentService.getCouponOne(couponNo));
	   
	   SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
	   String format_time1 = f.format (System.currentTimeMillis());
		
		Date d1 = f.parse(fromDt);
		Date d2 = f.parse(toDt);
		long diff = d2.getTime() - d1.getTime();
		long mm = diff / 60000;
		long hh = diff / 3600000;
		long day = hh/24;
		
		System.out.println(day);
		
		if(day == 0) {
			//paymentService.completeDelivery(ad.getPayNo());
			// d1
			
		}
		
		
	   result="success";
	   resultMap.put("resultMsg", result); 
	   
		return resultMap;
   }
}

