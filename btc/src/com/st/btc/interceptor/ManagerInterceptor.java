package com.st.btc.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.st.btc.pojo.Manager;

public class ManagerInterceptor implements HandlerInterceptor {

	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		// 过滤管理员登录
		// 判断管理员是否已经登录
		
		HttpSession session = request.getSession();
		Manager manager = (Manager) session.getAttribute("mgr");
		
		//用户已登录
		if (manager!=null) {
			//放行
			return true;
		}else {
			//管理员未登录
			//跳转登录页面  用重定向
			response.sendRedirect(request.getContextPath()+"/maglogin.jsp");
		}
		return false;
	}

	
}
