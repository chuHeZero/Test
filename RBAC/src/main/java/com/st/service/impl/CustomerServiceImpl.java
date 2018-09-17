package com.st.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.domain.Customer;
import com.st.domain.Util;
import com.st.mapper.CustomerMapper;
import com.st.service.ICustomerService;
@Service
public class CustomerServiceImpl implements ICustomerService {

	@Autowired
	private CustomerMapper customerMapper;
	
	
	@Override
	public List<com.st.domain.Customer> selectCustomer(Util util,Customer customer) {
		// TODO Auto-generated method stub
		return customerMapper.selectCustomer(util,customer);
	}

	@Override
	public Integer getCount() {
		// TODO Auto-generated method stub
		return customerMapper.getCount();
	}

	@Override
	public Integer updateCustomer(Customer customer) {
		// TODO Auto-generated method stub
		Integer res = customerMapper.updateCustomer(customer);
		if (res>0) {
			return -100;
		}else {
			return -200;
		}
	}

	@Override
	public Integer addCustomer(Customer customer) {
		// TODO Auto-generated method stub
		return customerMapper.addCustomer(customer);
	}

	@Override
	public Integer deleteCustomer(Integer cid) {
		// TODO Auto-generated method stub
		return customerMapper.deleteCustomer(cid);
	}

	@Override
	public List<Customer> getCustomer() {
		// TODO Auto-generated method stub
		return customerMapper. getCustomer();
	}

}
