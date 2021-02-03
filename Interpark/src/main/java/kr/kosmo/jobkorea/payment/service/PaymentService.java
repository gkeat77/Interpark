package kr.kosmo.jobkorea.payment.service;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.payment.model.Criteria;
import kr.kosmo.jobkorea.payment.model.PaymentModel;
import kr.kosmo.jobkorea.supportD.model.NoticeDModel;

public interface PaymentService {
	
	public List<PaymentModel> getCartList();
	
	public void cartUpdate(PaymentModel vo);
	
	public List<PaymentModel> payCartList(HashMap<String, Object> map);
	
	public void payment(PaymentModel vo);
	
	public int countUser(); // forPaging
	
	public List<Map<String, Object>> pagingUser(Criteria cri);
	
	public List<Map<String, Object>> goSearch(String searchKey);
	
	public List<PaymentModel>userDetail(Map<String, Object> paramMap);
	
	public void cartDel(String cartNo);
}
