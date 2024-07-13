package kr.spring.stream.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.stream.vo.BroadcastVO;

import java.util.List;

@Mapper
public interface BroadcastMapper {
    @Select("SELECT * FROM stream_detail WHERE is_live = true")
    List<BroadcastVO> findAll();

    @Select("SELECT * FROM streaming WHERE str_num = #{str_num}")
    BroadcastVO findByUsername(Long str_num);
}
