package kr.kosmo.jobkorea.ticketing.model;

import lombok.Data;

@Data
public class Seat {
	private String name;	// S석,R석,...
	private int price;		// 가격
	private String row;		// 행이름 1열,2열,...
	private String column;	// 열이름 A열,B열,...
	

}
