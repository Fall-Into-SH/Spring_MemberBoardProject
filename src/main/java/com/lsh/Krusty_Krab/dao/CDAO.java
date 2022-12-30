package com.lsh.Krusty_Krab.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lsh.Krusty_Krab.dto.COMMENT;



@Repository
public class CDAO {

	@Autowired
	private SqlSessionTemplate sql;
	
	// 해당 게시글의 댓글 검색
	public List<COMMENT> cList(int cbNum) {
		return sql.selectList("Comment.cList", cbNum);
	}

	// 댓글 작성
	public int cmtWrite(COMMENT comment) {
		return sql.insert("Comment.cmtWrite", comment);
	}
	
	// 댓글 삭제
	public int cmtDelete(COMMENT comment) {
		return sql.delete("Comment.cmtDelte", comment);
	}

	// 댓글 수정
	public int cmtModify(COMMENT comment) {
		
		return sql.update("Comment.cmtModify", comment);
	}

}
