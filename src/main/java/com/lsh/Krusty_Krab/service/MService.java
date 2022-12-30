package com.lsh.Krusty_Krab.service;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.lsh.Krusty_Krab.dao.MDAO;
import com.lsh.Krusty_Krab.dto.BOARDADMIN;
import com.lsh.Krusty_Krab.dto.MEMBER;
import com.lsh.Krusty_Krab.dto.PAGE;
import com.lsh.Krusty_Krab.dto.SEARCH;

@Service
public class MService {

	// ModelAndView 객체 생성
	private ModelAndView mav = new ModelAndView();

	// DAO(Repository)연결
	@Autowired
	private MDAO mdao;

	// 비밀번호 암호화
	@Autowired
	private BCryptPasswordEncoder pwEnc;

	// session 추가
	@Autowired
	private HttpSession session;

	// 상대경로
	@Autowired
	private HttpServletRequest request;

	// 이메일 인증
	@Autowired
	private JavaMailSender mailSender;

	// 회원가입 메소드
	public ModelAndView mJoin(MEMBER member) throws IllegalStateException, IOException {

		// [1] 파일 업로드

		// 파일업로드 시작 지점 파일 업로드할때 save주소를 바꾸어 줄것!
		// 파일 정보 가져오기
		MultipartFile mFile = member.getMemProfile();

		// 업로드 파일이 있을때만 실행.
		if (!mFile.getOriginalFilename().isEmpty()) {

			// 파일이름 설정하기
			UUID uuid = UUID.randomUUID();
			// System.out.println("uuid 확인 : "+uuid.toString().substring(0, 8));

			// 날짜
			LocalDate now = LocalDate.now();
			// 시간
			LocalTime now2 = LocalTime.now();
			// 파일 이름은 날짜와 시간 랜덤 식별문자를 파일이름과 합친것
			String fileName = now + "_" + now2.toString().replaceAll("[^\\w+]", "") + "_"
					+ uuid.toString().substring(0, 8) + "_" + mFile.getOriginalFilename();

			// 저장경로에 파일 저장
			String savePath = request.getServletContext().getRealPath("/resources/profileImg/");
			mFile.transferTo(new File(savePath + fileName));

			// DTO객체에 생성한 업로드파일 이름을 저장한다.
			member.setMemProfileName(fileName);
		} else {
			member.setMemProfileName("");
		} // 파일 업로드 끝지점

		// [2] 주소합체
		String memAddr = "(" + member.getAddr1() + ") " + member.getAddr2() + ", " + member.getAddr3();
		member.setMemAddr(memAddr);

		// [3] 생일 합체
		String memBirth = member.getMemBirth1() + "-" + member.getMemBirth2() + "-" + member.getMemBirth3();
		member.setMemBirth(memBirth);
		// 비밀번호 암호화
		member.setMemPw(pwEnc.encode(member.getMemPw()));

		// System.out.println("암호화 후 : " + member);

		int result = mdao.mJoin(member);

		if (result > 0) {
			mav.setViewName("M_Login");
		} else {
			mav.setViewName("M_Join");
		}

		return mav;
	}

	// 로그인 메소드
	public ModelAndView mLogin(String memId, String memPw) {

		MEMBER member = new MEMBER();
		member.setMemId(memId);

		// System.out.println("서비스");
		String encPw = mdao.mLogin(member);
		// System.out.println("서비스2");

		if (pwEnc.matches(memPw, encPw)) {
			session.setAttribute("loginId", memId);
			String mode = mdao.mMode(member);
			session.setAttribute("mode", mode);
			mav.setViewName("index");
		} else {
			mav.setViewName("M_Login");
		}
		return mav;
	}

	// 회원 목록 메소드
	public ModelAndView mList(int page, int limit) {

		// System.out.println("controller-> service page: " + page);

		// 한 화면에 페이지 몇개 보여줄건가?
		int block = 5;

		// 한 화면에 보여줄 게시글 갯수
//		int limit = 5;

		// 전체 게시글 갯수
		int bCount = mdao.mCount();
		// 게시글이 0일때 페이지 보여줘
		if (bCount == 0) {
			bCount = 1;
		}
		// ceil: 올림
		int maxPage = (int) (Math.ceil((double) bCount / limit));
		// 오류방지 코드
		if (page > maxPage) {
			page = maxPage;
		}

		int startRow = (page - 1) * limit + 1;
		int endRow = page * limit;

		int startPage = (((int) (Math.ceil((double) page / block))) - 1) * block + 1;
		int endPage = startPage + block - 1;

		// 오류방지 코드
		if (endPage > maxPage) {
			endPage = maxPage;
		}

		// 페이징 객체 생성
		PAGE paging = new PAGE();

		paging.setPage(page);
		paging.setStartRow(startRow);
		paging.setEndRow(endRow);
		paging.setMaxPage(maxPage);
		paging.setStartPage(startPage);
		paging.setEndPage(endPage);
		paging.setLimit(limit);

		// System.out.println("dao-> service page :" + page);

		List<MEMBER> pagingList = mdao.mList(paging);

		// System.out.println("paging성공");
		// MODEL
		mav.addObject("memberList", pagingList);
		mav.addObject("paging", paging);

		// VIEW
		mav.setViewName("M_List");

		return mav;
	}

	// 상세정보 메소드
	public ModelAndView mView(String memId) {


		// System.out.println(" [2] controller → service\n mId : " + mId);

		MEMBER member = mdao.mView(memId);

		// (1) Model
		mav.addObject("view", member);

		// (2) View
		mav.setViewName("M_View");

		// mav객체 안에 Mview.jsp에서 사용할 member데이터의 이름을 "view"라고 선언해서 저장한다.

		return mav;
	}

	// 회원정보 수정 폼 메소드
	public ModelAndView mModifyForm(String memId) {

		// System.out.println("controller-> service "+bNum);

		MEMBER member = mdao.mView(memId);

		// System.out.println("dao-> service "+board);

		// 사진을 미리 저장
		member.setDFileName(member.getMemProfileName());

		// 주소 분리
		int index = member.getMemAddr().indexOf(")");
		member.setAddr1(member.getMemAddr().substring(1, index));
		int index2 = member.getMemAddr().indexOf(",");
		member.setAddr2(member.getMemAddr().substring(index + 1, index2));
		member.setAddr3(member.getMemAddr().substring(index2 + 1));

		int index3 = member.getMemBirth().indexOf("-");
		member.setMemBirth1(member.getMemBirth().substring(0, index3));
		member.setMemBirth2(member.getMemBirth().substring(index3 + 1, index3 + 3));
		member.setMemBirth3(member.getMemBirth().substring(index3 + 4));
		// MODEL
		mav.addObject("modify", member);

		// VIEW
		mav.setViewName("M_Modify");

		return mav;
	}

	// 회원정보 수정 메소드
	public ModelAndView mModify(MEMBER member) throws IllegalStateException, IOException {

		// 파일 정보 가져오기
		MultipartFile mFile = member.getMemProfile();

		// 업로드 파일이 있을때만 실행.
		if (!mFile.getOriginalFilename().isEmpty()) {

			// 파일이름 설정하기
			UUID uuid = UUID.randomUUID();
			// System.out.println("uuid 확인 : "+uuid.toString().substring(0, 8));

			// 날짜
			LocalDate now = LocalDate.now();
			// 시간
			LocalTime now2 = LocalTime.now();
			// 파일 이름은 날짜와 시간 랜덤 식별문자를 파일이름과 합친것
			String fileName = now + "_" + now2.toString().replaceAll("[^\\w+]", "") + "_"
					+ uuid.toString().substring(0, 8) + "_" + mFile.getOriginalFilename();

			// 저장경로에 파일 저장
			String savePath = request.getServletContext().getRealPath("/resources/profileImg/");
			mFile.transferTo(new File(savePath + fileName));

			// board객체에 생성한 업로드파일 이름을 저장한다.
			member.setMemProfileName(fileName);

			String deletePath = request.getServletContext().getRealPath("/resources/profileImg/")
					+ member.getDFileName();
			File deleteFile = new File(deletePath);

			// 만약 새로운 파일이 들어오면 기존파일 삭제해버리세요
			if (deleteFile.exists()) {
				deleteFile.delete();
			}

		} else {
			member.setMemProfileName(member.getDFileName());
		}

		// 주소합체
		String memAddr = "(" + member.getAddr1() + ") " + member.getAddr2() + ", " + member.getAddr3();
		member.setMemAddr(memAddr);

		// [3] 생일 합체
		String memBirth = member.getMemBirth1() + "-" + member.getMemBirth2() + "-" + member.getMemBirth3();
		member.setMemBirth(memBirth);

		// System.out.println("중간확인 :" + member);
		// System.out.println(member);

		int result = mdao.mModify(member);

		if (result > 0) {
			mav.setViewName("redirect:/mList");
		} else {
			mav.setViewName("redirect:/mList");
		}

		mav.setViewName("index");
		return mav;
	}

	// 회원검색 메소드
	public ModelAndView mSearch(SEARCH search, int page, int limit) {

		// 한 화면에 페이지 몇개 보여줄건가?
		int block = 5;

		// 한 화면에 보여줄 게시글 갯수
//		int limit = 5;

		// 전체 게시글 갯수
		int bCount = mdao.mSearchCount(search);
		// 게시글이 0일때 페이지 보여줘
		if (bCount == 0) {
			bCount = 1;
		}
		// ceil: 올림
		int maxPage = (int) (Math.ceil((double) bCount / limit));
		// 오류방지 코드
		if (page > maxPage) {
			page = maxPage;
		}

		int startRow = (page - 1) * limit + 1;
		int endRow = page * limit;

		int startPage = (((int) (Math.ceil((double) page / block))) - 1) * block + 1;
		int endPage = startPage + block - 1;

		// 오류방지 코드
		if (endPage > maxPage) {
			endPage = maxPage;
		}

		search.setPage(page);
		search.setStartRow(startRow);
		search.setEndRow(endRow);
		search.setMaxPage(maxPage);
		search.setStartPage(startPage);
		search.setEndPage(endPage);
		search.setLimit(limit);

		// System.out.println("dao-> service page :" + page);

		List<MEMBER> memberList = mdao.mSearch(search);

		mav.addObject("memberList", memberList);
		mav.setViewName("S_List");
		mav.addObject("searchMode", "member");
		mav.addObject("search", search);
		return mav;
	}

	// 비밀번호 수정하는 수정폼
	public ModelAndView mChangePw(String memId) {

		// System.out.println("controller-> service "+bNum);

		MEMBER member = mdao.mView(memId);

		// System.out.println("dao-> service "+board);

		member.setDFileName(member.getMemProfileName());

		int index = member.getMemAddr().indexOf(")");
		member.setAddr1(member.getMemAddr().substring(1, index));
		int index2 = member.getMemAddr().indexOf(",");
		member.setAddr2(member.getMemAddr().substring(index + 1, index2));
		member.setAddr3(member.getMemAddr().substring(index2 + 1));

		
		int index3 = member.getMemBirth().indexOf("-");
		member.setMemBirth1(member.getMemBirth().substring(0, index3));
		member.setMemBirth2(member.getMemBirth().substring(index3 + 1, index3 + 3));
		member.setMemBirth3(member.getMemBirth().substring(index3 + 4));
		
		
		// MODEL
		mav.addObject("modify", member);

		// VIEW
		mav.setViewName("M_Modify1");

		return mav;

	}

	// 회원정보 수정(비밀번호 수정) 메소드
	public ModelAndView mModify1(MEMBER member) throws IllegalStateException, IOException {
		// 파일 정보 가져오기
		MultipartFile mFile = member.getMemProfile();

		// 업로드 파일이 있을때만 실행.
		if (!mFile.getOriginalFilename().isEmpty()) {

			// 파일이름 설정하기
			UUID uuid = UUID.randomUUID();
			// System.out.println("uuid 확인 : "+uuid.toString().substring(0, 8));

			// 날짜
			LocalDate now = LocalDate.now();
			// 시간
			LocalTime now2 = LocalTime.now();
			// 파일 이름은 날짜와 시간 랜덤 식별문자를 파일이름과 합친것
			String fileName = now + "_" + now2.toString().replaceAll("[^\\w+]", "") + "_"
					+ uuid.toString().substring(0, 8) + "_" + mFile.getOriginalFilename();

			// 저장경로에 파일 저장
			String savePath = request.getServletContext().getRealPath("/resources/profileImg/");
			mFile.transferTo(new File(savePath + fileName));

			// board객체에 생성한 업로드파일 이름을 저장한다.
			member.setMemProfileName(fileName);

			String deletePath = request.getServletContext().getRealPath("/resources/profileImg/")
					+ member.getDFileName();
			File deleteFile = new File(deletePath);

			// 만약 새로운 파일이 들어오면 기존파일 삭제해버리세요
			if (deleteFile.exists()) {
				deleteFile.delete();
			}

		} else {
			member.setMemProfileName(member.getDFileName());
		}

		// 주소합체
		String memAddr = "(" + member.getAddr1() + ") " + member.getAddr2() + ", " + member.getAddr3();
		member.setMemAddr(memAddr);

		// [3] 생일 합체
		String memBirth = member.getMemBirth1() + "-" + member.getMemBirth2() + "-" + member.getMemBirth3();
		member.setMemBirth(memBirth);
		
		// 비밀번호 재설정한것 암호화
		member.setMemPw(pwEnc.encode(member.getMemPw()));

		// System.out.println("ㅅㅈ :" + member);

		int result = mdao.mModify(member);

		if (result > 0) {
			mav.setViewName("redirect:/mList");
		} else {
			mav.setViewName("redirect:/mList");
		}

		mav.setViewName("index");
		return mav;
	}

	// 회원삭제 메소드
	public ModelAndView mDelete(String memId) {
//		System.out.println("controller-> service " + bNum);
		String deleteFileName = mdao.mDelteImg(memId);

		// 서버에서 이미지 파일도 삭제!
		String deletePath = request.getServletContext().getRealPath("/resources/profileImg/") + deleteFileName;
		File deleteFile = new File(deletePath);

		if (deleteFile.exists()) {
			deleteFile.delete();
		}

		int result = mdao.mDelete(memId);

//		System.out.println("dao-> service ");

		if (result > 0) {
			mav.setViewName("redirect:/mList");
		} else {
			// 아래 문자열("") 안에 공백을 넣지 않기!
			mav.setViewName("redirect:/mView?memId=" + memId);
		}

		return mav;
	}

	// 아이디 중복 체크
	public String idoverlap(String memId) {

		String checkId = mdao.mIdCheck(memId);
		String result;

		if (checkId == null) {
			// 아이디 사용가능
			result = "OK";
		} else {
			// 이미 사용중인 아이디
			result = "NO";
		}

		return result;
	}

	// 회원가입시 이메일 인증
	public String mCheckEmail(String memEmail) {

		// 6자리 인증번호 생성
		String uuid = UUID.randomUUID().toString().substring(0, 6);

		// 입력받은 이메일로 전송!

		MimeMessage mail = mailSender.createMimeMessage();

		String mailContent = "<h2>안녕하세요. FISH입니다</h2><br/>" + "<h3>인증번호는 " + uuid + " 입니다.</h3>";

		// System.out.println("실행 가능?1");
		try {
			mail.setSubject("[이메일 인증] FISH 이메일 인증", "UTF-8");
			mail.setText(mailContent, "UTF-8", "HTML");
			mail.addRecipient(RecipientType.TO, new InternetAddress(memEmail));

			mailSender.send(mail);
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// System.out.println("실행 가능?2");

		return uuid;
	}

}
