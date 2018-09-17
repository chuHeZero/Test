package com.st.btc.service;


import java.util.List;

import com.st.btc.pojo.Details;
import com.st.btc.pojo.Order;

public interface IOrderService {

	int addorder(Order order);

	List<Order> selectByUId(Integer uid);

	List<Details> getorinfo(String onum);
	

	List<Order> selectorder(String oname);

	List<Details> getmgrorinfo(String onum);
	
}
