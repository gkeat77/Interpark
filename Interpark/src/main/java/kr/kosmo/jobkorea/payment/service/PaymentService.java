package kr.kosmo.jobkorea.payment.service;

import java.util.ArrayList;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.login.model.RegisterInfoModel;
import kr.kosmo.jobkorea.payment.model.Criteria;
import kr.kosmo.jobkorea.payment.model.PaymentModel;
import kr.kosmo.jobkorea.supportD.model.NoticeDModel;

public interface PaymentService {
	
	public List<PaymentModel> getCartList(String loginID);
	
	public void cartUpdate(PaymentModel vo);
	
	public List<PaymentModel> payCartList(HashMap<String, Object> map);
	
	public void payment(PaymentModel vo);
	
	public int countUser(); // forPaging
	
	public List<Map<String, Object>> pagingUser(Criteria cri);
	
	public List<Map<String, Object>> goSearch(String searchKey);
	
	public List<PaymentModel>userDetail(Map<String, Object> paramMap);
	
	public void cartDel(String cartNo);
	
	public void goDelivery(String payNo);	// ORDER_STATE = 1
	
	public List<PaymentModel>getRegDt();
	
	public void completeDelivery(String payNo);   // ORDER_STATE = 2
	
	public PaymentModel orderShow(String payNo);	// 결제된 애들 show (getCartNOs)
	
	public List<PaymentModel> orderCarts(HashMap<String, Object> map); // 결제된 카트 내역
	
	public void goCancel(String PayNo); 			// ORDER_STATE= 3 
	
	public List<PaymentModel> getCoupon (String loginID);	// 쿠폰내역 출력
	public PaymentModel getCouponOne (String couponNo);	// 쿠폰체크박스 동적으로 하기 위해서
	public void useCoupon (String couponNo);	// 쿠폰 사용
	public List<PaymentModel> detailCoupon (PaymentModel vo); // 쿠폰 취소 하기 위해서 get coupon_hst_no
	public void cartUpdate3(String cartNo); // 취소했을 떄 카트리스트 복귀
	public Map<String, Object> defaultChart();
	public Map<String, Object> goChart(Map<String, Object> paramMap) throws Exception;
	public void mileageDeduction(PaymentModel vo);
	public RegisterInfoModel userInfo(String loginID);
	public List<PaymentModel> buyList(String loginID);
	public List<PaymentModel> userOrders(String loginID);
	public void userCancel(Map<String, Object> paramMap, String loginID);
	public void mileageSet(PaymentModel vo);
	public String addressCheck(String loginID);
	public List<RegisterInfoModel> userAddressS(String loginID);
	public void addAddress(Map<String, Object> paramMap);
	public int delAddress(Map<String, Object> paramMap);
	public void defaultAddress(Map<String, Object> paramMap);
	public RegisterInfoModel getUserAddress(RegisterInfoModel vo); // 유저 기본 주소 
	public List<PaymentModel> adminOrders();
	public int countOrders(); // forPaging
	public List<Map<String, Object>> adminOrdersPaging(Criteria cri);
	public List<PaymentModel>showCoupon();
	public String couponCheck(Map<String, Object> paramMap);	// 쿠폰 지급 확인
	public void insertCoupon(Map<String, Object> paramMap);
	public void modifyAddress(Map<String, Object> paramMap); // 기본배송지 수정
	public RegisterInfoModel getAddress(Map<String, Object> paramMap);
	public void directPay(PaymentModel vo, String sw); 
}

