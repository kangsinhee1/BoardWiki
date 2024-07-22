package kr.spring.stream.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.stream.vo.StreamKeyVO;

@Mapper
public interface StreamKeyMapper {

    @Select("SELECT * FROM streaming WHERE mem_num = #{mem_num}")
    StreamKeyVO findByUsername(Long mem_num);

    @Select("SELECT * FROM streaming WHERE str_key = #{stream_key}")
    StreamKeyVO findByStreamKey(String str_key);

    @Select("SELECT * FROM streaming WHERE str_num = #{str_num}")
    StreamKeyVO selectstream(Long str_key);

    @Insert("INSERT INTO streaming (str_num,mem_num, str_key) VALUES (streaming_seq.nextval,#{mem_num}, #{str_key})")
    void save(StreamKeyVO str_Key);


}