package com.st.btc.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.st.btc.pojo.User;

public class UserInterceptor implements HandlerInterceptor {

	
	//请求执行完时执行
	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	//返回试图时调用该方法
	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	
	@Override
	/**
	 * 需要被拦截的请求Contoller执行之前, 执行该方法
	 * 
	 * 当该方法返回false时, 请求被拦截, 
	 * 当该方法返回true时, 请求放行.
	 */
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		// 过滤用户登录
		// 判断用户是否已经登录
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		//用户已登录
		if (user!=null) {
			//放行
			return true;
		}else {
			//用户未登录
			//跳转登录页面  用重定向
			response.sendRedirect(request.getContextPath()+"/login.jsp");
		}
		
		return false;
	}

	
}
