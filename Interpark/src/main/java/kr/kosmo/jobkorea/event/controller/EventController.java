package kr.kosmo.jobkorea.event.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.kosmo.jobkorea.event.model.CategoryModel;
import kr.kosmo.jobkorea.event.model.EventModel;
import kr.kosmo.jobkorea.event.service.eventService;

@Controller
@RequestMapping("/event/")
public class EventController {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();	
	
	@Autowired
	eventService eventsv;
	
	
	@RequestMapping("eventListPage.do")
	public 	String eventListPage(Model model, HttpServletRequest request) throws Exception {
		//상위 카테고리 불러오기
		Map<String,Object> paramMap = new HashMap<>();
		paramMap.put("level", 0);
		List<CategoryModel> cateUpperList= eventsv.cateList(paramMap);
		System.out.println("상위카테고리"+cateUpperList);
		
		//상위 카테고리에 하위 카테고리넣기
		for (int i = 0; i < cateUpperList.size(); i++) {
			paramMap.put("level", 1);
			paramMap.put("cateClass", cateUpperList.get(i).getCateClass());
			cateUpperList.get(i).setLowerCateList(eventsv.cateList(paramMap));
		}
		model.addAttribute("cateList", cateUpperList);
		
		return "event/eventList";
	}
	
	@RequestMapping("eventList.do")
	public 	String eventList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info(">>>>>>>>>>paramMap"+paramMap);
		
		logger.info("파람맵"+paramMap.getClass().getName());
		logger.info(">>>>>>>>>>>>> 널 체크"+ (String) paramMap.get("currentPage")); // null
		
		List<EventModel> eventList = new ArrayList<>();
//		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
//		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));		
//		int pageIndex = (currentPage - 1) * pageSize;
//		
//		paramMap.put("pageIndex", pageIndex);
//		paramMap.put("pageSize", pageSize);

		eventList = eventsv.eventList(paramMap);
		
		int totalCnt= eventsv.eventCount(paramMap);
		
		model.addAttribute("eventList", eventList);
		model.addAttribute("totalCnt", totalCnt);
		
		return "event/eventListCallback";
	}
	
}