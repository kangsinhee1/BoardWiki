package kr.spring.member.service;

import kr.spring.member.vo.MemberVO;

public interface MemberService {
	public void insertMember(MemberVO memberVO);
	public MemberVO selectCheckMember(String mem_email);
	public MemberVO selectMember(Long mem_num);
}
