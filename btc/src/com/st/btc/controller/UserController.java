package com.st.btc.controller;

import java.io.ByteArrayOutputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.st.btc.pojo.Product;
import com.st.btc.pojo.User;
import com.st.btc.service.IUserService;
import com.st.btc.util.Page;
import com.st.btc.util.VerifyCode;

//�û���Controller
@Controller
@RequestMapping("/UserController")
public class UserController {
	User wuser = new User();
	@Autowired
	IUserService iUserService;
	
	@RequestMapping("/login.action")
	public ModelAndView login(User user, String code, HttpSession session) {
		
		
		ModelAndView mv = new ModelAndView();
		
		String scode = (String) session.getAttribute("code");
		
		//ȫ��ת����Сд�ٶԱ�
		scode = scode.toLowerCase();
		code = code.toLowerCase();
		
		//��֤������
		if (!scode.equals(code)) {
			mv.addObject("error", "��֤������!");
			mv.setViewName("login");
		}else {
			//��֤����ȷ
			wuser.setPassword(user.getPassword());
			user = iUserService.login(user);
			if(user!=null) {
				//��¼�ɹ��ض�����ҳ
				session.setAttribute("user", user);
				mv.setViewName("redirect:../index.jsp");
			}else {
				//��½ʧ�ܷ��ش�����Ϣ
				mv.addObject("error", "�˺Ż��������!");
				mv.setViewName("login");
			}
		}
		return mv;
		
	}
	
	@RequestMapping("/logout.action")
	public String logout(HttpSession session) {
		
		session.removeAttribute("user");
		return"redirect:../index.jsp";
	}
	
	@RequestMapping("/register")
	public ModelAndView insert(User user,String password1) {
		
		ModelAndView mv = new ModelAndView();
			
		int res =	iUserService.register(user,password1);
		
		if (res>0) {
			mv.setViewName("redirect:../login.jsp");
		}else if(res==-200){
			mv.addObject("error", "�������벻һ�£�ע��ʧ��!");
			mv.setViewName("register");
		}else if (res==-100) {
			mv.addObject("error", "�˺��Ѵ��ڣ�ע��ʧ��!");
			mv.setViewName("register");
		}else {
			mv.addObject("error", "ע��ʧ��,δ֪����!");
			mv.setViewName("register");
		}
			return mv;
	}
	
	@RequestMapping("/getCode.action")
	public void getCode(HttpServletResponse response, HttpSession session) {
		
		ByteArrayOutputStream output = new ByteArrayOutputStream();
		
		String code = VerifyCode.getCodeImg(output);
		
		session.setAttribute("code", code);
		
		try {
			// ��response�ϻ�ȡһ�������
			ServletOutputStream out = response.getOutputStream();
			// ��ͼƬд�뵽��������
			output.writeTo(out);
			
		}catch (Exception e) {
			// TODO: handle exception
		}
		
	}
	
	@RequestMapping("/selectinfo.action")
	public ModelAndView userupdate(User user,HttpSession session) {
		User user2= (User) session.getAttribute("user");
		user.setUid(user2.getUid());
		int res = iUserService.selectinfo(user);
		ModelAndView mv = new ModelAndView();
		if(res==-100){
			mv.addObject("error", "���벻һ�£�");
			mv.setViewName("WEB-INF/User/selectinfo");
		}else if(res==-200){
			mv.addObject("error", "����ϢΪ�գ�");
			mv.setViewName("WEB-INF/User/selectinfo");
		}else {
			session.removeAttribute("user");
			mv.setViewName("redirect:../login.jsp");
		}
		return mv;
	}
	

	@RequestMapping("/newpwd.action")
	public ModelAndView newpwd(User user,String password1,HttpSession session,HttpServletRequest request) {
		User user2= (User) session.getAttribute("user");
		user.setUid(user2.getUid());
		int res = iUserService.newpwd(user,password1);
		ModelAndView mv = new ModelAndView();
		if(res==-100){
			mv.addObject("error", "�������벻һ�£�");
			mv.setViewName("WEB-INF/User/updatepwd");
		}else if(res==-200){
			mv.addObject("error", "���벻��Ϊ�գ�");
			mv.setViewName("WEB-INF/User/updatepwd");
		}else {
			session.removeAttribute("user");
			mv.setViewName("redirect:../login.jsp");
		}
		return mv;
	}
	
	@RequestMapping("/newmoney.action")
	public ModelAndView newmoney(User user,String password,Double umoney, Integer ustatus, HttpSession session,HttpServletRequest request) {
		User user2= (User) session.getAttribute("user");
		user.setPassword(user2.getPassword());
		user.setUname(user2.getUname());
		user.setUmoney(umoney);
		user.setUstatus(ustatus);
		user.setUid(user2.getUid());
		System.out.println(umoney);
		ModelAndView mv = new ModelAndView();
	
		int res = iUserService.newmoney(user,password);
		
		if(res==-100){
			mv.addObject("error", "�������");
			mv.setViewName("WEB-INF/User/updatemoney");
		}else if(res==-200){
			mv.addObject("error", "��ֵ����Ϊ�գ�");
			mv.setViewName("WEB-INF/User/updatemoney");
		}else if(res==-300){
			mv.addObject("error", "��ֵ�����Ҫ����0��");
			mv.setViewName("WEB-INF/User/updatemoney");
		}else {
			user = iUserService.login(user);
			session.setAttribute("user",user);
			mv.setViewName("redirect:../index.jsp");
		}
		return mv;
	}

	@RequestMapping("/center.action")
	public String center() {
		return"WEB-INF/User/selectinfo";
	}
	
	@RequestMapping("/updatepwd.action")
	public String updatepwd() {
		return"WEB-INF/User/updatepwd";
	}
	
	@RequestMapping("/updatemoney.action")
	public String updatemoney() {
		return"WEB-INF/User/updatemoney";
	}

	@RequestMapping("/ucart.action")
	public String ucart() {
		return"WEB-INF/User/cart";
	}
}
