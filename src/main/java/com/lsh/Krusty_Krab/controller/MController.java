package com.lsh.Krusty_Krab.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lsh.Krusty_Krab.dto.MEMBER;
import com.lsh.Krusty_Krab.dto.SEARCH;
import com.lsh.Krusty_Krab.service.MService;


@Controller
public class MController {
	
	private ModelAndView mav = new ModelAndView();
	
	@Autowired
	MService msvc = new MService();
	
	// 세션
	@Autowired
	private HttpSession session;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		
		return "index";
	}
	
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index() {
		
		return "index";
	}
	
	// mJoinForm : 회원가입 폼
	@RequestMapping(value = "/mJoinForm", method = RequestMethod.GET)
	public String mJoinForm() {
		return "M_Join";
	}
	

	// mJoin : 회원가입
	@RequestMapping(value = "/mJoin", method = RequestMethod.POST)
	public ModelAndView mJoin(@ModelAttribute MEMBER member)
			throws IllegalStateException, NoSuchAlgorithmException, IOException {

		//System.out.println("jsp->controller member: " + member);
		mav = msvc.mJoin(member);

//		mav.setViewName("index");
		return mav;
	}

	// mLoginForm : 로그인Form으로 이동
	@RequestMapping(value = "/mLoginForm", method = RequestMethod.GET)
	public String loginForm() {
		return "M_Login";
	}

	// mLogin : 로그인
	@RequestMapping(value = "/mLogin", method = RequestMethod.POST)
	public ModelAndView mLogin(@RequestParam("memId") String memId, @RequestParam("memPw") String memPw) {

		// System.out.println("[1] jsp → controller\n mId:" + mId+"/ mPw : "+mPw);
		mav = msvc.mLogin(memId, memPw);

		return mav;
	}

	// mLogOut : 로그아웃
	@RequestMapping(value = "/mLogOut", method = RequestMethod.GET)
	public String mLogOut() {
		session.invalidate();
		return "index";
	}

	// mList : 페이징된 회원 목록
	@RequestMapping(value = "/mList", method = RequestMethod.GET)
	public ModelAndView mList(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "limit", required = false, defaultValue = "5") int limit) {
		// value: 어떤거?
		// required: 꼭 필요한가? (값을 무조건 포함에서 와야하나?)
		// defaultValue: 없다면 초기값

		// System.out.println("controller page:"+page);
		mav = msvc.mList(page, limit);

		//System.out.println("service-> controller" + mav);
		return mav;
	}

	// mView : 회원상세보기
	@RequestMapping(value = "/mView", method = RequestMethod.GET)
	public ModelAndView mView(@RequestParam("memId") String memId) {

		// System.out.println("[1] jsp → controller\n mId:" + mId);

		mav = msvc.mView(memId);

		// System.out.println("[5] service → controller\n" + mav);

		return mav;
	}

	// mSearch : 회원검색
	@RequestMapping(value = "/mSearch", method = RequestMethod.GET)
	public ModelAndView mSearch(@ModelAttribute SEARCH search,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "limit", required = false, defaultValue = "5") int limit) {

		// System.out.println("[1] jsp → controller\n mId:" + mId+"/ mPw : "+mPw);
		if (search != null) {
			mav = msvc.mSearch(search, page, limit);
		}
		return mav;
	}
	
	// mSearch1 : 회원검색 페이징 이동시
	@RequestMapping(value = "/mSearch1", method = RequestMethod.GET)
	public ModelAndView mSearch1(@RequestParam(value = "category") String cate,
			@RequestParam(value = "keyword") String key,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "limit", required = false, defaultValue = "5") int limit) {

		
		SEARCH search = new SEARCH();
		search.setCategory(cate);
		search.setKeyword(key);
		
		if (search != null) {
			mav = msvc.mSearch(search, page, limit);
		}
		return mav;
	}

	// mModifyForm : 회원정보 수정 수정폼
	@RequestMapping(value = "/mModifyForm", method = RequestMethod.GET)
	public ModelAndView mModifyForm(@RequestParam("memId") String memId) {
		// System.out.println("controller");
		mav = msvc.mModifyForm(memId);
		// System.out.println("service-> controller"+mav);
		return mav;
	}

	// mModify : 회원정보 수정
	@RequestMapping(value = "/mModify", method = RequestMethod.POST)
	public ModelAndView mModify(@ModelAttribute MEMBER member) throws IllegalStateException, IOException {
		// System.out.println("controller");
		mav = msvc.mModify(member);
		// System.out.println("service-> controller"+mav);
		return mav;
	}

	// mChangePw 비밀번호 수정하는 회원수정폼
	@RequestMapping(value = "/mChangePw", method = RequestMethod.GET)
	public ModelAndView mChangePw(@RequestParam("memId") String memId) {
		// System.out.println("controller");
		mav = msvc.mChangePw(memId);
		// System.out.println("service-> controller"+mav);
		return mav;
	}

	// mModify1 : 회원정보 수정(비밀번호)
	@RequestMapping(value = "/mModify1", method = RequestMethod.POST)
	public ModelAndView mModify1(@ModelAttribute MEMBER member) throws IllegalStateException, IOException {
		// System.out.println("controller");
		mav = msvc.mModify1(member);
		// System.out.println("service-> controller"+mav);
		return mav;
	}

	// mDelete: 회원삭제
	@RequestMapping(value = "/mDelete", method = RequestMethod.GET)
	public ModelAndView mDelete(@RequestParam("memId") String memId) {
		// System.out.println("controller");
		mav = msvc.mDelete(memId);
		// System.out.println("service-> controller"+mav);
		return mav;
	}
	
	// idoverlap: 아이디 중복체크 ajax
	@RequestMapping(value = "/idoverlap", method = RequestMethod.POST)
	public @ResponseBody String idoverlap(@RequestParam("memId") String memId) {
		// ResponseBody : 페이지 이동이 아니라 해당값을 리턴할 것이다.
		
		// System.out.println("overlap memId:"+memId);
		String result = msvc.idoverlap(memId);
		return result;
	}
	
	// mCheckEmail : 회원가입시 이메일 인증(ajax)
	@RequestMapping(value = "/mCheckEmail", method = RequestMethod.POST)
	public @ResponseBody String mCheckEmail(@RequestParam("memEmail") String memEmail) {
		
		// System.out.println("overlap memEmail:"+memEmail);
		
		// uuid: 6자리 인증번호
		String uuid = msvc.mCheckEmail(memEmail);
		
		//System.out.println(uuid);
		return uuid;
	}
}
