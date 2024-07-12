package kr.spring.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.member.dao.MemberMapper;
import kr.spring.member.vo.MemberVO;

@Service
@Transactional
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
    PasswordEncoder passwordEncoder;
	
	@Override
	public MemberVO selectMember(Long mem_num) {
		return memberMapper.selectMember(mem_num);
	}

	@Override
	public void insertMember(MemberVO membervo) {
	    // 회원 번호 조회
	    membervo.setMem_num(memberMapper.selectMem_num());
	    
	    // 패스워드 암호화
	    String encryptedPassword = passwordEncoder.encode(membervo.getMem_passwd());
	    membervo.setMem_passwd(encryptedPassword);
	    
	    // 회원 정보 저장
	    memberMapper.insertMember(membervo);
	    memberMapper.insertMember_detail(membervo);
	}

	@Override
	public MemberVO selectCheckMember(String mem_email) {
		return memberMapper.selectCheckMember(mem_email);
	}
}
