package kr.spring.stream.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.stream.vo.StreamKeyVO;

import org.apache.ibatis.annotations.Insert;

@Mapper
public interface StreamKeyMapper {
    @Select("SELECT * FROM streaming WHERE mem_num = #{mem_num}")
    StreamKeyVO findByUsername(Long mem_num);

    @Select("SELECT * FROM streaming WHERE str_key = #{str_key}")
    StreamKeyVO findByStreamKey(String str_key);

    @Insert("INSERT INTO streaming (str_num,mem_num, str_key) VALUES (streaming_seq.nextval,#{mem_num}, #{str_key})")
    void save(StreamKeyVO str_Key);
}