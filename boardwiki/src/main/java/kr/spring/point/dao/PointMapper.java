package kr.spring.point.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.point.vo.PointGameVO;
import kr.spring.point.vo.PointVO;

@Mapper
public interface PointMapper {
	//포인트 사용 및 리스트
	/**총 포인트 감소/증가 sql*/
	public void updatepointtotal(PointVO pointVO);
	/**포인트 획득/감소 sql*/
	@Insert("INSERT INTO point (poi_num,poi_status,poi_use,poi_date,mem_num,poi_increase) VALUES (point_seq.nextval,#{poi_status},#{poi_use},SYSDATE,#{mem_num},#{poi_increase})")
	public void insertpoint(PointVO pointVO);
	/**포인트 사용 상세 내역 sql*/
	@Select("SELECT * FROM point JOIN point_total USING(mem_num) WHERE mem_num=#{mem_num}")
	public PointVO selectPoint(PointVO pointVO);
	/**포인트 사용 목록*/
	public List<PointVO> selectPointList(Map<String,Object> map);
	/**포인트 카운트*/
	public Integer selectRowCount(Map<String,Object> map);
	//포인트 확인
	@Select("SELECT * FROM point_total WHERE mem_num = #{mem_num}")
	public Integer selectPointTotal(Long mem_num);
	
	//포인트 게임
	//포인트게임 번호 생성
	@Select("SELECT point_game_seq.nextval FROM dual")
    Long getNextPointGameSeq();
	//포인트 게임 등록
	@Insert("INSERT INTO point_game (poiG_num,poiG_content,poiG_start,str_num,mem_num) VALUES (#{poiG_num},#{poiG_content},SYSDATE,1,#{mem_num})")
	public void insertPointGame(PointGameVO pointGameVO);
	//포인트 게임 상세 불러오기
	@Select("SELECT * FROM point_game WHERE poiG_num=#{poiG_num}")
	public PointGameVO selectPointGame(Long poiG_num);
	//포인트 게임 상세 불러오기
	@Select("SELECT * FROM point_game WHERE mem_num=#{mem_num}")
	public List<PointGameVO> getCreatedGames(Long mem_num);
	//포인트 게임 리스트
	public List<PointGameVO> selectPointGameList(Map<String,Object> map);
	//포인트 게임 카운트
	public Integer selectPointGameRowCount(Map<String,Object> map);
	//포인트 게임 삭제
	@Delete("DELETE FROM point_game WHERE poiG_num=#{poiG_num}")
	public void deletePointGame(Long poiG_num);
	//포인트 게임 종료
	@Update("UPDATE point_game SET poiG_end = SYSDATE WHERE poiG_num = #{poiG_num}")
	public void updatePointGame(@Param("poiG_num") Long poiG_num);
	
	//포인트 게임 옵션
	//포인트 게임 옵션 등록
	@Insert("INSERT INTO point_game_option (poiO_num,poiO_content,poiO_no,poiG_num) VALUES (point_game_option_seq.nextval,#{poiO_content},#{poiO_no},#{poiG_num})")
	public void insertPointOption(PointGameVO pointGameVO);
	//포인트 게임 옵션 상세불러오기
	@Select("SELECT * FROM point_game_option WHERE poiO_num=#{poiO_num}")
	public PointGameVO selectPointOption(Long poiO_num);
	//포인트 게임 옵션 상세불러오기
	@Select("SELECT * FROM point_game_option WHERE poiG_num=#{poiG_num}")
	List<PointGameVO> getGameOptions(Long poiG_num);
	//포인트 게임 옵션 리스트
	public List<PointGameVO> selectPointGameOptionList(Map<String,Object> map);
	//포인트 게임 옵션 카운트
	public Integer selectPointGameOptionRowCount(Map<String,Object> map);
	//포인트 게임 - 포인트게임의 옵션 전부 삭제
	@Delete("DELETE FROM point_game_option WHERE poiG_num=#{poiG_num}")
	public void deletePointGameOption(Long poiG_num);
	
	//포인트 게임 배팅
	//포인트 게임 배팅 등록
	@Insert("INSERT INTO point_game_betting (bet_num,bet_point,poiO_num,mem_num,poiG_num) VALUES (point_game_betting_seq.nextval,#{bet_point},#{poiO_num},#{mem_num},#{poiG_num})")
	public void insertPointBetting(PointGameVO pointGameVO);
	//포인트 게임 배팅 현황 보기
	@Select("SELECT * FROM point_game_betting WHERE mem_num = #{mem_num} AND poiO_num =#{poiO_num}")
	public PointGameVO selectPointGameBetting(Long mem_num,Long poiO_num);
	@Select("SELECT * FROM point_game_betting WHERE poiO_num = #{poiO_num}")
	public List<PointGameVO> selectPointBettingList(@Param("poiO_num") Long poiO_num);
	//포인트 게임 배팅 전체 현황
	public List<PointGameVO> selectPointGameBettingList(Map<String,Object> map);
	//포인트 게임 배팅 카운트
	public Integer selectPointGameBettingRowCount(Map<String,Object> map);
	//포인트 게임 배팅 삭제
	@Delete("DELETE FROM point_game_betting WHERE mem_num=#{mem_num} AND poiO_num=#{poiO_num}")
	public void deletePointGameBetting(Long mem_num,Long poiO_num);
}
