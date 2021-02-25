package kr.kosmo.jobkorea.ticketing.util;

import lombok.Data;

// 공연목록 조회 요청용
@Data
public class PblpfrRequest {
	
	String stdata;		//공연시작일
	String eddate;		//공연종료일
	int cpage;			//현재 페이지
	int rows;			//페이지당 목록수
	String shcate;		//장르코드
	String shprfnm;		//공연명
	String shprfnmfct;	//공연시설명
	String prfplccd;	//공연장코드
	String signgucode;	//지역(시도)코드
	String signgucodesub;//지역(구군)코드
	String kidstate;	//아동공연여부
	String prfstate;	//공연상태코드
		
}
