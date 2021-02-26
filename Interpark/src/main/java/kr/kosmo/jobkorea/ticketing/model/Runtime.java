package kr.kosmo.jobkorea.ticketing.model;

import lombok.Data;

@Data
public class Runtime {
	
	private String uid;				// PK
	private String mt20id;			// 공연ID
	private String mt10id;			// 공연시설ID
	private String fcltynm;			// 공연장명
	private String dayOfWeek;		// 월요일,화요일,수요일,...
	private String time;			// 18:00
	
}
