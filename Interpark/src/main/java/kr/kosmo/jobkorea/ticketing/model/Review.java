package kr.kosmo.jobkorea.ticketing.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class Review {
	
	private long uid;
	private String loginID;
	private Timestamp regdate;		//등록일
	private String mt20id;			//공연ID
	private String content;			//내용

}
