package kr.kosmo.jobkorea.payment.service;

import java.text.DateFormat;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.login.model.RegisterInfoModel;
import kr.kosmo.jobkorea.payment.dao.PaymentDao;
import kr.kosmo.jobkorea.payment.model.Criteria;
import kr.kosmo.jobkorea.payment.model.PaymentModel;

@Service
public class PaymentServiceImpl implements PaymentService{

	@Autowired
	private PaymentDao paymentDao;
	
	
	
	@Override
	public List<PaymentModel> getCartList(String loginID) {
		return paymentDao.getCartList(loginID);
	}




	@Override
	public void cartUpdate(PaymentModel vo) {
		paymentDao.cartUpdate(vo);
	}




	@Override
	public List<PaymentModel> payCartList(HashMap<String, Object> map) {
		return paymentDao.payCartList(map);
	}




	@Override
	public void payment(PaymentModel vo) {
		
		// payNo
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		Date date = new Date();
		int ram =(int)(Math.random()*100);
		
		vo.setPayNo(dateFormat.format(date)+ "" + Integer.toString(ram));
		paymentDao.payment(vo);
		// userUPdate
		
		
		 // book stock update
	    // public List<PaymentModel> getCartList(String loginID);
	    List<PaymentModel> bookStock = getCartList(vo.getLoginID());
	    for(PaymentModel ad : bookStock) {
	    	PaymentModel bookUpdate = new PaymentModel();
	    	bookUpdate.setStock(ad.getStock());
	    	bookUpdate.setpId(ad.getpId());
	    	paymentDao.bookStockUpdate(bookUpdate);
	    }
	    
	    
	    
	    
		// cartUPdate
		String[] cartNosArray = vo.getCartNos().split(",");
	    for (int i = 0; i < cartNosArray.length; i++) {
		    PaymentModel vo2 = new PaymentModel();
		    vo2.setCartNo(cartNosArray[i]);
		    paymentDao.cartUpdate2(vo2);
	    }
	    // order_hst
	    vo.setUserState(0);
	    paymentDao.regOderHst(vo);
	    
	   
	    
	}


	@Override
	public int countUser() {
		return paymentDao.countUser();
	}

	@Override
	public List<Map<String, Object>> pagingUser(Criteria cri) {
		return paymentDao.pagingUser(cri);
	}

	@Override
	public List<Map<String, Object>> goSearch(String searchKey) {
		return paymentDao.goSearch(searchKey);
	}


	@Override
	public List<PaymentModel> userDetail(Map<String, Object> paramMap) {
		return paymentDao.userDetail(paramMap);
	}


	@Override
	public void cartDel(String cartNo) {
		paymentDao.cartDel(cartNo);
	}




	@Override
	public void goDelivery(String payNo) {
		paymentDao.goDelivery(payNo);
		paymentDao.goDeliveryHst(payNo);
	}

	@Override
	public List<PaymentModel> getRegDt() {
		return paymentDao.getRegDt();
	}

	@Override
	public void completeDelivery(String payNo) {
		paymentDao.completeDelivery(payNo);
		// hst
		PaymentModel vo = new PaymentModel();
		vo.setPayNo(payNo);
		vo.setUserState(2);
		paymentDao.regOderHst(vo);
	}




	@Override
	public PaymentModel orderShow(String payNo) {
		return paymentDao.orderShow(payNo);
	}




	@Override
	public List<PaymentModel> orderCarts(HashMap<String, Object> map) {
		return paymentDao.orderCarts(map);
	}




	@Override
	public void goCancel(String PayNo) {
		paymentDao.goCancel(PayNo);
		// hst
		PaymentModel vo = new PaymentModel();
		vo.setUserState(3);
		vo.setPayNo(PayNo);
	    paymentDao.regOderHst(vo);
	}



	
	@Override
	public List<PaymentModel> getCoupon(String loginID) {
		return paymentDao.getCoupon(loginID);
	}




	@Override
	public PaymentModel getCouponOne(String couponNo) {
		return paymentDao.getCouponOne(couponNo);
	}




	@Override
	public void useCoupon(String couponNo) {
		paymentDao.useCoupon(couponNo);
	}




	@Override
	public List<PaymentModel> detailCoupon(PaymentModel vo) {
		
		List<PaymentModel> goCancel=paymentDao.detailCoupon(vo);
		
		// couponUpdate
		for(PaymentModel ad : goCancel) {
			paymentDao.couponCancel(ad.getCouponNo());
		}
		
		return paymentDao.detailCoupon(vo);
	}




	@Override
	public void cartUpdate3(String cartNo) {
		paymentDao.cartUpdate3(cartNo);
	}




	@Override
	public Map<String, Object> defaultChart(){
		
		
		// 현재날짜 
		SimpleDateFormat  formatter = new SimpleDateFormat("yyyy-MM-dd");    
		Date today = new Date();
		String date =  formatter.format(today);
		// d-1
		today = new Date(today.getTime()+(1000*60*60*24*-1));
		String yesterday = formatter.format(today);
		// d-2
		today = new Date(today.getTime()+(1000*60*60*24*-1));
		String yyesterday = formatter.format(today);
		
		ArrayList<String> days = new ArrayList<>();
		days.add(yyesterday);
		days.add(yesterday);
		days.add(date);
		
		// date
		ArrayList<String> result = new ArrayList<>();
		for (String ad : days) {
			PaymentModel vo = new PaymentModel();
			vo = paymentDao.defaultChart(ad);
			result.add(vo.getTotalPrice());
		}

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("days", days);
		map.put("total", result);
		return map;
	}




	@Override
	public Map<String, Object> goChart(Map<String, Object> paramMap) throws Exception {
		
		String fromDt = (String) paramMap.get("fromDt");
		String toDt = (String) paramMap.get("toDt");
		   

		   
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
		String format_time1 = f.format (System.currentTimeMillis());
		
		Date d1 = f.parse(fromDt);
		Date d2 = f.parse(toDt);
		long diff = d2.getTime() - d1.getTime();
		long mm = diff / 60000;
		long hh = diff / 3600000;
		long day = hh/24;	// 날짜 차이
		
		Calendar c1 = Calendar.getInstance();
		Calendar c2 = Calendar.getInstance();
		
		c1.setTime(d1);
		c2.setTime(d2);
		
		ArrayList<String> days = new ArrayList<>();
		ArrayList<String> result = new ArrayList<>();
		
		
		
		while( c1.compareTo( c2 ) !=1 ){
			String strDate = f.format(c1.getTime()); // 2021-02-19이런식으로 출력됌
			days.add(strDate);
			//시작날짜 + 1 일
			c1.add(Calendar.DATE, 1);
		}
		
		for (String ad : days) {
			PaymentModel vo = new PaymentModel();
			vo = paymentDao.defaultChart(ad);
			result.add(vo.getTotalPrice());
		}
		
		System.out.println(day);
		
		if(day == 0) {
			//paymentService.completeDelivery(ad.getPayNo());
			// d1
		}
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("days", days);
		map.put("total", result);
		return map;
	}




	@Override
	public void mileageDeduction(PaymentModel vo) {
		paymentDao.mileageDeduction(vo);
	}




	@Override
	public RegisterInfoModel userInfo(String loginID) {
		return paymentDao.userInfo(loginID);
	}




	@Override
	public List<PaymentModel> buyList(String loginID) {
		return paymentDao.buyList(loginID);
	}




	@Override
	public List<PaymentModel> userOrders(String loginID) {
		return paymentDao.userOrders(loginID);
	}




	@Override
	public void userCancel(Map<String, Object> paramMap,String loginID) {
		String payNo = (String) paramMap.get("payNo");
		PaymentModel orderDetail = paymentDao.orderShow(payNo);
		orderDetail.setLoginID(loginID);
		System.out.println("사용된 마일리지 " + orderDetail.getUseMileage());
		System.out.println("적립된 마일리지 " + orderDetail.getEarnedMileage());
		System.out.println("카트번호 " + orderDetail.getCartNos());
		System.out.println("쿠폰번호 " + orderDetail.getCouponNo());
		
		// revertMileage
		RegisterInfoModel userMileage =paymentDao.userInfo(loginID);
		int oldMileage =userMileage.getMileage();
		int useMileage = Integer.parseInt(orderDetail.getUseMileage());
		orderDetail.setMileage(Integer.toString(oldMileage+useMileage));
		paymentDao.mileageDeduction(orderDetail); // 사용한거 다시 복구
		orderDetail.setBalanceMileage(Integer.toString(oldMileage- Integer.parseInt(orderDetail.getEarnedMileage())));
		paymentDao.mileageSet(orderDetail);	// 적립된거 revert user테이블에
		// cart
		String[] cartNosArray = orderDetail.getCartNos().split(",");
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cartNos", cartNosArray);
		paymentDao.userCancelCart(map);	// cart order_yn =n
		// coupon
		paymentDao.couponCancel(orderDetail.getCouponNo());
		// state
		paymentDao.userCancelState(payNo);
		orderDetail.setUserState(5);
	    paymentDao.regOderHst(orderDetail);
	}




	@Override
	public void mileageSet(PaymentModel vo) {
		paymentDao.mileageSet(vo);
	}




	@Override
	public String addressCheck(String loginID) {
		return paymentDao.addressCheck(loginID);
	}




	@Override
	public List<RegisterInfoModel> userAddressS(String loginID) {
		return paymentDao.userAddressS(loginID);
	}






	@Override
	public void addAddress(Map<String, Object> paramMap) {
		paymentDao.addAddress(paramMap);
	}




	@Override
	public int delAddress(Map<String, Object> paramMap) {
		
		int result = 0; 
		String addressCheck = paymentDao.addressTableCheck(paramMap);
		if(addressCheck.equals("X")) {	// address 테이블이 아니면
			// user삭제
			result=1;
		}else {
			// address테이블이 맞다면
			// address삭제
			paymentDao.delAddress(paramMap);
		}
		return result;
	}




	@Override
	public void defaultAddress(Map<String, Object> paramMap) {
		int maxNum = paymentDao.maxVal(paramMap);
		maxNum +=1;
		paramMap.put("maxNum", maxNum);
		
		String addressCheck = paymentDao.addressTableCheck(paramMap);
		if(addressCheck.equals("X")) {	// address 테이블이 아니면
			// user테이블 +1
			paymentDao.setUserTable(paramMap);
		}else {
			// address테이블 +1
			paymentDao.setAddressTable(paramMap);
		}
	}




	@Override
	public RegisterInfoModel getUserAddress(RegisterInfoModel vo) {
		RegisterInfoModel address = new RegisterInfoModel();
		
		// max값을 가져와 
		int maxNum = paymentDao.maxVal2(vo);
		vo.setVal(Integer.toString(maxNum));
		address = paymentDao.userMaxAddress(vo);
		return address;
	}




	@Override
	public List<PaymentModel> adminOrders() {
		return paymentDao.adminOrders();
	}




	@Override
	public int countOrders() {
		return paymentDao.countOrders();
	}




	@Override
	public List<Map<String, Object>> adminOrdersPaging(Criteria cri) {
		return paymentDao.adminOrdersPaging(cri);
	}




	@Override
	public List<PaymentModel> showCoupon() {
		return paymentDao.showCoupon();
	}




	@Override
	public String couponCheck(Map<String, Object> paramMap) {
		return paymentDao.couponCheck(paramMap);
	}




	@Override
	public void insertCoupon(Map<String, Object> paramMap) {
		paymentDao.insertCoupon(paramMap);
	}




	@Override
	public void modifyAddress(Map<String, Object> paramMap) {
		paymentDao.modifyAddress(paramMap);
	}




	@Override
	public RegisterInfoModel getAddress(Map<String, Object> paramMap) {
		return paymentDao.getAddress(paramMap);
	}




	@Override
	public void directPay(PaymentModel vo, String sw) {

		 // book stock update
	    List<PaymentModel> bookStock = getCartList(vo.getLoginID());
	    for(PaymentModel ad : bookStock) {
	    	PaymentModel bookUpdate = new PaymentModel();
	    	bookUpdate.setStock(ad.getStock());
	    	bookUpdate.setpId(ad.getpId());
	    	paymentDao.bookStockUpdate(bookUpdate);
	    }
	    
	    String cartNo = "";
	    if(sw.equals("1")) {
	    	String bookName = vo.getBookName();
	    	List<PaymentModel> getCartInfo = getCartList(vo.getLoginID());
		    for(PaymentModel ad : getCartInfo) {
		    	if(bookName.equals(ad.getBookName())) {
		    		// 카트내역에서 바로 구매하는 상품을 선택
			    	paymentDao.cartUpdate2(ad);
			    	cartNo = ad.getCartNo();
		    	}
		    }
		    
			// payNo
			DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
			Date date = new Date();
			int ram =(int)(Math.random()*100);
			
			vo.setPayNo(dateFormat.format(date)+ "" + Integer.toString(ram));
			vo.setCartNos(cartNo);
			paymentDao.payment(vo);
			
		    // order_hst
		    vo.setUserState(0);
		    paymentDao.regOderHst(vo);
		    

	    }else {
	    }
	    
	}



}
