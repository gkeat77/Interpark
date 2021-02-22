package kr.kosmo.jobkorea.payment.dao;

import java.util.HashMap;


import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.login.model.RegisterInfoModel;
import kr.kosmo.jobkorea.payment.model.Criteria;
import kr.kosmo.jobkorea.payment.model.PaymentModel;

public interface PaymentDao {
	
	public List<PaymentModel> getCartList(String loginID);
	public void cartUpdate(PaymentModel vo);
	public List<PaymentModel> payCartList(HashMap<String, Object> map);
	public void payment(PaymentModel vo);
	public void cartUpdate2(PaymentModel vo);	// 결제되었을 떄 카트 값 업데이트
	public void regOderHst(PaymentModel vo);	// 결제 되면 ORDER_HST 테이블 insert
	public int countUser(); 
	public List<Map<String, Object>> pagingUser(Criteria cri);
	public List<Map<String, Object>> goSearch(String searchKey);
	public List<PaymentModel> userDetail(Map<String, Object> paramMap);
	public void cartDel(String cartNo);
	public void goDelivery(String payNo);
	public void goDeliveryHst(String payNo);
	public List<PaymentModel>getRegDt();
	public void completeDelivery(String payNo);  
	public PaymentModel orderShow(String payNo);
	public List<PaymentModel> orderCarts(HashMap<String, Object> map);
	public void goCancel(String PayNo); 
	public List<PaymentModel> getCoupon (String loginID);
	public PaymentModel getCouponOne (String couponNo);
	public void useCoupon (String couponNo);
	public List<PaymentModel> detailCoupon (PaymentModel vo);
	public void couponCancel (String couponNo);
	public void cartUpdate3(String cartNo);
	public PaymentModel defaultChart(String day);
	public void mileageDeduction(PaymentModel vo);
	public RegisterInfoModel userInfo(String loginID);
}
