package com.lsh.Krusty_Krab.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BOARDVIDEO {
	private int boNum;
	private String boTitle;	// 제목
	private String boUrl;	// 동영상 주소
	private MultipartFile boFile; // 섬네일
	private String boFileName; // 섬네일 이름

}
