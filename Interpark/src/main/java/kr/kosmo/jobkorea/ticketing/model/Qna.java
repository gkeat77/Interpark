package kr.kosmo.jobkorea.ticketing.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class Qna {
	private long uid;
	private Timestamp regdate;			//등록일
	private String loginID;				//로그인ID
	private String qora;				//질문 or 답변 여부("q"/"a")
	private long ref_uid;				//답변인경우 질문참조uid
	private String content;				//내용
}
