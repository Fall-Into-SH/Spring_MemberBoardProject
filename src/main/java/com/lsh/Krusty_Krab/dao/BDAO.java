package com.lsh.Krusty_Krab.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lsh.Krusty_Krab.dto.BOARD;
import com.lsh.Krusty_Krab.dto.BOARDADMIN;
import com.lsh.Krusty_Krab.dto.BOARDVIDEO;
import com.lsh.Krusty_Krab.dto.PAGE;
import com.lsh.Krusty_Krab.dto.SEARCH;



@Repository
public class BDAO {

	// [1] sql(mapper) 연결

	@Autowired
	private SqlSessionTemplate sql;

	// 게시글 작성
	public int boWrite(BOARD board) {
		sql.update("Board.boAdminCount", board.getBoMode());
		return sql.insert("Board.boWrite", board);
	}

	// 게시글 갯수 파악 (paging처리하기 위해서)
	public int boCount() {
		//System.out.println("service->dao ");
		// 추가할것은 게시판 모드에 관한 페이징이다.
		return sql.selectOne("Board.boCount");
	}
	
	// 게시글 목록
	public List<BOARD> boList(PAGE paging) {
		
		System.out.println("BDAO :"+paging.getBoMode());
		
		if(paging.getBoMode().equals("all")) {
			return sql.selectList("Board.boListAll",paging);
		}else {
			return sql.selectList("Board.boList",paging);
		}
		
	}

	// 게시글 상세보기
	public BOARD boView(int boNum) {
//		System.out.println("service->dao "+bNum);
		sql.update("Board.boHit", boNum);
		return sql.selectOne("Board.boView", boNum);
	}
	
	// 게시글 수정폼
	public BOARD boModifyForm(int boNum, String boMode) {
//		System.out.println("service->dao "+bNum);
		
		return sql.selectOne("Board.boView", boNum);
	}
	
	// 게시글 수정
	public int boModify(BOARD board) {
//		System.out.println("service->dao "+board);
		// 원래 게시판 글 갯수 줄임
		sql.update("Board.boDeleteModeCount", board.getBoMode1());
		// 바꾼 게시판 글 갯수 늘림
		sql.update("Board.boAdminCount", board.getBoMode());
		return sql.update("Board.boModify", board);
	}

	// 게시글 삭제시 이미지 삭제
	public String boDelteImg(int boNum) {
		return sql.selectOne("Board.boDleteImg", boNum);
	}

	// 게시글 삭제 
	public int boDelete(int boNum, String boMode) {
		//System.out.println("service->dao "+bNum);
		sql.update("Board.boDeleteModeCount", boMode);
		return sql.delete("Board.boDelete", boNum);
	}

	// 게시글 검색
	public List<BOARD> boSearch(SEARCH search) {
		return sql.selectList("Board.boSearch", search);
	}

	// 게시판 갯수
	public int boAdminCount() {
		// TODO Auto-generated method stub
		return sql.selectOne("Board.boAdminCount2");
	}

	// 게시판에 대한 리스트
	public List<BOARDADMIN> boAdminList(PAGE paging) {
		return sql.selectList("Board.boAdminList",paging);
	}

	// 상단 바에 게시판 목록 불러오기
	public List<BOARDADMIN> boNavList() {
		return sql.selectList("Board.boNavList");
	}

	// 게시판 이름 중복체크
	public String boardNameOverlap(String boMode) {
		
		return sql.selectOne("Board.boardNameOverlap", boMode);
	}

	// 게시판 생성
	public int boardCreate(BOARDADMIN boardAdmin) {
		
		// 보드에 따른 시퀀스 생성
		String seq ="CREATE SEQUENCE "+boardAdmin.getBoMode()+"_SEQ INCREMENT BY 1";
		
		boardAdmin.setSeq(seq);
		sql.selectOne("Board.boardSEQ", boardAdmin);
		return sql.insert("Board.boardCreate", boardAdmin);
	}

	// 검색한 게시글 수
	public int boSearchCount(SEARCH search) {
		
		return sql.selectOne("Board.boSearchCount",search);
	}

	// 게시판 삭제시 시퀀스 삭제
	public String boardDeleteSEQ(String boMode) {
		
		String seq ="DROP SEQUENCE "+boMode+"_SEQ";
		
		BOARDADMIN board = new BOARDADMIN();
		board.setSeq(seq);
		return sql.selectOne("Board.boardDeleteSEQ", board);
	}

	// 게시판 삭제시 게시글 삭제
	public void boardDeletePost(String boMode) {
		sql.delete("Board.boardDeletePost", boMode);
		
	}
	// 게시판 삭제
	public void boardDeleteMode(String boMode) {
		sql.delete("Board.boardDeleteMode", boMode);
		
	}

	// 게시글 삭제시 댓글 삭제
	public int boCmtDelete(int boNum) {
		return sql.delete("Board.boCmtDelete", boNum);
	}

	// 동영상 업로드(유튜브)
	public int boVideo(BOARDVIDEO board) {
		
		return sql.insert("Board.boVideo", board);
	}

	// 보여줄 비디오 리스트 갯수
	public int boVideoCount() {
		// TODO Auto-generated method stub
		return sql.selectOne("Board.boVideoCount");
	}

	// 페이징처리해서 동영상 보여줫!
	public List<BOARDVIDEO> boVideoList(PAGE paging) {
		return sql.selectList("Board.boVideoList",paging);
	}

	

}
