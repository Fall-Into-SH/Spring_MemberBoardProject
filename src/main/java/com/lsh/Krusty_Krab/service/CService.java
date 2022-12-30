package com.lsh.Krusty_Krab.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lsh.Krusty_Krab.dao.CDAO;
import com.lsh.Krusty_Krab.dto.COMMENT;



@Service
public class CService {

	@Autowired
	private CDAO cdao;
	
	// 해당 게시글의 댓글 검색
	public List<COMMENT> cList(int cbNum) {
		List<COMMENT> commentList = cdao.cList(cbNum);
		return commentList;
	}

	// 댓글 작성
	public List<COMMENT> cmtWrite(COMMENT comment) {
		
		List<COMMENT> commentList;
		
		int result = cdao.cmtWrite(comment);
		
		if(result > 0) {
			commentList = cdao.cList(comment.getCbNum());
		} else {
			commentList = null;
		}
		
		return commentList;
	}

	// 댓글 삭제
	public List<COMMENT> cmtDelete(COMMENT comment) {
		List<COMMENT> commentList;
		
		int result = cdao.cmtDelete(comment);
		
		if(result > 0) {
			commentList = cdao.cList(comment.getCbNum());
		} else {
			commentList = null;
		}
		
		return commentList;
	}

	// 댓글 수정
	public List<COMMENT> cmtModify(COMMENT comment) {
		List<COMMENT> commentList;
		
		int result = cdao.cmtModify(comment);
		
		if(result > 0) {
			commentList = cdao.cList(comment.getCbNum());
		} else {
			commentList = null;
		}
		
		return commentList;
	}

}
