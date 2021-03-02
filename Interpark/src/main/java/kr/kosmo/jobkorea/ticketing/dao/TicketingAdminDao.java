package kr.kosmo.jobkorea.ticketing.dao;

import java.util.List;

import kr.kosmo.jobkorea.ticketing.model.Boxof;
import kr.kosmo.jobkorea.ticketing.model.Db;
import kr.kosmo.jobkorea.ticketing.model.Seat;
import kr.kosmo.jobkorea.ticketing.model.SeatInfo;
import kr.kosmo.jobkorea.ticketing.model.Runtime;

public interface TicketingAdminDao {
	
	
	//해당공연에 해당하는 예약용 좌석정보 가져오기
	public SeatInfo getseatinfo(String mt20id);
	
	//공연검색(공연제목으로)
	public List<Db> searchPrf(String searchStr);
	
}
