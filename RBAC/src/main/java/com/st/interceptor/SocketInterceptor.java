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
		//��ȡ�û���¼��Ϣ
		/**
		 * instanceof �����ж϶����Ƿ�����Ķ��� 
		 */
		if (request instanceof ServletServerHttpRequest) {
			ServletServerHttpRequest servletrequest = (ServletServerHttpRequest) request;
			
			/*
			 * getSession(); ��ȡsession���� ���û��session ��ô�ʹ���һ�� ��
			 * getSession(boolean);����trueʱ����������
			 *                     ����falseʱ�������session�ͻ�ȡ ���û�оͷ���null
			 * */
			
			HttpSession session = servletrequest.getServletRequest().getSession(false);
			
			if (session != null) {
				Staff staffss = (Staff) session.getAttribute("staff");
				//��ӵ�attr�е����ݻᱻ���ݵ�WebSocketsession������
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
