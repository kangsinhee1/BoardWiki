package kr.spring.stream.service;

import java.util.List;

import kr.spring.stream.vo.BroadcastVO;

public interface BroadcastService {
    List<BroadcastVO> getAllBroadcasts();
    BroadcastVO getBroadcastByUsername(Long str_num);
}