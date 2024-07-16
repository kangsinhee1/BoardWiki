package kr.spring.member.service;

import java.util.List;
import java.util.Map;

import kr.spring.member.vo.MemberVO;

public interface MemberService {
	public void insertMember(MemberVO memberVO);
	public MemberVO selectCheckMember(String mem_email);
	public MemberVO selectMember(Long mem_num);
	public List<MemberVO> selectAllmember(Map<String,Object> map);
	public Integer countAllmember(Map<String,Object> map);
	public MemberVO selectCheckMemberNickName(String mem_nickName);
}
