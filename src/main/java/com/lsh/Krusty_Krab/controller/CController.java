package com.lsh.Krusty_Krab.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lsh.Krusty_Krab.dto.COMMENT;
import com.lsh.Krusty_Krab.service.CService;



@Controller
@RequestMapping("/comment")
public class CController {
	
	@Autowired
	private CService csvc;
	
	// 해당 게시글의 댓글 검색
	@RequestMapping(value="/commentList", method=RequestMethod.GET)
	public @ResponseBody List<COMMENT> cList(@RequestParam("cbNum") int cbNum){
		List <COMMENT> commentList = csvc.cList(cbNum);
		 //System.out.println("여기까지 되나요?"+commentList);
		return commentList;
	}
	
	// cmtWrite : 댓글 작성
	@RequestMapping(value="cmtWrite", method = RequestMethod.POST)
	public @ResponseBody List<COMMENT> cmtWrite(@ModelAttribute COMMENT comment){
		List<COMMENT> cList = csvc.cmtWrite(comment);
		return cList;
	}
	
	// cmtDelete : 댓글삭제
	@RequestMapping(value="cmtDelete", method = RequestMethod.POST)
	public @ResponseBody List<COMMENT> cmtDelete(@ModelAttribute COMMENT comment){
		List<COMMENT> cList = csvc.cmtDelete(comment);
		return cList;
	}
	
	// cmtModify: 댓글 수정
	@RequestMapping(value="cmtModify", method = RequestMethod.POST)
	public @ResponseBody List<COMMENT> cmtModify(@ModelAttribute COMMENT comment){
		List<COMMENT> cList = csvc.cmtModify(comment);
		return cList;
	}
	
	
	
}
