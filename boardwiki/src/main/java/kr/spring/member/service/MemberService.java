package kr.spring.member.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.member.vo.MemberVO;

public interface MemberService {
	public void insertMember(MemberVO memberVO);
	public MemberVO selectCheckMember(String mem_email);
	public MemberVO selectMember(Long mem_num);
	public List<MemberVO> selectAllmember(Map<String,Object> map);
	public Integer countAllmember(Map<String,Object> map);
	public MemberVO selectCheckMemberNickName(String mem_nickName);
	public void updatePassword(MemberVO member);
	public void updateMember_detail(MemberVO member);
	
	//자동로그인
	public void updateAu_id(String au_id,Long mem_num);
	public MemberVO selectAu_id(String au_id);
	public void deleteAu_id(Long mem_num);
}
