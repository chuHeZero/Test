package com.st.btc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.st.btc.pojo.User;
import com.st.btc.service.IUserService;
import com.st.btc.util.Page;

//����Ա�����û���Controller
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
	@ResponseBody	//�������ķ��ض���ͨ��Jackson��װ��JSON��ʽ���ַ��������ظ��ͻ���
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
			mv.addObject("error", "�������벻һ�£�");
			mv.setViewName("WEB-INF/Manager/updateuserinfo");
		}else if (res==-200) {
			mv.addObject("error", "���벻��Ϊ�գ�");
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
			mv.setViewName("redirect:selectAll.action?error=�¼ܻ���ʧ��");
		}
		
		return mv;
	}
}
