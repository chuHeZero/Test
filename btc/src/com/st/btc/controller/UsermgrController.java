package com.st.btc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.st.btc.pojo.User;
import com.st.btc.service.IUserService;
import com.st.btc.util.Page;

//管理员管理用户的Controller
@Controller
@RequestMapping("User")
public class UsermgrController {

	@Autowired
	IUserService iUserService;
	
	@RequestMapping("/selectAll.action")
	public String selscttmAll() {
		
		return "/WEB-INF/Manager/Usermgr";
	}
	
	@RequestMapping("/updateuserinfo.action")
	public String updateuserinfo() {
		
		return "/WEB-INF/Manager/updateuserinfo";
	}
	
	@RequestMapping("/selectuserAll.action")
	@ResponseBody	//将方法的返回对象，通过Jackson封装成JSON格式的字符串，返回给客户端
	public Page selsctAll(User user, Page page) {
		
		System.out.println(page.getCurpage());
		
		Page respage = iUserService.selectuserAll(user,page);

		return respage;
	}
	
	@RequestMapping("/userpwd.action")
	public ModelAndView updateuser(User user,String password1) {
		
		 int res = iUserService.updateuser(user, password1);
		ModelAndView mv = new ModelAndView();
		
		if(res==-100){
			mv.addObject("error", "两次密码不一致！");
			mv.setViewName("WEB-INF/Manager/updateuserinfo");
		}else if (res==-200) {
			mv.addObject("error", "密码不能为空！");
			mv.setViewName("WEB-INF/Manager/updateuserinfo");
		}else {
			
			mv.setViewName("redirect:selectAll.action");
		}
		
		return mv;
	}
	
	@RequestMapping("removeuser.action")
	public ModelAndView removeuser(User user,Integer ustatus) {
		
		user.setUstatus(ustatus);
		ModelAndView mv = new ModelAndView();
		
		int res = iUserService.removeuser(user);
		
		if (res>0) {
			mv.setViewName("redirect:selectAll.action");
		}else {
			mv.setViewName("redirect:selectAll.action?error=下架或开售失败");
		}
		
		return mv;
	}
}
