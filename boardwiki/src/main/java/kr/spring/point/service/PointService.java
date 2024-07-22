package kr.spring.point.service;

import java.util.List;
import java.util.Map;

import kr.spring.point.vo.PointGameVO;
import kr.spring.point.vo.PointVO;

public interface PointService {
	public void processPointTransaction(PointVO pointVO);
	public PointVO selectPoint(PointVO pointVO);
	public List<PointVO> selectPointList(Map<String,Object> map);
	public Integer selectRowCount(Map<String,Object> map);

	//포인트 게임
	//포인트 게임 등록
	public void insertPointGame(PointGameVO pointGameVO);
	//포인트 게임 상세 불러오기
	public PointGameVO selectPointGame(Long poiG_num);
	//포인트 게임 리스트
	public List<PointGameVO> selectPointGameList(Map<String,Object> map);
	//포인트 게임 카운트
	public Integer selectPointGameRowCount(Map<String,Object> map);
	//포인트 게임 삭제
	public void deletePointGame(Long poiG_num);
	//포인트 게임 종료
	public void updatePointGame(Long poiG_num);

	//포인트 게임 옵션
	//포인트 게임 옵션 등록
	public void insertPointOption(PointGameVO pointGameVO);
	//포인트 게임 옵션 상세불러오기
	public PointGameVO selectPointOption(Long poiO_num);
	//포인트 게임 옵션 리스트
	public List<PointGameVO> selectPointGameOptionList(Map<String,Object> map);
	//포인트 게임 옵션 카운트
	public Integer selectPointGameOptionRowCount(Map<String,Object> map);

	//포인트 게임 배팅
	//포인트 게임 배팅 등록
	public void insertPointBetting(PointGameVO pointGameVO);
	//포인트 게임 배팅 현황 보기
	public PointGameVO selectPointGameBetting(Long mem_num,Long poiO_num);
	//포인트 게임 배팅 전체 현황
	public List<PointGameVO> selectPointGameBettingList(Map<String,Object> map);
	//포인트 게임 배팅 카운트
	public Integer selectPointGameBettingRowCount(Map<String,Object> map);
	//포인트 게임 배팅 삭제
	public void deletePointGameBetting(Long mem_num,Long poiO_num);

	public long getNextPointGameSeq();

	public void closeGame(Long poiG_num, Long winningOption);

	List<PointGameVO> getCreatedGames(Long mem_num);

    List<PointGameVO> getGameOptions(Long poiG_num);

    public List<PointGameVO> selectPointBettingList(Long poiO_num);
    public Integer selectPointTotal(Long mem_num);
}
