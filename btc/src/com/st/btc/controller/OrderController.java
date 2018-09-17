package com.st.btc.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.st.btc.pojo.Details;
import com.st.btc.pojo.Order;
import com.st.btc.pojo.User;
import com.st.btc.service.IOrderService;

@Controller
public class OrderController {

	@Autowired
	IOrderService iOrderService;
	
	@RequestMapping("/UserController/ddxq.action")
	public String ddxq() {
		return "WEB-INF/User/order";
	}
	

	
	@RequestMapping("/UserController/suborder.action")
	public ModelAndView suborder(Order order,HttpSession session){
		
		//����
		//ȡ��ǰ��¼�û�ID
		User user =  (User) session.getAttribute("user");
		
		order.setUid(user.getUid());
		order.setOaddr(user.getUaddr());
		order.setOname(user.getUrealname());
		order.setOphone(user.getUphone());
		
		ModelAndView mv = new ModelAndView();
		
		try {
			int res = iOrderService.addorder(order);
		
			mv.setViewName("redirect:ddxq.action");
		}catch (RuntimeException e) {
			//��ͻ��˷��ش�����Ϣ
			mv.addObject("error", e.getMessage());
			mv.setViewName("error");
		}
		
		
		
		return mv;
	}
	@RequestMapping("/UserController/worder.action")
	@ResponseBody
	public List<Order> worder(HttpSession session) {
		
		User user = (User) session.getAttribute("user");
		
		List<Order> res = iOrderService.selectByUId(user.getUid());
		
		return res;
	}
	
	@RequestMapping("/UserController/orinfo.action")
	@ResponseBody
	public List<Details> getorinfo(String onum){
		
		List<Details> res = iOrderService.getorinfo(onum);
		return res;
	}
	
	@RequestMapping("/ManagerController/aorder.action")
	@ResponseBody
	public List<Order> aorder(String oname) {
		
		
		List<Order> res = iOrderService.selectorder(oname);
		
		return res;
	}
	
	@RequestMapping("/ManagerController/mgrorinfo.action")
	@ResponseBody
	public List<Details> getmgrorinfo(String onum){
		
		List<Details> res = iOrderService.getmgrorinfo(onum);
		return res;
	}
}
