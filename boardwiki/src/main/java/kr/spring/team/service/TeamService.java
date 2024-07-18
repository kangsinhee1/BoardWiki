package kr.spring.team.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.team.vo.TeamApplyVO;
import kr.spring.team.vo.TeamBoardVO;
import kr.spring.team.vo.TeamFavVO;
import kr.spring.team.vo.TeamReplyVO;
import kr.spring.team.vo.TeamVO;

public interface TeamService {
	//모임 관리( 관리자)
			//목록보기
			public Integer getTeamRowCount(Map<String,Object>map);
			public List<TeamVO> selectTeamList(Map<String,Object>map);
			public List<TeamVO> selectTeamListAdmin(Map<String,Object>map);
			//상세
			public TeamVO detailTeam(long tea_num);
			//등록
			public void insertTeam(TeamVO team);
			//수정
			public void updateTeam(TeamVO teamVO);
			//일정 등록
			public void updateTeamSchedule(@Param(value="tea_num")long tea_num,@Param(value="tea_time") String tea_time);
			//조회수
			public void updateTeamHit(Long tea_num);
			//비활성화
			public void updateTeamStatus(Long tea_num);
			
			
			//모임 좋아요 확인
			public TeamFavVO selectTeamFav(TeamFavVO tFav);
			//모임 좋아요 개수
			public Integer selectTeamFavCount(long tea_num);
			//모임 좋아요 등록
			public void insertTeamFav(TeamFavVO tFav);
			//모임 좋아요 취소
			public void deleteTeamFav(TeamFavVO tFav);
			public void deleteTeamFavByTeamNum(long tea_num);
			//모임 신청
			public void insertTeamApplyByAdmin(TeamVO team);
			public void insertTeamApply(TeamApplyVO teamApply);

			//신청 목록 확인
			public Integer selectTeamApplyList(TeamApplyVO teamApply);
			//신청 회원 갯수
			public Integer countTeamApplyList(long tea_num);
			
			// 회원이 가입한 모임
			public List<TeamApplyVO> selectTeamListApplied(Map<String,Object>map);
			//회원이 신청한 모든 모임 목록 (결과포함)
			public List<TeamApplyVO> selectTeamListApplied2(Map<String,Object>map);
			//모임별 신청회원 확인
			public TeamApplyVO selectTeamApplyListByTeamNum(TeamApplyVO teamApplyVO);
			//모임 정보 확인
			public TeamApplyVO getTeamApply (@Param(value="teaA_num")long teaA_num);
			public void updateTeamApply(TeamApplyVO teamApply);
			
			public void deleteTeamApply(long teaA_num);
			
			public void deleteTeamApplyByTeaNum(long tea_num);
			
			//모임 신청 처리
			public void updateTeamApplyUser(TeamApplyVO teamApply);
			
			public void deleteTeamApplyAttend(long tea_num);
			
			//개인별 신청 모임 게시판 확인
			public List<TeamApplyVO> selectTeamApplyListByMem_Num(long mem_num);
			//모임 게시판 관리
			//모임 게시판 목록
			public List<TeamBoardVO> selectTeamBoardList(Map<String,Object>map);
			//모임 게시판 개수
			public Integer selectTeamBoardRowCount(Map<String,Object>map);
			//모임 게시판 등록
			public void insertTeamBoard(TeamBoardVO teamBoard);
			//모임 게시판 상세
			public TeamBoardVO getTeamBoardDetail(long teaB_num);
			//모임 게시판 수정
			public void updateTeamBoard(TeamBoardVO teamBoard);
			//모임 게시판 삭제
			public void deleteTeamBoard(long teaB_num);
			//모임 게시판 파일 관리
			public void deleteTeamBoardFile(long teaB_num);
			//모임 게시판 조회수
			public void updateHitTeamBoard(long teaB_num);
			// 모임게시판 댓글
			//댓글 확인
			public TeamReplyVO getTeamReply(long teaR_num);
			//댓글 목록
			public List<TeamReplyVO> selectTeamBoardReplyList(Map<String,Object>map);
			//댓글 갯수
			public Integer selectTeamBoardReplyCount(Map<String,Object>map);
			//댓글 등록
			public void insertTeamBoardReply(TeamReplyVO teamReply);
			//댓글 수정
			public void updateTeamBoardReply(TeamReplyVO teamReply);
			//댓글 삭제
			public void deleteTeamBoardReply(long teaR_num);
			//부모글 삭제시 댓글 삭제
			public void deleteTeamBoardReplyByTeamBoardNum(long teaB_num);
			
			
			public List<TeamApplyVO> listTeamApply(TeamApplyVO teamApply);
			
			public void updateTeamApplyStatus(@Param(value="teaA_status")long teaA_status,@Param(value="teaA_num")long teaA_num);
}
