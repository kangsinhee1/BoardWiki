package kr.spring.config;

import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import kr.spring.interceptor.AuthCheckInterceptor;
import kr.spring.interceptor.AutoLoginCheckInterceptor;
import kr.spring.interceptor.LoginCheckInterceptor;
import kr.spring.util.NaverLoginUtil;
import kr.spring.websocket.SocketHandler;

//자바코드 기반 설정 클래스
@Configuration
@EnableWebSocket
public class AppConfig implements WebMvcConfigurer,WebSocketConfigurer{
	private AutoLoginCheckInterceptor autoLoginCheck;
	private LoginCheckInterceptor loginCheck;
	private AuthCheckInterceptor authCheck;

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
	
	@Bean
	public AuthCheckInterceptor interceptor4() {
		authCheck = new AuthCheckInterceptor();
		return authCheck;
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
		.addPathPatterns("/team/**")
		.addPathPatterns("/chat/**")
		.excludePathPatterns("/team/teamFav")
		.excludePathPatterns("/team/teamDetail")
		.excludePathPatterns("/team/teamList");
		
		//authCheckInterceptor설정
		registry.addInterceptor(authCheck)
		.addPathPatterns("/team/teamListAdmin")
		.addPathPatterns("/team/teamDetailAdmin");
		
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
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(new SocketHandler(), "message-ws").setAllowedOrigins("*");
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
	
	@Bean
	public JavaMailSenderImpl javaMailSenderImpl() {
		Properties prop = new Properties();
		prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		prop.put("mail.smtp.starttls.enable", "true");
		prop.put("mail.transport.protocol", "smtp");
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.debug", "true");

		JavaMailSenderImpl javaMail = new JavaMailSenderImpl();
		javaMail.setHost("smtp.gmail.com");
		javaMail.setPort(587);
		javaMail.setDefaultEncoding("utf-8");
		javaMail.setUsername("tlsgmldi0809@gmail.com");
		javaMail.setPassword("hkcr nmzh lsem gsnt");
		javaMail.setJavaMailProperties(prop);
		return javaMail;
	}
	
	
	
	
}







