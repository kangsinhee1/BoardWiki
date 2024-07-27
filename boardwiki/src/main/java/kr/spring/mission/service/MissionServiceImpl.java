package kr.spring.mission.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.mission.dao.MissionMapper;
import kr.spring.mission.vo.MissionVO;

@Service
@Transactional
public class MissionServiceImpl implements MissionService{

	@Autowired
    private MissionMapper missionMapper;

	@Override
	public void addMission(MissionVO mission) {
		missionMapper.insertMission(mission);
	}

	@Override
	public List<MissionVO> getMissionsByStream(Map<String, Object> map) {
		return missionMapper.getMissionsByStream(map);
	}

	@Override
	public List<MissionVO> getMissionsByMember(Map<String, Object> map) {
		return missionMapper.getMissionsByMember(map);
	}

	@Override
	public void updateMissionStatus(MissionVO mission) {
		missionMapper.updateMissionStatus(mission);
	}

	@Override
	public void deleteMission(Long mis_num) {
		missionMapper.deleteMission(mis_num);
	}

	@Override
	public Integer selectcountstream(Map<String, Object> map) {
		return missionMapper.selectcountstream(map);
	}

	@Override
	public Integer selectcountmember(Map<String, Object> map) {
		return missionMapper.selectcountmember(map);
	}

	@Override
	public Integer addMission() {

		return missionMapper.addMission();
	}

	@Override
	public MissionVO selectmission(Long mis_num) {
		return missionMapper.selectmission(mis_num);
	}

}
