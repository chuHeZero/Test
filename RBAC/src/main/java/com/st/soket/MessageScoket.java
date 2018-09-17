package com.st.soket;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.st.domain.ScoketMessage;
import com.st.domain.Staff;

	/*
	 *可以通过webScoket处理文本内容的处理器
	 * 
	 */
public class MessageScoket extends TextWebSocketHandler {

	private List<WebSocketSession> scokets = new ArrayList<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			// TODO Auto-generated method stub
			System.out.println("连接成功");
			
			// 向客户端发送消息 
			TextMessage msg = new TextMessage("服务器成功接收连接请求");
			session.sendMessage(msg);
			
			scokets.add(session);

		
	}
	@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
			// TODO Auto-generated method stub
			System.out.println("连接关闭");
			//断开时移除session
		scokets.remove(session);
		}
	@Override
		protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
			// TODO Auto-generated method stub
		
			//  接收客户端发送的数据
			System.out.println("收到:" + message.getPayload());

	}
	
	public void sendMsg(ScoketMessage msg) throws IOException {
		
		//消息内容，转为JSON字符串
		ObjectMapper mapper = new ObjectMapper();
		String msgJSON = mapper.writeValueAsString(msg);
		//向所有客户端发送
		TextMessage txtMsg = new TextMessage(msgJSON);
		
		
		
		//过滤掉一部分用户
		for (WebSocketSession session : scokets) {
			
			//session.getAttributes(); 获取到的是在拦截器中的attrs
			Staff staff = (Staff) session.getAttributes().get("staff");
			if (staff.getRoleid() == 3) {
				session.sendMessage(txtMsg);
			}
		}
	}
	
	public void sendInfo(ScoketMessage msg) throws IOException {
		//消息内容，转为JSON字符串
		ObjectMapper mapper = new ObjectMapper();
		String msgJSON = mapper.writeValueAsString(msg);
		//向所有客户端发送
		TextMessage txtMsg = new TextMessage(msgJSON);
		
		//过滤掉一部分用户
		for (WebSocketSession session : scokets) {
			//session.getAttributes(); 获取到的是在拦截器中的attrs
			Staff staff = (Staff) session.getAttributes().get("staff");
			if (staff.getRoleid() != 1) {
				session.sendMessage(txtMsg);
			}
		}
	}
	
}
