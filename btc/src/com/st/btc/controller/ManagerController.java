package com.st.btc.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.st.btc.pojo.Manager;
import com.st.btc.service.IManagerService;

//管理员的Controller
@Controller
@RequestMapping("/ManagerController")
public class ManagerController {

	@Autowired
	private IManagerService iManagerService;
	
	@RequestMapping("/index.action")
	public String index() {
		return "/WEB-INF/Manager/mgrindex";
	}
	
	@RequestMapping("/logout.action")
	public String logout(HttpSession session) {
		session.removeAttribute("manager");
		return"redirect:../maglogin.jsp" ;
	}
	@RequestMapping("/mgrpwd.action")
	public String mgrpwd(HttpSession session) {
		
		return"/WEB-INF/Manager/mgrpwd";
	}
	
	@RequestMapping("/ordermgr.action")
	public String ordermgr() {
		
		return"/WEB-INF/Manager/ordermgr";
	}
	
	@RequestMapping("/login.action")
	public ModelAndView login(Manager mgr, HttpSession session ) {
		
		ModelAndView mv = new ModelAndView();
		Manager mgr2 = iManagerService.login(mgr);
		session.setAttribute("mgr",mgr2);
		
		if (mgr2 != null) {
			
			mv.setViewName("redirect:index.action");
		}else {
			mv.addObject("error","用户名或密码错误!");
			mv.setViewName("maglogin");
		}
		
		return mv;
	}
	
	@RequestMapping("/newpwd.action")
	public ModelAndView newpwd(Manager mgr,String mpassword1,HttpSession session,HttpServletRequest request) {
		Manager mgr2= (Manager) session.getAttribute("mgr");
		mgr.setMid(mgr2.getMid());
		
		int res = iManagerService.newpwd(mgr,mpassword1);
		ModelAndView mv = new ModelAndView();
		if(res==-100){
			mv.addObject("error", "两次密码不一致！");
			mv.setViewName("WEB-INF/Manager/mgrpwd");
		}else if(res==-200){
			mv.addObject("error", "密码不能为空！");
			mv.setViewName("WEB-INF/Manager/mgrpwd");
		}else {
			session.removeAttribute("user");
			mv.setViewName("redirect:../maglogin.jsp");
		}
		return mv;
	}

}
