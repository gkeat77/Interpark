package kr.kosmo.jobkorea.ticketing.model;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

// 공연목록 조회결과용
@Data
public class Db {
	
	public String mt20id;			//공연ID
	public String prfnm;			//공연명
	public String genrenm;			//공연 장르명
	public String prfstate;			//공연상태
	public String prfpdfrom;		//공연시작일
	public String prfpdto;			//공연종료일
	public String poster;			//공연포스터 경로
	public String fcltynm;			//공연시설명(공연장명)
	public String openrun;			//오픈런
	public String prfcast;			//출연진
	public String prfcrew;			//제작진
	public String prfruntime;		//상영시간
	public String prfage;			//관람연령
	public String entrpsnm;			//제작사
	public String pcseguidance;		//티켓가격
	public String sty;				//줄거리
	public List<String> styurls;	//소개이미지목록
	public String dtguidance;		//공연시간
	public String mt10id;			//공연시설ID
	public List<Seat> seats;		//좌석리스트
	public List<Runtime> runtimes;	//상영시간리스트
}

/* -- 공연상세조회 결과  --
<dbs>
    <db>
        <mt20id>PF169568</mt20id>
        <prfnm>명성황후 25주년 기념 공연</prfnm>
        <prfpdfrom>2021.01.19</prfpdfrom>
        <prfpdto>2021.03.07</prfpdto>
        <fcltynm>예술의전당 (오페라극장)</fcltynm>
        
        <prfcast>김소현, 신영숙, 강필석, 손준호, 박민성, 윤형렬, 이창섭 등</prfcast>
        <prfcrew>윤홍선, 안재승, 김광림 등</prfcrew>
        <prfruntime>2시간 40분</prfruntime>
        <prfage>만 7세 이상</prfage>
        <entrpsnm>(주)에이콤(ACOM)</entrpsnm>
        <pcseguidance>R석 140,000원, S석 120,000원, A석 80,000원, B석 60,000원</pcseguidance>
        
        <poster>http://www.kopis.or.kr/upload/pfmPoster/PF_PF169568_201112_111321.gif</poster>
        
        <sty> </sty>
        
        <genrenm>뮤지컬</genrenm>
        <prfstate>공연중</prfstate>
        <openrun>N</openrun>
        
        <styurls>
            <styurl>http://www.kopis.or.kr/upload/pfmIntroImage/PF_PF169568_201112_1114213.jpg</styurl>
            <styurl>http://www.kopis.or.kr/upload/pfmIntroImage/PF_PF169568_201112_1114212.jpg</styurl>
            <styurl>http://www.kopis.or.kr/upload/pfmIntroImage/PF_PF169568_201112_1114211.jpg</styurl>
        </styurls>
        
        <mt10id>FC000001</mt10id>
        <dtguidance>화요일(20:00), 수요일(15:00,20:00), 목요일(20:00), 금요일(15:00,20:00), 토요일(15:00,19:30), 일요일(14:00)</dtguidance>
    </db>
</dbs>
 */
