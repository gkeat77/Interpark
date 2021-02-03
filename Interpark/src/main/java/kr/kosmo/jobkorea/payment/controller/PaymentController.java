package kr.kosmo.jobkorea.payment.controller;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.kosmo.jobkorea.payment.model.Criteria;
import kr.kosmo.jobkorea.payment.model.PageMaker;
import kr.kosmo.jobkorea.payment.model.PaymentModel;
import kr.kosmo.jobkorea.payment.service.PaymentService;

@Controller
public class PaymentController {

	@Autowired
	PaymentService paymentService;
   private final Logger logger = LogManager.getLogger(this.getClass());

   
   @RequestMapping("/cartList.do")
   public String index(Model model, @RequestParam Map<String, String> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {

	   /*
	   ArrayList<PaymentModel> cartNo = new ArrayList<PaymentModel>();
	   for(PaymentModel ad :paymentService.getCartList()) {
		   PaymentModel vo = new PaymentModel();
		   vo.setCartNo(ad.getCartNo());
		   cartNo.add(vo);
	   }
	   */
	   //model.addAttribute("cartNo", cartNo);
	   model.addAttribute("cartList", paymentService.getCartList());
	   model.addAttribute("cartCnt",paymentService.getCartList().size());
      logger.info("+ Start Payment.cartList.do");
      return "/payment/cartList";
   }
   
   
   @ResponseBody
   @RequestMapping(value="/cartDel.do" , method = RequestMethod.POST)
	public String cartDel(HttpSession session, HttpServletRequest req) throws Exception {
		String result = null;
		System.out.println(req.getParameter("cartNo"));
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
	   
	   for (int i = 0; i < cartStocksArray.length; i++) {
		   PaymentModel vo = new PaymentModel();
		   vo.setStock(Integer.parseInt(cartStocksArray[i]));
		   vo.setCartNo(cartNosArray[i]);
		   paymentService.cartUpdate(vo);
	   }
	   
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
	   mav.addObject("cartCnt",paymentService.getCartList().size());
	   mav.setViewName("payment/payment");
	   return mav;
	}
   
   
   

   @RequestMapping(value="/payment.do", method = RequestMethod.POST)
   public ModelAndView payment(Model model, @RequestParam Map<String, String> paramMap, HttpServletRequest request, PaymentModel vo,
         HttpServletResponse response, HttpSession session) throws Exception {
	  logger.info("+ Start Payment.payment.do"); 
	  ModelAndView mav = new ModelAndView();
	  paymentService.payment(vo);
      mav.setViewName("redirect:index.do");
      return mav;
   }
   
   
   

   @RequestMapping(value="/adminInfo.do", method = RequestMethod.GET)
   public ModelAndView admin(Criteria cri, Model model
   		, @RequestParam(value="searchKey", required=false)String searchKey
   		) {
   	
	ModelAndView mav = new ModelAndView();

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
   	mav.addObject("cartList", paymentService.getCartList());
   	mav.addObject("cartCnt",paymentService.getCartList().size());
   	mav.setViewName("payment/admin");
   	return mav;
   }
   
   
   
   @ResponseBody
   @RequestMapping(value="/userDetail.do" , method = RequestMethod.POST)
	public Map<String, Object> userDetail(@RequestParam Map<String, Object> paramMap, PaymentModel vo, HttpSession session, HttpServletRequest req) throws Exception {
	   Map<String, Object> resultMap = new HashMap<String, Object>();
	   String result="";
	   System.out.println(paramMap.get("loginID"));
	   
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
	        System.out.println("vals(" + i + ") : " + vals.get(i));
	    }
		
		result= "success";
		return result;
	}
   
}
