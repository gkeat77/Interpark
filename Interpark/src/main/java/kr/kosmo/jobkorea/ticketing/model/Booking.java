package kr.kosmo.jobkorea.ticketing.model;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;

@Data
public class Booking {
	
	private long uid;				//PK
	private String loginID;			//로그인ID
	private String mt20id;			//공연ID
	private Timestamp regdate;		//등록일
	private String date;			//공연날짜
	private String day;				//공연요일
	private String times;			//상영시간
	private String genrenm;			//장르명
	private String prfage;			//공연관람연령
	private String entrpsnm;		//제작사
	private List<Ticket> tickets;	//티켓
}
