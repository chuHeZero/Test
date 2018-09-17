package com.st.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.st.domain.Resbody;
import com.st.domain.Staff;
import com.st.domain.Util;
import com.st.service.IAccessService;
import com.st.service.IStaffService;

@RestController
@RequestMapping("/Staff")
public class StaffController {

	@Autowired
	private IStaffService iStaffService;
	
	@Autowired
	private IAccessService iAccessService;
	
	@RequestMapping("/login.action")
	public ModelAndView loginstaff(Staff staff,HttpSession session) {
		
		ModelAndView mv = new ModelAndView();
		
		Staff staff2 = iStaffService.loginstaff(staff);
	
		if (staff2!=null) {
			session.setAttribute("staff",staff2);
			
			//用户登录成功后
			//将对应角色权限取出
			
			Map<String, String> accesses = iAccessService.selectByRid(staff2.getRoleid());
			
			session.setAttribute("access", accesses);
			
			mv.setViewName("redirect:../view/index.action");
			
		}else {
			mv.addObject("error", "请输入正确的用户名与密码!");
			mv.setViewName("login");
		}
		
		return  mv; 
	}
	
	
	
	@RequestMapping("/selectStaff.action")
	public Resbody selectStaff(Staff staff,Util util,HttpSession session){
		
		/*Staff staff2 = (Staff) session.getAttribute("staff");
		
		staff.getRid(staff2.getRoleid());
		staff.getFid();*/
		
		Integer start = (util.getPage()-1)*util.getLimit();
		util.setStart(start);
		List<Staff> list = iStaffService.selectStaff(staff,util);
		Integer count = iStaffService.getCount();
		Resbody resbody = new Resbody();
		resbody.setCode(0);
		resbody.setCount(count);
		resbody.setData(list);
		resbody.setMsg("");
		
		return resbody;
	}
	
	@RequestMapping("/updateStaff.action")
	public Resbody updateStaff(Staff staff,String birthday) {
		
		  SimpleDateFormat aDate=new SimpleDateFormat("yyyy-mm-dd");
		
		try {
			Date date = aDate.parse(birthday);
			staff.setSbirthday(date);
			System.out.println(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Integer res = iStaffService.updateStaff(staff);
		Resbody resbody = new Resbody();
		resbody.setCode(res);
		
		return resbody;
	}

	@RequestMapping("/MyInfoupdate.action")
	public Resbody updateMyInfo(Staff staff,String birthday) {
		  SimpleDateFormat aDate=new SimpleDateFormat("yyyy-mm-dd");
			
			try {
				Date date = aDate.parse(birthday);
				staff.setSbirthday(date);
				System.out.println(date);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			Integer res = iStaffService.updateMyInfo(staff);
			Resbody resbody = new Resbody();
			resbody.setCode(res);
			
			return resbody;
	}
	
	@RequestMapping("/addStaff.action")
	public int addStaff(Staff sta,String birthday, HttpSession session) {
		  
		SimpleDateFormat aDate=new SimpleDateFormat("yyyy-mm-dd");
			try {
				Date date = aDate.parse(birthday);
				sta.setSbirthday(date);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			Integer res = iStaffService.insertStaff(sta);
			return res;
	}
	
	@RequestMapping("deleteStaff.action")
	public Resbody deleteStaff(Integer sid) {
		Integer res = iStaffService.deleteStaff(sid);
		Resbody resbody = new Resbody();
		if (res>0) {
			resbody.setMsg("删除成功");
		}else {
			resbody.setMsg("删除失败");
		}
		return resbody;
	}
	
	@RequestMapping("/getStaffCount.action")
	public List<Map<String, Object>> getStaffCount(){
		
		List<Map<String, Object>> list = iStaffService.getStaffCount();
		
		return list;
	}
	
}
