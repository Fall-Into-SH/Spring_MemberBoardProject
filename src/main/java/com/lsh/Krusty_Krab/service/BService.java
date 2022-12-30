package com.lsh.Krusty_Krab.service;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.lsh.Krusty_Krab.dao.BDAO;
import com.lsh.Krusty_Krab.dto.BOARD;
import com.lsh.Krusty_Krab.dto.BOARDADMIN;
import com.lsh.Krusty_Krab.dto.BOARDVIDEO;
import com.lsh.Krusty_Krab.dto.PAGE;
import com.lsh.Krusty_Krab.dto.SEARCH;
import com.lsh.Krusty_Krab.dto.SPONGEVIEW;

@Service
public class BService {

	// ModelAndView 객체 생성
	private ModelAndView mav = new ModelAndView();

	// DAO(Repository)연결
	@Autowired
	private BDAO bdao;

	// session 추가
	@Autowired
	private HttpSession session;

	// 상대경로
	@Autowired
	private HttpServletRequest request;

	// 게시글 작성
	public ModelAndView boWrite(BOARD board) throws IllegalStateException, IOException {

		// 파일 업로드

		// 파일업로드 시작 지점 파일 업로드할때 save주소를 바꾸어 줄것!
		// 파일 정보 가져오기
		MultipartFile boFile = board.getBoFile();

		// 업로드 파일이 있을때만 실행.
		if (!boFile.getOriginalFilename().isEmpty()) {

			// 파일이름 설정하기
			UUID uuid = UUID.randomUUID();
			// System.out.println("uuid 확인 : "+uuid.toString().substring(0, 8));

			// 날짜
			LocalDate now = LocalDate.now();
			// 시간
			LocalTime now2 = LocalTime.now();
			// 파일 이름은 날짜와 시간 랜덤 식별문자를 파일이름과 합친것
			String fileName = now + "_" + now2.toString().replaceAll("[^\\w+]", "") + "_"
					+ uuid.toString().substring(0, 8) + "_" + boFile.getOriginalFilename();

			// 저장경로에 파일 저장
			String savePath = request.getServletContext().getRealPath("/resources/boardImg/");
			boFile.transferTo(new File(savePath + fileName));

			// DTO객체에 생성한 업로드파일 이름을 저장한다.
			board.setBoFileName(fileName);
		} else {
			board.setBoFileName("");
		} // 파일 업로드 끝지점

		// System.out.println("중간확인 :" + board);

		int result = bdao.boWrite(board);

		if (result > 0) {
			mav.setViewName("redirect:/boList");

		} else {
			mav.setViewName("B_WriteForm");
		}

		return mav;

	}

	// 페이징 처리된 게시글 목록 메소드
	public ModelAndView boList(int page, int limit, String boMode) {

		// 세션이 존재하지 않으면 가져올 수 없기에 존재하지 않을때는 catch를 실행
		try {
			String checkMode = (String) session.getAttribute("boardMode");
			// System.out.println(checkMode);

			// 다른 게시판으로 이동할때, 세션값을 주고 페이지와 리미트를 초기화 한다
			if (checkMode.equals(null) || !boMode.equals(checkMode)) {
				session.setAttribute("boardMode", boMode);
				page = 1;
				limit = 5;
			}
		} catch (Exception e) {
			session.setAttribute("boardMode", boMode);
		}

		// System.out.println("controller-> service page: " + page);

		// 한 화면에 페이지 몇개 보여줄건가?
		int block = 5;

		// 한 화면에 보여줄 게시글 갯수
//		int limit = 5;

		// 전체 게시글 갯수
		int bCount = bdao.boCount();
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

		try {

			String ask = (String) session.getAttribute("loginId");

			// id가 없으면 자유게시판만 볼 수 있다.
			if (ask.equals(null)) {
				mav.addObject("boMode", "자유");
				paging.setBoMode("자유");
			} else {
				mav.addObject("boMode", boMode);
				paging.setBoMode(boMode);
			}

		} catch (Exception e) {
			// 세션 예외사항 발생시 게시판은 자유로 고정된다.
			mav.addObject("boMode", "자유");
			paging.setBoMode("자유");
		}

		List<BOARD> pagingList = bdao.boList(paging);

		// System.out.println("paging성공");

		// MODEL
		mav.addObject("pagingList", pagingList);
		mav.addObject("paging", paging);

		// VIEW

		mav.setViewName("B_List");

		// 이걸 처음에 트라이 처리할려다가 안되서 트라이 안에 if문을 넣어서
		// 처리 하였는데 session오류를 대비해서 try catch는 남겨둔다.

		return mav;
	}

	// 게시글 상세보기 메소드
	public ModelAndView boView(int boNum) {

		// System.out.println("controller-> service "+bNum);

		BOARD board = bdao.boView(boNum);

		// System.out.println("dao-> service "+board);

		// MODEL
		mav.addObject("view", board);

		// VIEW
		mav.setViewName("B_View");

		return mav;
	}

	// 게시글 수정폼
	public ModelAndView boModifyForm(int boNum, String boMode) {

		// System.out.println("controller-> service "+bNum);

		BOARD board = bdao.boModifyForm(boNum, boMode);

		// System.out.println("dao-> service "+board);

		board.setDFileName(board.getBoFileName());
		board.setBoMode1(boMode);
		// MODEL
		mav.addObject("modify", board);

		// VIEW
		mav.setViewName("B_Modify");

		return mav;
	}

	// 게시글 수정
	public ModelAndView boModify(BOARD board) throws IllegalStateException, IOException {

		// 파일 정보 가져오기
		MultipartFile boFile = board.getBoFile();

		// 업로드 파일이 있을때만 실행.
		if (!boFile.getOriginalFilename().isEmpty()) {

			// 파일이름 설정하기
			UUID uuid = UUID.randomUUID();
			// System.out.println("uuid 확인 : "+uuid.toString().substring(0, 8));

			// 날짜
			LocalDate now = LocalDate.now();
			// 시간
			LocalTime now2 = LocalTime.now();
			// 파일 이름은 날짜와 시간 랜덤 식별문자를 파일이름과 합친것
			String fileName = now + "_" + now2.toString().replaceAll("[^\\w+]", "") + "_"
					+ uuid.toString().substring(0, 8) + "_" + boFile.getOriginalFilename();

			// 저장경로에 파일 저장
			String savePath = request.getServletContext().getRealPath("/resources/boardImg/");
			boFile.transferTo(new File(savePath + fileName));

			// board객체에 생성한 업로드파일 이름을 저장한다.
			board.setBoFileName(fileName);

			String deletePath = request.getServletContext().getRealPath("/resources/boardImg/");
			File deleteFile = new File(deletePath + board.getDFileName());

			// 만약 새로운 파일이 들어오면 기존파일 삭제해버리세요
			if (deleteFile.exists()) {
				deleteFile.delete();
			}

		} else {
			board.setBoFileName(board.getDFileName());
		}

		// System.out.println("중간확인 :" + board);

		int result = bdao.boModify(board);

		if (result > 0) {
			mav.setViewName("redirect:/boView?boNum=" + board.getBoNum());
		} else {
			mav.setViewName("redirect:/boList");
		}
		return mav;
	}

	// 게시글 삭제
	public ModelAndView boDelete(int boNum, String boMode) {
//		System.out.println("controller-> service " + bNum);
		String deleteFileName = bdao.boDelteImg(boNum);

		// 서버에서 이미지 파일도 삭제!
		String deletePath = request.getServletContext().getRealPath("/resources/boardImg/") + deleteFileName;
		File deleteFile = new File(deletePath);

		if (deleteFile.exists()) {
			deleteFile.delete();
		}

		
		int result = bdao.boCmtDelete(boNum);
		if(result>0){ 
		result = bdao.boDelete(boNum,boMode);
		}
		
//		System.out.println("dao-> service ");

		if (result > 0) {
			mav.setViewName("redirect:/boList");
		} else {
			// 아래 문자열("") 안에 공백을 넣지 않기!
			mav.setViewName("redirect:/boView?boNum=" + boNum);
		}

		return mav;
	}

	// 게시글검색 메소드
	public ModelAndView boSearch(SEARCH search, int page, int limit) {

		// 한 화면에 페이지 몇개 보여줄건가?
		int block = 5;

		// 한 화면에 보여줄 게시글 갯수
//		int limit = 5;

		// 전체 게시글 갯수
		int bCount = bdao.boSearchCount(search);
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

		List<BOARD> boardList = bdao.boSearch(search);

		mav.addObject("boardList", boardList);
		mav.setViewName("S_List");
		mav.addObject("searchMode", "board");
		mav.addObject("search", search);
		return mav;
	}

	// 게시판 관리자 페이지
	public ModelAndView boardAdmin(int page, int limit) {

		// System.out.println("controller-> service page: " + page);

		// 한 화면에 페이지 몇개 보여줄건가?
		int block = 5;

		// 한 화면에 보여줄 게시글 갯수
//		int limit = 5;

		// 전체 게시글 갯수
		int bCount = bdao.boAdminCount();
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

		List<BOARDADMIN> pagingList = bdao.boAdminList(paging);

		// System.out.println("paging성공");

		// MODEL
		mav.addObject("pagingList", pagingList);
		mav.addObject("paging", paging);

		// VIEW
		mav.setViewName("B_Admin");

		return mav;
	}

	// 게시판 목록 불러오기 ajax
	public List<BOARDADMIN> nav() {
		List<BOARDADMIN> boardList = bdao.boNavList();
		return boardList;
	}

	public String boardNameOverlap(String boMode) {
		String checkMode = bdao.boardNameOverlap(boMode);
		String result;

		if (checkMode == null) {
			// 아이디 사용가능
			result = "OK";
		} else {
			// 이미 사용중인 아이디
			result = "NO";
		}

		return result;
	}

	// 게시판 생성
	public ModelAndView boardCreate(BOARDADMIN boardAdmin) {

		int result = bdao.boardCreate(boardAdmin);

		if (result > 0) {
			mav.setViewName("redirect:/boardAdmin");
		} else {
			mav.setViewName("redirect:/boCreateForm");
		}

		return mav;
	}

	// 스폰지밥 동영상 보기
	public ModelAndView boSponView(int page, int limit) {

		// System.out.println("controller-> service page: " + page);

		// 한 화면에 페이지 몇개 보여줄건가?
		int block = 5;

		// 한 화면에 보여줄 게시글 갯수
//		int limit = 5;

		// 전체 게시글 갯수
		int bCount = bdao.boVideoCount();
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
		List<BOARDVIDEO> pagingList = bdao.boVideoList(paging);

		mav.addObject("pagingList", pagingList);
		mav.addObject("paging", paging);
		mav.setViewName("B_SponView");
		return mav;
	}

	// 게시판 삭제
	public ModelAndView boardDeleteMode(String boMode) {
		String a = bdao.boardDeleteSEQ(boMode);

		bdao.boardDeletePost(boMode);
		bdao.boardDeleteMode(boMode);
		mav.setViewName("redirect:/boardAdmin");
		return mav;
	}

	// 동영상 업로드!
	public ModelAndView boVideo(BOARDVIDEO board) throws IllegalStateException, IOException {

		// 파일 업로드

		// 파일업로드 시작 지점 파일 업로드할때 save주소를 바꾸어 줄것!
		// 파일 정보 가져오기
		MultipartFile boFile = board.getBoFile();

		// 업로드 파일이 있을때만 실행.
		if (!boFile.getOriginalFilename().isEmpty()) {

			// 파일이름 설정하기
			UUID uuid = UUID.randomUUID();
			// System.out.println("uuid 확인 : "+uuid.toString().substring(0, 8));

			// 날짜
			LocalDate now = LocalDate.now();
			// 시간
			LocalTime now2 = LocalTime.now();
			// 파일 이름은 날짜와 시간 랜덤 식별문자를 파일이름과 합친것
			String fileName = now + "_" + now2.toString().replaceAll("[^\\w+]", "") + "_"
					+ uuid.toString().substring(0, 8) + "_" + boFile.getOriginalFilename();

			// 저장경로에 파일 저장
			String savePath = request.getServletContext().getRealPath("/resources/videoImg/");
			boFile.transferTo(new File(savePath + fileName));

			// DTO객체에 생성한 업로드파일 이름을 저장한다.
			board.setBoFileName(fileName);
		} else {
			board.setBoFileName("");
		} // 파일 업로드 끝지점

		// System.out.println("중간확인 :" + board);

		int result = bdao.boVideo(board);

		if (result > 0) {
			mav.setViewName("redirect:/boSponView");

		} else {
			mav.setViewName("redirect:/boVideoForm");
		}

		return mav;
	}

}
