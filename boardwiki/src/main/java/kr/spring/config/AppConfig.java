package kr.spring.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import kr.spring.interceptor.AutoLoginCheckInterceptor;
import kr.spring.interceptor.LoginCheckInterceptor;
import kr.spring.util.NaverLoginUtil;
import kr.spring.websocket.SocketHandler;

//자바코드 기반 설정 클래스
@Configuration
public class AppConfig implements WebMvcConfigurer,WebSocketConfigurer{
	private AutoLoginCheckInterceptor autoLoginCheck;
	private LoginCheckInterceptor loginCheck;

	@Bean
	public AutoLoginCheckInterceptor interceptor() {
		autoLoginCheck = new AutoLoginCheckInterceptor();
		return autoLoginCheck;
	}

	@Bean
	public LoginCheckInterceptor interceptor2() {
		loginCheck = new LoginCheckInterceptor();
		return loginCheck;
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		//AutoLoginCheckInterceptor 설정
		registry.addInterceptor(autoLoginCheck)
		.addPathPatterns("/**")
		.excludePathPatterns("/images/**")
		.excludePathPatterns("/image_upload/**")
		.excludePathPatterns("/upload/**")
		.excludePathPatterns("/css/**")
		.excludePathPatterns("/js/**")
		.excludePathPatterns("/member/login")
		.excludePathPatterns("/member/logout");
		//LoginCheckInterceptor 설정
		registry.addInterceptor(loginCheck)
		.addPathPatterns("/member/myPage")
		.addPathPatterns("/member/update")
		.addPathPatterns("/member/chagePassword")
		.addPathPatterns("/member/delete")
		.addPathPatterns("/board/write")
		.addPathPatterns("/board/update")
		.addPathPatterns("/board/delete")
		.addPathPatterns("/rent/rent")
		.addPathPatterns("/rent/list")
		.addPathPatterns("/rent/return")
		.addPathPatterns("/rent/rentListAdmin")
		;
	}

	@Bean
	public TilesConfigurer tilesConfigurer() {
		final TilesConfigurer configurer = 
				new TilesConfigurer();
		//XML 설정 파일 경로 지정
		configurer.setDefinitions(new String[] {
				"/WEB-INF/tiles-def/main.xml",
				"/WEB-INF/tiles-def/hjw.xml",
				"/WEB-INF/tiles-def/ksh.xml",
				"/WEB-INF/tiles-def/kts.xml",
				"/WEB-INF/tiles-def/ljy.xml",
				"/WEB-INF/tiles-def/psk.xml",
				"/WEB-INF/tiles-def/ysb.xml",
				"/WEB-INF/tiles-def/ysw.xml"
		});
		configurer.setCheckRefresh(true);
		return configurer;
	}
	@Bean
	public TilesViewResolver tilesViewResolver() {
		final TilesViewResolver tilesViewResolver = 
				new TilesViewResolver();
		tilesViewResolver.setViewClass(TilesView.class);
		return tilesViewResolver;
	}
	@Configuration
	public class CommonConfig {
		@Bean
		public PasswordEncoder passwordEncoder() {
			return PasswordEncoderFactories.createDelegatingPasswordEncoder();
		}
	}
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(new SocketHandler(), "message-ws").setAllowedOrigins("*");
	}
}







