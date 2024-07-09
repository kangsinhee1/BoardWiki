package kr.spring.team.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.team.vo.TeamApplyVO;
import kr.spring.team.vo.TeamFavVO;
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

		
		
		// 모임 신청 및 관리
		
		public void insertTeamApplyByAdmin(TeamVO team);
		public void insertTeamApply(TeamApplyVO teamApply);

}
