package kr.spring.team.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.team.dao.TeamMapper;
import kr.spring.team.vo.TeamApplyVO;
import kr.spring.team.vo.TeamBoardVO;
import kr.spring.team.vo.TeamFavVO;
import kr.spring.team.vo.TeamReplyVO;
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
		teamMapper.insertTeamApplyByAdmin(team);
		
	}

	@Override
	public List<TeamApplyVO> selectTeamListApplied(Map<String, Object> map) {
		
		return teamMapper.selectTeamListApplied(map);
	}

	@Override
	public Integer selectTeamApplyList(TeamApplyVO teamApply) {
		return teamMapper.selectTeamApplyList(teamApply);
	}

	@Override
	public TeamApplyVO selectTeamApplyListByTeamNum(long tea_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateTeamApply(TeamApplyVO teamApply) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteTeamApply(long teaA_num) {
		teamMapper.deleteTeamApply(teaA_num);
	}

	@Override
	public void deleteTeamApplyByTeaNum(long tea_num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateTeamApplyUser(TeamApplyVO teamApply) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<TeamBoardVO> selectTeamBoardList(Map<String, Object> map) {
		return teamMapper.selectTeamBoardList(map);
	}

	@Override
	public Integer selectTeamBoardRowCount(Map<String, Object> map) {
		return teamMapper.selectTeamBoardRowCount(map);
	}

	@Override
	public void insertTeamBoard(TeamBoardVO teamBoard) {
		teamMapper.insertTeamBoard(teamBoard);
	}

	@Override
	public TeamBoardVO getTeamBoardDetail(long teaB_num) {
		return teamMapper.getTeamBoardDetail(teaB_num);
	}

	@Override
	public void updateTeamBoard(TeamBoardVO teamBoard) {
		teamMapper.updateTeamBoard(teamBoard);
		
	}

	@Override
	public void deleteTeamBoard(long teaB_num) {
		teamMapper.deleteTeamBoard(teaB_num);
	}

	@Override
	public void deleteTeamBoardFile(long teaB_num) {
		teamMapper.deleteTeamBoardFile(teaB_num);
	}

	@Override
	public void updateHitTeamBoard(long teaB_num) {
		teamMapper.updateHitTeamBoard(teaB_num);
	}

	@Override
	public List<TeamReplyVO> selectTeamBoardReplyList(Map<String, Object> map) {
		return teamMapper.selectTeamBoardReplyList(map);
	}

	@Override
	public Integer selectTeamBoardReplyCount(Map<String, Object> map) {
		return teamMapper.selectTeamBoardReplyCount(map);
	}

	@Override
	public void insertTeamBoardReply(TeamReplyVO teamReply) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateTeamBoardReply(TeamReplyVO teamReply) {
	}

	@Override
	public void deleteTeamBoardReply(long teaR_num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteTeamBoardReplyByTeamBoardNum(long teaB_num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<TeamApplyVO> selectTeamApplyListByMem_Num (long mem_num) {
		return teamMapper.selectTeamApplyListByMem_Num(mem_num);
	}

}
