package com.lsh.Krusty_Krab.dao;


import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import com.lsh.Krusty_Krab.dto.MEMBER;
import com.lsh.Krusty_Krab.dto.PAGE;
import com.lsh.Krusty_Krab.dto.SEARCH;




@Repository
public class MDAO {

	// [1] sql(mapper) 연결
	
	@Autowired
	private SqlSessionTemplate sql;

	// 아이디 중복체크
	public String mIdCheck(String memId) {
		
		return sql.selectOne("Member.checkId", memId);
	}

	// 회원가입
	public int mJoin(MEMBER member) {
		
		return sql.insert("Member.mJoin",member);
	}
	
	// 로그인
	public String mLogin(MEMBER member) {
		//System.out.println(member+"DAO");
		return sql.selectOne("Member.mLogin", member);
	}
	
	// 회원수
	public int mCount() {
		//System.out.println("service->dao ");
		return sql.selectOne("Member.mCount");
	}

	// 회원목록
	public List<MEMBER> mList(PAGE paging) {
		
		return sql.selectList("Member.mList",paging);
	}
	
	// 회원상세보기
	public MEMBER mView(String memId) {
		//System.out.println("[3] service → dao\n mId : " + mId);
		
		return sql.selectOne("Member.mView", memId);
	}

	// 회원 정보 검색
	public List<MEMBER> mSearch(SEARCH search) {

		return sql.selectList("Member.mSearch", search);
	}
	

	// 회원정보 수정 
	public int mModify(MEMBER member) {
//		System.out.println("service->dao "+board);
		return sql.update("Member.mModify", member);
	}

	// 회원삭제할때 사진 삭제
	public String mDelteImg(String memId) {
		
		return sql.selectOne("Member.mDelteImg", memId);
	}

	// 회원삭제
	public int mDelete(String memId) {
		return sql.delete("Member.mDelete", memId);
	}

	// 검색한 회원수
	public int mSearchCount(SEARCH search) {
		return sql.selectOne("Member.mSearchCount",search);
	}

	// 로그인한 회원은 무슨 권한인가?
	public String mMode(MEMBER member) {
		
		return sql.selectOne("Member.mMode", member);
	}


}
