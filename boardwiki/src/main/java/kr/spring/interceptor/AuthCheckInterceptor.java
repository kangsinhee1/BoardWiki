package kr.spring.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import kr.spring.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AuthCheckInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response, Object hander)throws Exception{


		log.debug("<<AUTHCHECKINTERCEPTOR 진입>>");
		HttpSession session = request.getSession();
		MemberVO member= (MemberVO)session.getAttribute("user");
		if(member==null || member.getMem_auth() != 9) {

			//관리자가 아닌 상태
			response.sendRedirect(request.getContextPath()+"/member/login");
			System.out.println(request.getContextPath());
			return false;
		}

		return true;

	}

}
