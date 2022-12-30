package com.lsh.Krusty_Krab.dto;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MEMBER {

	private String memId;				// 회원 아이디
	private String memPw;				// 회원 비밀번호
	private String memName;				// 회원 이름
	private String memBirth1;			// 회원 생년월일
	private String memBirth2;			// 회원 생년월일
	private String memBirth3;			// 회원 생년월일
	private String memBirth;			// 회원 생년월일
	private String memGender;			// 회원 성별
	private String memEmail;			// 회원 이메일
	private String memPhone;			// 회원 연락처
	
	private MultipartFile memProfile;	// 업로드 파일(프로필사진)
	private String memProfileName;		// 업로드 파일이름
	private String DFileName;			// 수정시 사진삭제할건가요?

	private String addr1;	// 우편주소
	private String addr2;	// 주소
	private String addr3;	// 상세주소
	private String memAddr;	// 합체한 주소
	private String memMode;	// 관리자, 유저등 나누는 모드
	
	

}
