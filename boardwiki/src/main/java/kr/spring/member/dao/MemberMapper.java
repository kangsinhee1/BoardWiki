package kr.spring.member.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.member.vo.MemberVO;

@Mapper
public interface MemberMapper {
	@Select("SELECT member_seq.nextval FROM dual")
	public Long selectMem_num();
	@Select("SELECT * FROM member JOIN member_detail USING(mem_num) WHERE mem_num=#{mem_num}")
	public MemberVO selectMember(Long mem_num);
	@Insert("INSERT INTO member (mem_num, mem_email) VALUES (#{mem_num},#{mem_email})")
	public void insertMember(MemberVO member);
	public void insertMember_detail(MemberVO member);
	public MemberVO selectCheckMember(String mem_email);
}
