package com.st.btc.dao;

import java.util.List;

import com.st.btc.pojo.Details;
import com.st.btc.pojo.Order;

public interface OrderMapper {

	int addorder(Order order);

	List<Order> selectByUId(Integer uid);
	
	List<Details> getorinfo(String onum);

	List<Order> selectorder(String oname);

	List<Details> getmgrorinfo(String onum);
}
