package com.lsh.Krusty_Krab.dto;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BOARD {
	private int boNum; 		// 게시글 번호
	private String boMode;	// 게시판 종류
	private String boMode1;	// 게시판 변경시 사용
	private int boMNum;		// 게시판 종류에서의 번호
	private String boWriter; // 게시글 작성자
	private String boTitle; 	// 글제목
	private String boContent;// 글내용
	private Date boDate;		// 작성일
	private int boHit;		// 조회수
	
	private MultipartFile boFile; // 업로드 파일
	private String boFileName;	// 파일 이름
	private String dFileName;	// 삭제예정 파일이름
		
}
