package kr.kosmo.jobkorea.payment.dao;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.payment.model.Criteria;
import kr.kosmo.jobkorea.payment.model.PaymentModel;

public interface PaymentDao {
	
	public List<PaymentModel> getCartList();
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
}
