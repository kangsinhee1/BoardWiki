package kr.spring.team.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.team.dao.TeamMapper;
import kr.spring.team.vo.TeamApplyVO;
import kr.spring.team.vo.TeamFavVO;
import kr.spring.team.vo.TeamVO;

@Service
@Transactional
public class TeamServiceImpl implements TeamService {
	@Autowired
	TeamMapper teamMapper;
	
	@Override
	public Integer getTeamRowCount(Map<String, Object> map) {
		return teamMapper.getTeamRowCount(map);
	}

	@Override
	public List<TeamVO> selectTeamList(Map<String, Object> map) {
		return teamMapper.selectTeamList(map);
	}

	@Override
	public void insertTeam(TeamVO teamVO) {
		teamVO.setTea_num(teamMapper.selectTea_num());
		teamMapper.insertTeam(teamVO);
		teamMapper.insertTeamApplyByAdmin(teamVO);
	}

	@Override
	public void updateTeam(TeamVO teamVO) {
		teamMapper.updateTeam(teamVO);
	}

	@Override
	public void updateTeamSchedule(Long tea_num) {
		teamMapper.updateTeamSchedule(tea_num);
	}

	@Override
	public void updateTeamHit(Long tea_num) {
		teamMapper.updateTeamHit(tea_num);
	}

	@Override
	public void updateTeamStatus(Long tea_num) {
		teamMapper.updateTeamStatus(tea_num);
	}

	@Override
	public TeamFavVO selectTeamFav(TeamFavVO tFav) {
		return teamMapper.selectTeamFav(tFav);
	}

	@Override
	public Integer selectTeamFavCount(long tea_num) {
		return teamMapper.selectTeamFavCount(tea_num);
	}

	@Override
	public void insertTeamFav(TeamFavVO tFav) {
		teamMapper.insertTeamFav(tFav);
	}

	@Override
	public void deleteTeamFav(TeamFavVO tFav) {
		teamMapper.deleteTeamFav(tFav);
	}

	@Override
	public void deleteTeamFavByTeamNum(long tea_num ) {
		teamMapper.deleteTeamFavByTeamNum(tea_num);
	}

	@Override
	public TeamVO detailTeam(long tea_num) {
		return teamMapper.detailTeam(tea_num);
	}


	@Override
	public void insertTeamApply(TeamApplyVO teamApply) {
		teamMapper.insertTeamApply(teamApply);
	}

	@Override
	public void insertTeamApplyByAdmin(TeamVO team) {
		// TODO Auto-generated method stub
		
	}

}
