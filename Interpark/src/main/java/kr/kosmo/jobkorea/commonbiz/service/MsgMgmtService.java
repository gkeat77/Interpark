package kr.kosmo.jobkorea.commonbiz.service;

import java.util.Map;

public interface MsgMgmtService {

	/** 메일 발송 */
	public void sendMsg(Map<String, Object>paramMap) throws Exception; 
}
