package kr.spring.donation.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.donation.vo.DonationVO;

@Mapper
public interface DonationMapper {
	@Insert("INSERT INTO donation (don_num,don_point,don_content,str_num,mem_num) VALUES(donation_seq.nextval,#{don_point},#{don_content},#{str_num},#{mem_num})")
	void insertDonation(DonationVO donation);
	@Select("SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM donation WHERE str_num = #{str_num})a) WHERE rnum >= #{start} AND rnum <= #{end}")
    List<DonationVO> getDonationsByStream(Map<String,Object> map);
	@Select("SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM donation WHERE mem_num = #{mem_num} AND str_num = #{str_num})a) WHERE rnum >= #{start} AND rnum <= #{end}")
    List<DonationVO> getDonationsByMember(Map<String,Object> map);
	@Select("SELECT COUNT(*) FROM donation WHERE str_num = #{str_num}")
	Integer SelectDonationscount(Map<String,Object> map);
	@Select("SELECT COUNT(*) FROM donation WHERE mem_num = #{mem_num} AND str_num = #{str_num}")
	Integer SelectDonationcount(Map<String,Object> map);

	@Select("SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM donation WHERE mem_num = #{mem_num})a) WHERE rnum >= #{start} AND rnum <= #{end}")
    List<DonationVO> getDonations(Map<String,Object> map);
	@Select("SELECT COUNT(*) FROM donation WHERE mem_num = #{mem_num}")
	Integer Selectcount(Map<String,Object> map);
}
