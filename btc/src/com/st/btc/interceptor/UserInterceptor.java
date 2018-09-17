package com.st.btc.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.st.btc.pojo.User;

public class UserInterceptor implements HandlerInterceptor {

	
	//����ִ����ʱִ��
	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	//������ͼʱ���ø÷���
	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	
	@Override
	/**
	 * ��Ҫ�����ص�����Contollerִ��֮ǰ, ִ�и÷���
	 * 
	 * ���÷�������falseʱ, ��������, 
	 * ���÷�������trueʱ, �������.
	 */
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		// �����û���¼
		// �ж��û��Ƿ��Ѿ���¼
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		//�û��ѵ�¼
		if (user!=null) {
			//����
			return true;
		}else {
			//�û�δ��¼
			//��ת��¼ҳ��  ���ض���
			response.sendRedirect(request.getContextPath()+"/login.jsp");
		}
		
		return false;
	}

	
}
