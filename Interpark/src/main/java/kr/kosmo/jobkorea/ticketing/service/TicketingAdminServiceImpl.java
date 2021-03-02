package kr.kosmo.jobkorea.ticketing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kosmo.jobkorea.ticketing.dao.TicketingAdminDao;
import kr.kosmo.jobkorea.ticketing.model.Db;
import kr.kosmo.jobkorea.ticketing.model.SeatInfo;

@Service
public class TicketingAdminServiceImpl implements TicketingAdminService{

	@Autowired
	TicketingAdminDao ticketingAdminDao;
	
	@Override
	public List<Db> searchPrf(String searchStr) {
		
		return ticketingAdminDao.searchPrf(searchStr);
	}

	@Override
	public SeatInfo getseatinfo(String mt20id) {
		
		return null;
	}

}
