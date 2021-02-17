package kr.kosmo.jobkorea.supportD.dao;

import java.util.List;
import java.util.Map;

import kr.kosmo.jobkorea.supportD.model.NoticeDModel;


public interface NoticeDDao {

	List<NoticeDModel> noticeList(Map<String, Object> paramMap);

	int noticeTotalCnt(Map<String, Object> paramMap);

	NoticeDModel detailNotice(Map<String, Object> paramMap);

}
