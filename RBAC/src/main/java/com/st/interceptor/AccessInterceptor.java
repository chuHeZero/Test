package com.st.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;



public class AccessInterceptor implements HandlerInterceptor {

	
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
		
		//1.取出当前请求的地址   *.action
		String url = request.getRequestURI();
		//     /RBAC/access/view/insertProduct.action
		url = url.substring(url.indexOf("access/"));
		//2.查询权限的匹配
		HttpSession session = request.getSession();
		Map<String, String> accesses = (Map<String, String>) session.getAttribute("access");
		
		
		
		//3.如果有权限放行
		//如果没有权限跳转到一个提示页面
		
		String urlname = accesses.get(url);
		
		if (urlname == null) {
			//没有权限
			response.sendRedirect("../../accesserror.jsp");
			return false;
		}else {
			//有权限
			
		}
		
		/*HttpSession session = request.getSession();
		Staff staff =  (Staff) session.getAttribute("staff");
		
		//用户已登录
		if (staff!=null) {
			//放行
			return true;
		}else {
			//员工未登录
			//跳转登录页面  用重定向
			response.sendRedirect(request.getContextPath()+"/login.jsp");
		}*/
		
		return true;
	}

	
}
