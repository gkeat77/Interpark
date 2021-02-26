package kr.kosmo.jobkorea.event.service;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.event.model.CategoryModel;
import kr.kosmo.jobkorea.event.model.EventModel;

public interface eventService {
	
	/* 일반 */
	
	public List<CategoryModel> cateList(Map<String,Object> paramMap);
	
	public List<EventModel> eventList(Map<String,Object> paramMap);
	
	public int eventCount(Map<String,Object> paramMap);
}
