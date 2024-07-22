package kr.spring.tnrboard.service;

import java.util.List;
import java.util.Map;

import kr.spring.tnrboard.vo.TnrboardFavVO;
import kr.spring.tnrboard.vo.TnrboardReplyVO;
import kr.spring.tnrboard.vo.TnrboardVO;

public interface TnrboardService {
	//부모글
	public List<TnrboardVO> selectTnrList(Map<String,Object> map);
	public List<TnrboardVO> selectTnrMyList(Map<String,Object> map);
	public Integer selectTnrRowCount(Map<String,Object> map);
	public Integer selectTnrRowmyCount(Map<String,Object> map);
	public void insertTnrBoard(TnrboardVO tnrboard);
	public TnrboardVO selectTnrBoard(Long tnr_num);
	public void updateTnrHit(Long tnr_num);
	public void updateTnrBoard(TnrboardVO tnrboard);
	public void deleteTnrBoard(Long tnr_num);
	public void deleteTnrboardFile(Long tnr_num);

	//부모글 좋아요
	public TnrboardFavVO selectTnrFav(TnrboardFavVO fav);
	public Integer selectTnrFavCount(Long tnr_num);
	public void insertTnrFav(TnrboardFavVO fav);
	public void deleteTnrFav(TnrboardFavVO fav);
	//댓글
	public List<TnrboardReplyVO> selectTnrListReply(Map<String,Object> map);
	public Integer selectTnrRowCountReply(Map<String,Object> map);
	public TnrboardReplyVO selectTnrReply(Long tnrR_num);
	public void insertTnrReply(TnrboardReplyVO tnrboardReply);
	public void updateTnrReply(TnrboardReplyVO tnrboardReply);
	public void deleteTnrReply(Long tnrR_num);

}
