package com.st.service;

import java.util.List;

import com.st.domain.Customer;
import com.st.domain.Util;

public interface ICustomerService {

	List<Customer> selectCustomer(Util util,Customer customer);

	Integer getCount();

	Integer updateCustomer(Customer customer);

	Integer addCustomer(Customer customer);

	Integer deleteCustomer(Integer cid);

	List<Customer> getCustomer();
}
