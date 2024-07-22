package kr.spring.donation.service;

import java.util.List;
import java.util.Map;

import kr.spring.donation.vo.DonationVO;

public interface DonationService {
	void addDonation(DonationVO donation);
	List<DonationVO> getDonationsByStream(Map<String,Object> map);
	List<DonationVO> getDonationsByMember(Map<String,Object> map);
	Integer SelectDonationscount(Map<String,Object> map);
	Integer SelectDonationcount(Map<String,Object> map);
}
