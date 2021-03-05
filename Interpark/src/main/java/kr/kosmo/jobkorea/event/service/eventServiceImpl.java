package kr.kosmo.jobkorea.event.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.event.model.CategoryModel;
import kr.kosmo.jobkorea.event.dao.eventDao;
import kr.kosmo.jobkorea.event.model.EventModel;
@Service





public class eventServiceImpl implements eventService{

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	eventDao eventDao;
	
	@Override
	public List<CategoryModel> cateList(Map<String,Object> paramMap) {
		return eventDao.cateList(paramMap);
	}

	@Override
	public List<EventModel> eventList(String e_title) {
		return eventDao.eventList(e_title);
	}
	
	@Override
	public List<EventModel> listAll() {	
		return eventDao.listAll();
	}
	
	@Override
	public List<EventModel> eventDetail(EventModel e_id) {	
		return eventDao.eventDetail(e_id);
	}
	
	@Override
	public int eventCount(Map<String, Object> paramMap) {
		return eventDao.eventCount(paramMap);
	}

}
