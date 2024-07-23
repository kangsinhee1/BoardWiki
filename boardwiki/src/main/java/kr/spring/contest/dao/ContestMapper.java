package kr.spring.contest.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.contest.vo.ContestApplyVO;
import kr.spring.contest.vo.ContestVO;

@Mapper
public interface ContestMapper {
	//목록보기
	public Integer selectRowCount(Map<String,Object>map);
	//대회리스트
	public List<ContestVO> selectContestList(Map<String,Object>map);
	//대회 작성
	public void insertContest(ContestVO contest);

	//대회 상세
	@Select("SELECT * FROM contest JOIN member USING(mem_num)LEFT OUTER JOIN member_detail USING(mem_num) WHERE con_num= #{con_num}")
	public ContestVO detailContest(long con_num);

	//조회수
	@Update("UPDATE contest SET con_hit= con_hit+1 WHERE con_num = #{con_num}")
	public void updateContestHit(Long con_num);

	//대회 신청
	public void applyForContest(ContestApplyVO contestApplyVO);

	//중복 신청 확인
	@Select("SELECT count(*) FROM contest_apply WHERE con_num=#{con_num} AND mem_num=#{mem_num}")
	public Integer selectContestApplyList(ContestApplyVO contestApplyVO);
	
	//대회 신청 처리 후 con_max값 +1
	public void updateContestManCount(ContestApplyVO contestApplyVO);
	
	public void deleteContestApply(ContestApplyVO contestApplyVO);
	
	@Select("SELECT COUNT(*) FROM contest_APPLY WHERE con_num = #{con_num}")
	public Integer countContestMan(Long con_num);
}
