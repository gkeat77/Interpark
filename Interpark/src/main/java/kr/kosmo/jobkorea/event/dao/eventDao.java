package kr.kosmo.jobkorea.event.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.event.model.CategoryModel;
import kr.kosmo.jobkorea.event.model.EventModel;


public interface eventDao {
	
	/* 일반 */
	
	public List<CategoryModel> cateList(Map<String,Object> paramMap);
	
	public List<EventModel> eventList(String e_title);
	
	public List<EventModel> listAll();
		
	public List<EventModel> eventDetail(EventModel e_id);
	
	public int eventCount(Map<String,Object> paramMap);


}
