package kr.spring.team.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.team.vo.TeamFavVO;
import kr.spring.team.vo.TeamVO;

@Mapper
public interface TeamMapper {
	//모임 관리( 관리자)
		//목록보기
		public Integer getTeamRowCount(Map<String,Object>map);
		public List<TeamVO> selectTeamList(Map<String,Object>map);
		//등록
		public void insertTeam(TeamVO team);
		//수정
		public TeamVO updateTeam(Long tea_num);
		//일정 등록
		public void updateTeamSchedule(Long tea_num);
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
		public void deleteTeamFavByTeamNum(TeamFavVO tFav);


}
