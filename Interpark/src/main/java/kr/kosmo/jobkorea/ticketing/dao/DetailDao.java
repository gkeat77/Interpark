package kr.kosmo.jobkorea.ticketing.dao;

import java.util.List;

import kr.kosmo.jobkorea.ticketing.model.Boxof;
import kr.kosmo.jobkorea.ticketing.model.Db;
import kr.kosmo.jobkorea.ticketing.model.Seat;
import kr.kosmo.jobkorea.ticketing.model.Runtime;

public interface DetailDao {
	
	// 공연상세정보 받아오기
	public Db getDetail(String mt20id);
	
	// XML 데이터 저장
	public int insertPrf(Db db);
	
	// 좌석정보 저장
	public int insertSeats(List<Seat> seats);
	// 좌석데이터 가져오기
	public List<Seat> getSeats(String mt20id);
	
	// 상영시간정보 저장
	public int insertRuntimes(List<Runtime> runtimes);
	// 상영시간데이터 가져오기
	public List<Runtime> getRuntimes(String mt20id);
	
}
