package com.lsh.Krusty_Krab.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lsh.Krusty_Krab.dto.BOARD;
import com.lsh.Krusty_Krab.dto.BOARDADMIN;
import com.lsh.Krusty_Krab.dto.BOARDVIDEO;
import com.lsh.Krusty_Krab.dto.SEARCH;
import com.lsh.Krusty_Krab.service.BService;

@Controller
public class BController {

	private ModelAndView mav = new ModelAndView();

	// 서비스
	@Autowired
	private BService bsvc = new BService();

	// 세션
	@Autowired
	private HttpSession session;

	// boWriteForm : 게시글 작성폼
	@RequestMapping(value = "/boWriteForm", method = RequestMethod.GET)
	public String boWriteForm() {
		return "B_WriteForm";
	}

	// boWrite : 게시글 작성
	@RequestMapping(value = "/boWrite", method = RequestMethod.POST)
	public ModelAndView boWrite(@ModelAttribute BOARD board) throws IllegalStateException, IOException {

//		System.out.println(board);		
//		mav.setViewName("index");
		mav = bsvc.boWrite(board);

		return mav;
	}

	// boList : 게시글 목록
	@RequestMapping(value = "/boList", method = RequestMethod.GET)
	public ModelAndView bList(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "limit", required = false, defaultValue = "5") int limit,
			@RequestParam(value = "boMode", required = false, defaultValue = "자유") String boMode) {
		// value: 어떤거?
		// required: 꼭 필요한가? (값을 무조건 포함에서 와야하나?)
		// defaultValue: 없다면 초기값

		//System.out.println("controller page:" + page);
		mav = bsvc.boList(page, limit, boMode);

		//System.out.println("service-> controller" + mav);
		return mav;
	}

	// boView : 상세보기
	@RequestMapping(value = "/boView", method = RequestMethod.GET)
	public ModelAndView boView(@RequestParam("boNum") int boNum) {

		// System.out.println("controller");
		mav = bsvc.boView(boNum);

		// System.out.println("service-> controller"+mav);
		return mav;
	}

	// boModifyForm : 게시글 수정 수정폼
	@RequestMapping(value = "/boModifyForm", method = RequestMethod.GET)
	public ModelAndView boModifyForm(@RequestParam("boNum") int boNum, @RequestParam("boMode") String boMode) {
		// System.out.println("controller");
		mav = bsvc.boModifyForm(boNum, boMode);
		// System.out.println("service-> controller"+mav);
		return mav;
	}

	// boModify : 게시글 수정
	@RequestMapping(value = "/boModify", method = RequestMethod.POST)
	public ModelAndView boModify(@ModelAttribute BOARD board) throws IllegalStateException, IOException {
		// System.out.println("controller");
		mav = bsvc.boModify(board);
		// System.out.println("service-> controller"+mav);
		return mav;
	}

	// boDelete : 게시글 삭제
	@RequestMapping(value = "/boDelete", method = RequestMethod.GET)
	public ModelAndView bDelete(@RequestParam("boNum") int boNum, @RequestParam("boMode") String boMode) {

		// System.out.println("controller");
		mav = bsvc.boDelete(boNum,boMode);

		// System.out.println("service-> controller"+mav);

		return mav;
	}


	// boSearch : 게시글 검색
	@RequestMapping(value = "/boSearch", method = RequestMethod.GET)
	public ModelAndView mSearch(@ModelAttribute SEARCH search,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "limit", required = false, defaultValue = "5") int limit) {


		if (search != null) {
			mav = bsvc.boSearch(search, page, limit);
		}
		return mav;
	}
	// boSearch1 : 게시글 검색 페이징 이동시
	@RequestMapping(value = "/boSearch1", method = RequestMethod.GET)
	public ModelAndView mSearch1(@RequestParam(value = "category") String cate,
			@RequestParam(value = "keyword") String key,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "limit", required = false, defaultValue = "5") int limit) {

		
		SEARCH search = new SEARCH();
		search.setCategory(cate);
		search.setKeyword(key);
		
		if (search != null) {
			mav = bsvc.boSearch(search, page, limit);
		}
		return mav;
	}

	// boardAdmin : 게시판 관리
	@RequestMapping(value = "/boardAdmin", method = RequestMethod.GET)
	public ModelAndView boardAdmin(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
								@RequestParam(value = "limit", required = false, defaultValue = "10") int limit) {

		mav=bsvc.boardAdmin(page,limit);
		return mav;
	}
	
	// boardList : ajax로 게시판 목록 가져오기
	@RequestMapping(value="/boardList", method=RequestMethod.GET)
	public @ResponseBody List<BOARDADMIN> boardList(){
		List <BOARDADMIN> commentList = bsvc.nav();
		 //System.out.println("여기까지 되나요?"+commentList);
		return commentList;
	}

	//boardCreateForm : 게시판 생성폼으로 이동
	@RequestMapping(value = "/boCreateForm", method = RequestMethod.GET)
	public String boardCreateForm() {
		return "B_CreateForm";
	}
	
	//boardNameOverlap : 게시판 생성시 이름중복 체크 (ajax)
	@RequestMapping(value = "/boardNameOverlap", method = RequestMethod.POST)
	public @ResponseBody String boardNameOverlap(@RequestParam("boMode") String boMode) {

		String result = bsvc.boardNameOverlap(boMode);
		return result;
	}
	
	//boardCreate : 게시판 생성
	@RequestMapping(value = "/boardCreate", method = RequestMethod.POST)
	public ModelAndView boardCreate(@ModelAttribute BOARDADMIN boardAdmin){

//		System.out.println(boardAdmin);		
		mav = bsvc.boardCreate(boardAdmin);

		return mav;
	}
	
	//boSponView : 스폰지밥 동영상 보기
	@RequestMapping(value = "/boSponView", method = RequestMethod.GET)
	public ModelAndView boSponView(@RequestParam(value = "vpage", required = false, defaultValue = "1") int page,
			@RequestParam(value = "vlimit", required = false, defaultValue = "2") int limit) {


		//System.out.println("controller page:" + page);
		mav = bsvc.boSponView(page, limit);

		//System.out.println("service-> controller" + mav);
		return mav;
	}
	
	//boardDeleteMode: 게시판 삭제
	@RequestMapping(value = "/boardDeleteMode", method = RequestMethod.GET)
	public ModelAndView boardDeleteMode(@RequestParam(value = "boMode", required = false, defaultValue = "1") String boMode) {

		mav = bsvc.boardDeleteMode(boMode);
		return mav;
	}
	
	//boVideoForm: 스폰지밥 동영상 올리기 폼
	@RequestMapping(value = "/boVideoForm", method = RequestMethod.GET)
	public String boVideo() {
		return "B_VideoForm";
	}
	
	//boVideo : 스폰지밥 동영상 올리기
	@RequestMapping(value = "/boVideo", method = RequestMethod.POST)
	public ModelAndView boVideo(@ModelAttribute BOARDVIDEO board) throws IllegalStateException, IOException {

//		System.out.println(board);		
//		mav.setViewName("index");
		mav = bsvc.boVideo(board);

		return mav;
	}
}
