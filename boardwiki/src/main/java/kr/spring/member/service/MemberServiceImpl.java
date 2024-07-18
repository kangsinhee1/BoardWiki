package kr.spring.member.service;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.member.dao.MemberMapper;
import kr.spring.member.vo.MemberVO;
import kr.spring.point.dao.PointMapper;
import kr.spring.point.vo.PointVO;
import kr.spring.stream.dao.StreamKeyMapper;
import kr.spring.stream.vo.StreamKeyVO;

@Service
@Transactional
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
    PasswordEncoder passwordEncoder;
	
	@Autowired
	StreamKeyMapper streamKeyMapper;
	
	@Autowired
	PointMapper pointMapper;
	
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
	    
	    //회원 스트림키 부여
	    String streamKey = UUID.randomUUID().toString();
        StreamKeyVO key = new StreamKeyVO();
        key.setMem_num(membervo.getMem_num());
        key.setStr_key(streamKey);
        streamKeyMapper.save(key);
        
        //회원 포인트 부여
        PointVO point = new PointVO();
        point.setPoint_total(1000);
        point.setMem_num(membervo.getMem_num());
        pointMapper.insertpointtotal(point);
	}

	@Override
	public MemberVO selectCheckMember(String mem_email) {
		return memberMapper.selectCheckMember(mem_email);
	}

	@Override
	public List<MemberVO> selectAllmember(Map<String,Object> map) {
		return memberMapper.selectAllmember(map);
	}

	@Override
	public Integer countAllmember(Map<String,Object> map) {
		return memberMapper.countAllmember(map);
	}

	@Override
	public MemberVO selectCheckMemberNickName(String mem_nickName) {
		return memberMapper.selectCheckMemberNickName(mem_nickName);
	}

	@Override
	public void updateAu_id(String au_id, Long mem_num) {
		memberMapper.updateAu_id(au_id, mem_num);
		
	}

	@Override
	public MemberVO selectAu_id(String au_id) {
		return memberMapper.selectAu_id(au_id);
	}

	@Override
	public void deleteAu_id(Long mem_num) {
		memberMapper.deleteAu_id(mem_num);
	}

	@Override
	public void updatePassword(MemberVO member) {
		
		// 패스워드 암호화
	    String encryptedPassword = passwordEncoder.encode(member.getMem_passwd());
	    member.setMem_passwd(encryptedPassword);
	    
	   
		memberMapper.updatePassword(member);
		
	}

	@Override
	public void updateMember_detail(MemberVO member) {
		memberMapper.updateMember_detail(member);
		
	}

	@Override
	public MemberVO findEmail(String mem_name, String mem_phone) {
		return memberMapper.findEmail(mem_name, mem_phone);
	}
}
