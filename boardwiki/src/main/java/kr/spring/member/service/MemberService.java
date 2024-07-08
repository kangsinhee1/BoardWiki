package kr.spring.member.service;

import kr.spring.member.vo.MemberVO;

public interface MemberService {
	public MemberVO selectMember(Long mem_num);
}
