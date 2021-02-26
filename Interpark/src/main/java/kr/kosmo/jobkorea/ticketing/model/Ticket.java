package kr.kosmo.jobkorea.ticketing.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class Ticket {
	
	private long uid;
	private String mt20id;		//공연ID
	private String prfnm;		//공연명
	private String mt10id;		//공연시설ID
	private String fcltynm;		//공연시설명
	private int price;			//티켓가격
	private String rundate;		//공연날짜
	private String runtime;		//공연시간
	private String seatname;	//좌석명
	
}
