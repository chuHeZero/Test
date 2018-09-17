package com.st.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.st.domain.Customer;
import com.st.domain.Resbody;
import com.st.domain.Staff;
import com.st.domain.Util;
import com.st.domain.Visit;
import com.st.service.ICustomerService;
import com.st.service.IVisitService;

@RestController
@RequestMapping("/Customer")
public class CustomerController {

	@Autowired
	private ICustomerService iCustomerService;
	
	@Autowired
	private IVisitService iVisitService;
	
	@RequestMapping("/selectCustomer.action")
	public Resbody selectCustomer(Util util,Customer customer,HttpSession session) {
		
		Staff staff = (Staff) session.getAttribute("staff");
		
		customer.setRid(staff.getRoleid());
		customer.setFid(staff.getSid());
		
		Integer start = (util.getPage()-1)*util.getLimit();
		util.setStart(start);
		List<Customer> list = iCustomerService.selectCustomer(util,customer);
		Integer count = iCustomerService.getCount();
		
		
		Resbody resbody = new Resbody();
		resbody.setCode(0);
		resbody.setCount(count);
		resbody.setData(list);
		resbody.setMsg("");
		
		return resbody;
	}
	
	@RequestMapping("/updateCustomer.action")
	public int updateCustomer(Customer customer) {
		
		Integer res = iCustomerService.updateCustomer(customer);
		return res;
	}
	
	@RequestMapping("/addCustomer.action")
	public Resbody addCustomer(Customer customer,Visit visit) {
		
		Resbody resbody = new Resbody();
		
		Integer res = iCustomerService.addCustomer(customer);
		
		if (res <= 0) {
			resbody.setCode(-1);
			resbody.setMsg("客户添加失败");
		} else {
			resbody.setCode(0);
		}
		
		return resbody;
	}
	
	@RequestMapping("/deleteCustomer.action")
	public int deleteCustomer(Integer cid) {
		Integer res = iCustomerService.deleteCustomer(cid);
		return res;
	}
	
	@RequestMapping("/addVisit.action")
	public Resbody addVisit(Customer customer) {
		Resbody resbody = new Resbody();
		int res = iVisitService.insertVisit(customer);
		if (res <= 0) {
			resbody.setCode(-1);
			resbody.setMsg("回访记录添加失败");
		}else {
			resbody.setCode(0);
		}
		return resbody;
	}
	
}
