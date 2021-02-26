package kr.kosmo.jobkorea.ticketing.model;

import lombok.Data;

@Data
public class Seat {
	
	private String uid;		// PK
	private String mt20id;	// 공연ID
	private String mt10id;	// 공연시설ID
	private String fcltynm;	// 공연시설명
	private String name;	// S석,R석,...
	private int price;		// 가격
	private String row;		// 행이름 1열,2열,...
	private String col;	// 열이름 A열,B열,...
	private String section; // 구역

}
