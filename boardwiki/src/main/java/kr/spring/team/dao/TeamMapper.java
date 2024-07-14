package kr.spring.team.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.team.vo.TeamApplyVO;
import kr.spring.team.vo.TeamBoardVO;
import kr.spring.team.vo.TeamFavVO;
import kr.spring.team.vo.TeamReplyVO;
import kr.spring.team.vo.TeamVO;

@Mapper
public interface TeamMapper {
	//모임 관리( 관리자)
		@Select("SELECT team_seq.nextval FROM dual")
		public Long selectTea_num();
		//목록보기
		public Integer getTeamRowCount(Map<String,Object>map);
		
		public List<TeamVO> selectTeamList(Map<String,Object>map);
		//모임 상세
		@Select("SELECT * FROM team JOIN member USING(mem_num) WHERE tea_num= #{tea_num}") 
		public TeamVO detailTeam(long tea_num);
		//등록
		public void insertTeam(TeamVO team);
		//수정
		public void updateTeam(TeamVO team);
		//일정 등록
		public void updateTeamSchedule(Long tea_num);
		//조회수
		@Update("UPDATE team SET tea_hit= tea_hit+1 WHERE tea_num = #{tea_num}")
		public void updateTeamHit(Long tea_num);
		//비활성화
		@Update("UPDATE team SET tea_status = 0 WHERE tea_num = #{tea_num}")
		public void updateTeamStatus(Long tea_num);
		
		
		//모임 좋아요 확인
		@Select("SELECT * FROM team_fav WHERE mem_num=#{mem_num} AND tea_num=#{tea_num}")
		public TeamFavVO selectTeamFav(TeamFavVO tFav);
		//모임 좋아요 개수
		@Select("SELECT count(*) FROM team_fav WHERE tea_num=#{tea_num}")
		public Integer selectTeamFavCount(long tea_num);
		//모임 좋아요 등록
		@Insert("INSERT INTO team_fav(mem_num,tea_num) VALUES(#{mem_num},#{tea_num})")
		public void insertTeamFav(TeamFavVO tFav);
		//모임 좋아요 취소
		@Delete("delete FROM team_fav WHERE mem_num=#{mem_num} AND tea_num = #{tea_num}")
		public void deleteTeamFav(TeamFavVO tFav);
		@Delete("DELETE FROM team_fav WHERE tea_num=#{tea_num}")
		public void deleteTeamFavByTeamNum(long tea_num);

		// 회원이 가입한 모임
		public List<TeamApplyVO> selectTeamListApplied(Map<String,Object>map);
		// 본인이 등록한 모임
		public List<TeamApplyVO> selectTeamListRegistered(Map<String,Object>map);
		
		
		// 모임 신청 및 관리
		
		public void insertTeamApplyByAdmin(TeamVO team);
		public void insertTeamApply(TeamApplyVO teamApply);
		
		//신청 목록 확인
		
		@Select("SELECT count(*) FROM team_apply WHERE tea_num=#{tea_num} AND mem_num=#{mem_num}")
		public Integer selectTeamApplyList(TeamApplyVO teamApply);
		
		//모임별 신청회원 확인
		@Select("SELECT * FROM team_apply WHERE tea_num=#{tea_num} AND mem_num=#{mem_num}")
		public TeamApplyVO selectTeamApplyListByTeamNum(long tea_num);
		//개인별 신청 모임 게시판 확인
		
		@Select("SELECT * FROM team_apply WHERE mem_num=#{mem_num}")
		public List<TeamApplyVO> selectTeamApplyListByMem_Num(long mem_num);
		
		@Update("UPDATE team_apply SET teaA_content = #{teaA_content} WHERE teaA_num = #{teaA_num}")
		public 	void updateTeamApply(TeamApplyVO teamApply);
		@Delete("DELETE FROM team_apply WHERE teaA_num=#{teaA_num}")
		public void deleteTeamApply(long teaA_num);
		@Delete("DELETE FROM team_apply WHERE tea_num=#{tea_num}")
		public void deleteTeamApplyByTeaNum(long tea_num);
		
		
		//모임 신청 처리
		@Update("UPDATE team_apply SET teaA_attend=1 WHERE teaA_num=#{teaA_num}")
		public void updateTeamApplyUser(TeamApplyVO teamApply);
		//모임 참석 회원 확인
		@Select("SELECT * FROM team_apply JOIN team USING(mem_num) WHERE teaA_attend=1")
		public void selectTeamApplyATTEND(TeamApplyVO teamApply);
		
		//모임 게시판 관리
		
		//모임 게시판 목록
		
		public List<TeamBoardVO> selectTeamBoardList(Map<String,Object>map);
		//모임 게시판 개수
		
		public Integer selectTeamBoardRowCount(Map<String,Object>map);
		//모임 게시판 등록
		public void insertTeamBoard(TeamBoardVO teamBoard);
		//모임 게시판 상세
		@Select("SELECT * FROM team_board WHERE teaB_num = #{teaB_num}")
		public TeamBoardVO getTeamBoardDetail(long teaB_num);
		//모임 게시판 수정
		@Update("UPDATE team_board set teaB_title=#{teaB_title}, teaB_content =#{teaB_content}, teaB_mdate = sysdate, teaB_category= #{teaB_category} ,filename= #{filename, jdbcType=VARCHAR} WHERE teaB_num = #{teaB_num}")
		public void updateTeamBoard(TeamBoardVO teamBoard);
		//모임 게시판 삭제
		@Delete("DELETE FROM team_board WHERE teaB_num = #{teaB_num}")
		public void deleteTeamBoard(long teaB_num);
		//모임 게시판 파일 관리
		@Update("UPDATE team_board set filename='' WHERE teaB_num = #{teaB_num}")
		public void deleteTeamBoardFile(long teaB_num);
		//모임 게시판 조회수
		@Update("UPDATE team_board SET teaB_hit = teaB_hit+1 WHERE teaB_num=#{teaB_num}")
		public void updateHitTeamBoard(long teaB_num);
		// 모임게시판 댓글
		//댓글 목록
		public List<TeamReplyVO> selectTeamBoardReplyList(Map<String,Object>map);
		//댓글 갯수
		@Select("SELECT COUNT(*) FROM team_reply WHERE teaB_num=#{teaB_num}")
		
		public Integer selectTeamBoardReplyCount(Map<String,Object>map);
		//댓글 등록
		public void insertTeamBoardReply(TeamReplyVO teamReply);
		//댓글 수정
		public void updateTeamBoardReply(TeamReplyVO teamReply);
		//댓글 삭제
		public void deleteTeamBoardReply(long teaR_num);
		//부모글 삭제시 댓글 삭제
		public void deleteTeamBoardReplyByTeamBoardNum(long teaB_num);
		
		
		

}
