package kr.kosmo.jobkorea.ticketing.dao;

import java.util.List;

import kr.kosmo.jobkorea.ticketing.model.Boxof;

public interface IntroDao {
	public List<Boxof> getBoxofs(String today);
	
	public int insertBoxofs(List<Boxof> boxofs);
}
