package kr.spring.member.dao;

import java.util.List;
import java.util.Map;

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
	public List<MemberVO> selectAllmember(Map<String,Object> map);
	@Select("SELECT COUNT(*) FROM member JOIN member_detail USING(mem_num) ORDER BY mem_rdate desc")
	public Integer countAllmember(Map<String,Object> map);
	public MemberVO selectCheckMemberNickName(String mem_nickName);
}
