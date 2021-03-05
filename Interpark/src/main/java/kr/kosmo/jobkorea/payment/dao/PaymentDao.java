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
	public List<PaymentModel> buyList(String loginID);
	public List<PaymentModel> userOrders(String loginID);
	public void mileageSet(PaymentModel vo);
	public void userCancelCart(HashMap<String, Object> map); // user가 취소했을 떄 카트 목록 복구
	public void userCancelState(String payNo);	// state =5으로 
	public String addressCheck(String loginID);
	public List<RegisterInfoModel> userAddressS(String loginID);
	public void addAddress(Map<String, Object> paramMap);
	public String addressTableCheck(Map<String, Object> paramMap);	// address테이블꺼인지 확인
	public void delAddress(Map<String, Object> paramMap); // address테이블꺼 삭제.. user테이블은 지울수가 없네
	public int maxVal(Map<String, Object> paramMap);				// max값 가져옴 (기본 주소 설정하기 위해서)
	public void setUserTable(Map<String, Object> paramMap);		// user테이블 set A_VAL update
	public void setAddressTable(Map<String, Object> paramMap);	// address테이블 set A_VAL update
	public void bookStockUpdate(PaymentModel vo);				// book 재고 update
	public int maxVal2(RegisterInfoModel vo);
	public RegisterInfoModel userMaxAddress(RegisterInfoModel vo);
	public List<PaymentModel> adminOrders();
	public int countOrders(); // forPaging
	public List<Map<String, Object>> adminOrdersPaging(Criteria cri);
	public List<PaymentModel>showCoupon();
	public String couponCheck(Map<String, Object> paramMap);	// 쿠폰 지급 확인
	public void insertCoupon(Map<String, Object> paramMap);
	public void modifyAddress(Map<String, Object> paramMap); // 기본배송지 수정
	public RegisterInfoModel getAddress(Map<String, Object> paramMap);
}
