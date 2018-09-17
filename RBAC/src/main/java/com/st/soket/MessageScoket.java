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
	 *����ͨ��webScoket�����ı����ݵĴ�����
	 * 
	 */
public class MessageScoket extends TextWebSocketHandler {

	private List<WebSocketSession> scokets = new ArrayList<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			// TODO Auto-generated method stub
			System.out.println("���ӳɹ�");
			
			// ��ͻ��˷�����Ϣ 
			TextMessage msg = new TextMessage("�������ɹ�������������");
			session.sendMessage(msg);
			
			scokets.add(session);

		
	}
	@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
			// TODO Auto-generated method stub
			System.out.println("���ӹر�");
			//�Ͽ�ʱ�Ƴ�session
		scokets.remove(session);
		}
	@Override
		protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
			// TODO Auto-generated method stub
		
			//  ���տͻ��˷��͵�����
			System.out.println("�յ�:" + message.getPayload());

	}
	
	public void sendMsg(ScoketMessage msg) throws IOException {
		
		//��Ϣ���ݣ�תΪJSON�ַ���
		ObjectMapper mapper = new ObjectMapper();
		String msgJSON = mapper.writeValueAsString(msg);
		//�����пͻ��˷���
		TextMessage txtMsg = new TextMessage(msgJSON);
		
		
		
		//���˵�һ�����û�
		for (WebSocketSession session : scokets) {
			
			//session.getAttributes(); ��ȡ���������������е�attrs
			Staff staff = (Staff) session.getAttributes().get("staff");
			if (staff.getRoleid() == 3) {
				session.sendMessage(txtMsg);
			}
		}
	}
	
	public void sendInfo(ScoketMessage msg) throws IOException {
		//��Ϣ���ݣ�תΪJSON�ַ���
		ObjectMapper mapper = new ObjectMapper();
		String msgJSON = mapper.writeValueAsString(msg);
		//�����пͻ��˷���
		TextMessage txtMsg = new TextMessage(msgJSON);
		
		//���˵�һ�����û�
		for (WebSocketSession session : scokets) {
			//session.getAttributes(); ��ȡ���������������е�attrs
			Staff staff = (Staff) session.getAttributes().get("staff");
			if (staff.getRoleid() != 1) {
				session.sendMessage(txtMsg);
			}
		}
	}
	
}
