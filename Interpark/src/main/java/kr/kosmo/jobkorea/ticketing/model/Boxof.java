package kr.kosmo.jobkorea.ticketing.model;

import lombok.Data;

/*
 *  <area>서울</area>
	<prfdtcnt>43</prfdtcnt>
	<prfpd>2021.02.12~2021.05.01</prfpd>
	<cate>뮤지컬</cate>
	<prfplcnm>블루스퀘어 인터파크홀</prfplcnm>
	<prfnm>위키드</prfnm>
	<rnum>1</rnum>
	<seatcnt>1766</seatcnt>
	<poster>/upload/pfmPoster/PF_PF171092_210119_100127.gif</poster>
	<mt20id>PF171092</mt20id>
 *
 */

@Data
public class Boxof {
	public String area;//
	public int prfdtcnt;//
	public String prfpd;
	public String cate;
	public String prfplcnm;
	public String prfnm;
	public int rnum;
	public int seatcnt;
	public String poster;
	public String mt20id;
}
