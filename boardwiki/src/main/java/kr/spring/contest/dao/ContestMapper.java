package kr.spring.contest.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.board.vo.BoardVO;
import kr.spring.contest.vo.ContestApplyVO;
import kr.spring.contest.vo.ContestVO;

@Mapper
public interface ContestMapper {
	//목록보기
	public Integer selectRowCount(Map<String,Object>map);
	public List<ContestVO> selectAllcontest(Map<String,Object> map);
	//대회리스트
	public List<ContestVO> selectContestList(Map<String,Object>map);
	//대회 작성
	public void insertContest(ContestVO contest);

	@Select("SELECT COUNT(*) FROM contest")
	public Integer countAllcontest(Map<String,Object> map);
	
	@Select("SELECT * FROM contest WHERE con_num = #{con_num}")
	public ContestVO selectContest(long con_num);
	public void updateContest(ContestVO contest);


	//대회 상세
	@Select("SELECT * FROM contest JOIN member USING(mem_num)LEFT OUTER JOIN member_detail USING(mem_num) WHERE con_num= #{con_num}")
	public ContestVO detailContest(long con_num);

	//관리자 대회 리스트 조회
	@Select("SELECT COUNT(*) FROM member JOIN contest_APPLY USING(mem_num)LEFT OUTER JOIN member_detail USING(mem_num) WHERE con_num=#{con_num}")
	public Integer countContestAdminApplyList(long con_num);
	public List<ContestVO> selectContestAdminApplyList(Map<String,Object>map);

	//유저 신청 대회 리스트 조회
	@Select("SELECT COUNT(*) FROM contest_apply a JOIN contest c USING(con_num) WHERE a.mem_num = #{mem_num} AND (CON_STATUS = 0 OR CON_STATUS = 2)")
	public Integer countContestUserApplyList(long mem_num);
	public List<ContestVO> selectContestUserApplyList(Map<String,Object>map);

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

	//대회 리스트 숨김 처리
	@Update("UPDATE contest set con_status = 3 WHERE con_num = #{con_num}")
	public void deleteContest(Long con_num);

	public List<ContestVO> selectContestListForStatusOrder(Map<String,Object>map);
}
