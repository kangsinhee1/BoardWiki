package kr.spring.attendance.service;

import java.util.Random;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class DiceService {
	public int rollDice() {
        RestTemplate restTemplate = new RestTemplate();
        String apiUrl = "https://api.random.org/json-rpc/2/invoke";  // Update with actual API endpoint
        // Implement the API call logic here, for simplicity, let's use random number for now
        return new Random().nextInt(6) + 1;
    }
}
