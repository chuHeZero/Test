package com.st.interceptor;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import com.st.domain.Staff;

public class SocketInterceptor implements HandshakeInterceptor {

	@Override
	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Map<String, Object> attrs) throws Exception {
		// TODO Auto-generated method stub
		//获取用户登录信息
		/**
		 * instanceof 用来判断对象是否是类的对象 
		 */
		if (request instanceof ServletServerHttpRequest) {
			ServletServerHttpRequest servletrequest = (ServletServerHttpRequest) request;
			
			/*
			 * getSession(); 获取session对象 如果没有session 那么就创建一个 ，
			 * getSession(boolean);传递true时，操作如上
			 *                     传递false时，如果有session就获取 如果没有就返回null
			 * */
			
			HttpSession session = servletrequest.getServletRequest().getSession(false);
			
			if (session != null) {
				Staff staffss = (Staff) session.getAttribute("staff");
				//添加到attr中的数据会被传递到WebSocketsession对象中
				attrs.put("staff", staffss);
			}
			
		}
		
		
		
		return true;
	}

	@Override
	public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Exception exception) {
		// TODO Auto-generated method stub
		
	}

	
}
