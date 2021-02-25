package kr.kosmo.jobkorea.ticketing.dao;

import java.util.List;

import kr.kosmo.jobkorea.ticketing.model.Boxof;
import kr.kosmo.jobkorea.ticketing.model.Db;

public interface DetailDao {
	public Db getDetail(String mt20id);
	
	public int insertDb(Db db);
}
