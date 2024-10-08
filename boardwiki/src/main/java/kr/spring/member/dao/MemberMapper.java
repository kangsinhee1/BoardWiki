package kr.spring.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

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
	@Update("UPDATE member_detail SET mem_passwd=#{mem_passwd} WHERE mem_num=#{mem_num}")
	public void updatePassword(MemberVO member);
	public void updateMember_detail(MemberVO member);

	//자동 로그인
	@Update("UPDATE member_detail SET au_id=#{au_id} WHERE mem_num=#{mem_num}")
	public void updateAu_id(String au_id,Long mem_num);
	@Select("SELECT m.mem_num, m.mem_email, m.mem_auth, d.au_id, d.mem_passwd, d.mem_nickName FROM member m JOIN member_detail d ON m.mem_num=d.mem_num WHERE d.au_id=#{au_id}")
	public MemberVO selectAu_id(String au_id);
	@Update("UPDATE member_detail SET au_id='' WHERE mem_num=#{mem_num}")
	public void deleteAu_id(Long mem_num);

	//아이디 찾기
	@Select("SELECT * FROM member JOIN member_detail USING(mem_num) WHERE mem_name = #{mem_name} AND mem_phone = #{mem_phone}")
	public MemberVO findEmail(String mem_name, String mem_phone);

	//회원 탈퇴
	@Update("UPDATE member SET mem_auth=0 WHERE mem_num= #{mem_num}")
	public void deleteMember(long mem_num);
	@Delete("DELETE FROM member_detail WHERE mem_num=#{mem_num}")
	public void deleteMember_detail(long mem_num);

	//관리자 멤버 등급 변경
	@Update("UPDATE member SET mem_auth=#{mem_auth} WHERE mem_num = #{mem_num}")
	public  boolean updateMemberAuth(long mem_num, Integer mem_auth);
}
