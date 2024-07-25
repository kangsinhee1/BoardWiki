package kr.spring.mission.service;

import java.util.List;
import java.util.Map;

import kr.spring.mission.vo.MissionVO;

public interface MissionService {
	void addMission(MissionVO mission);
    List<MissionVO> getMissionsByStream(Map<String,Object> map);
    List<MissionVO> getMissionsByMember(Map<String,Object> map);
    void updateMissionStatus(MissionVO mission);
    void deleteMission(Long mis_num);
    Integer selectcountstream(Map<String,Object> map);
    Integer selectcountmember(Map<String,Object> map);
    Integer addMission();
    MissionVO selectmission(Long mis_num);
}
