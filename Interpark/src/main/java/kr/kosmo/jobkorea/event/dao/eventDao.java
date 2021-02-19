package kr.kosmo.jobkorea.event.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.event.model.CategoryModel;
import kr.kosmo.jobkorea.event.model.EventModel;


public interface eventDao {
	
	/* 일반 */
	
	public List<CategoryModel> cateList(Map<String,Object> paramMap);
	
	public List<EventModel> eventList(Map<String,Object> paramMap);
	
//	public int eventCount(Map<String,Object> paramMap);
//	
//	public BookModel goodsDetail(Map<String,Object> paramMap);
//	
//	public BookModel bookInfo (String pId);  
//	
//	public void cartAdd(BookModel vo);
//	
//	public String cartInfo (String pId);
}
