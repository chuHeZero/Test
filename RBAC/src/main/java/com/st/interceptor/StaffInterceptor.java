package com.st.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.st.domain.Staff;


public class StaffInterceptor implements HandlerInterceptor {

	
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
		Staff staff =  (Staff) session.getAttribute("staff");
		
		//�û��ѵ�¼
		if (staff!=null) {
			//����
			return true;
		}else {
			//Ա��δ��¼
			//��ת��¼ҳ��  ���ض���
			response.sendRedirect("../login.jsp");
		}
		
		return false;
	}

	
}
