package kr.spring.stream.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.stream.vo.BroadcastVO;

import java.util.List;

@Mapper
public interface BroadcastMapper {
    @Select("SELECT * FROM stream_detail WHERE islive = 1")
    List<BroadcastVO> findAll();

    @Select("SELECT * FROM stream_detail WHERE str_num = #{str_num} AND isLive = 1")
    BroadcastVO findByUsername(Long str_num);
    
    @Insert("INSERT INTO stream_detail (strd_num,str_num,islive) VALUES (stream_detail_seq.nextval,#{str_num},#{isLive})")
    void startStream(BroadcastVO broadcast);
    
    @Update("UPDATE stream_detail SET strD_end=SYSDATE, isLive=#{isLive} WHERE strD_num = #{strD_num}")
    void updateBroadcast(BroadcastVO broadcast);
    
    @Select("SELECT * FROM stream_detail WHERE str_num = #{str_num} AND isLive = 1")
    BroadcastVO findByMemNum(Long str_num);
}
