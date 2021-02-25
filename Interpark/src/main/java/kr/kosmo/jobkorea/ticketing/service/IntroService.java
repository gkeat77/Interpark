package kr.kosmo.jobkorea.ticketing.service;

import java.time.LocalDate;
import java.util.List;

import kr.kosmo.jobkorea.ticketing.model.Boxof;

public interface IntroService {
	//예매상황판 조회
	public List<Boxof> getBoxofs(LocalDate date);
	
	//예매상황판 데이터 저장
	public int insertBoxofs(List<Boxof> boxofs);
}
