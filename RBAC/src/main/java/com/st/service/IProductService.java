package com.st.service;

import java.util.List;
import java.util.Map;

import com.st.domain.Market;
import com.st.domain.Product;
import com.st.domain.Util;

public interface IProductService {

	List<Product> selectProduct(Util util,Product product);

	Integer getCount();

	Integer addProduct(Product product);

	Integer updateProduct(Product product);

	Integer deleteProduct(Integer pid);

	List<Product> getproductByPid(String pid);

	List<Product> getAllproduct(String ptype);

	List<Product> getProduct();

	List<Map<String, Object>> getSalesCount();

	int updatePcount(Market market);

	Product OneProduct(String pid);



}
