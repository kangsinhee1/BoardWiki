package kr.spring.donation.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.donation.dao.DonationMapper;
import kr.spring.donation.vo.DonationVO;

@Service
@Transactional
public class DonationServiceImpl implements DonationService{

	@Autowired
    private DonationMapper donationMapper;


	@Override
	public void addDonation(DonationVO donation) {
		donationMapper.insertDonation(donation);
	}

	@Override
	public List<DonationVO> getDonationsByStream(Map<String, Object> map) {
		return donationMapper.getDonationsByStream(map);
	}

	@Override
	public List<DonationVO> getDonationsByMember(Map<String, Object> map) {
		return donationMapper.getDonationsByMember(map);
	}

	@Override
	public Integer SelectDonationscount(Map<String, Object> map) {
		return donationMapper.SelectDonationscount(map);
	}

	@Override
	public Integer SelectDonationcount(Map<String, Object> map) {
		return donationMapper.SelectDonationcount(map);
	}

}
