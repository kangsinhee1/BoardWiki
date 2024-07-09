package kr.spring.point.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.point.vo.PointVO;

@Mapper
public interface PointMapper {
	//포인트 사용 및 리스트
	/**총 포인트 감소/증가 sql*/
	public void updatepointtotal(PointVO pointVO);
	/**포인트 획득/감소 sql*/
	@Insert("INSERT INTO point (poi_num,poi_status,poi_use,poi_date,mem_num,poi_increase) VALUES (point_seq.nextval(),#{poi_status},#{poi_use},SYSDATE,#{mem_num},#{poi_increase})")
	public void insertpoint(PointVO pointVO);
	/**포인트 사용 상세 내역 sql*/
	@Select("SELECT * FROM point JOIN point_total USING(mem_num) WHERE mem_num=#{mem_num}")
	public void selectPoint(PointVO pointVO);
	/**포인트 사용 목록*/
	public List<PointVO> selectPointList(Map<String,Object> map);
	/**포인트 카운트*/
	public Integer selectRowCount(Map<String,Object> map);
	
	//포인트 게임
	
}
