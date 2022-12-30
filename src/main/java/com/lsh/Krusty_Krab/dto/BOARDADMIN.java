package com.lsh.Krusty_Krab.dto;

import lombok.Data;

@Data
public class BOARDADMIN {
	private String boMode;		//게시판 이름
	private int boCount;		//게시판 게시글 수
	private String seq;			//시퀀스 생성
}
