package kr.kosmo.jobkorea.payment.service;

import java.text.DateFormat;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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


}
