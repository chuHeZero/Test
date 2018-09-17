package com.st.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.domain.Market;
import com.st.domain.Product;
import com.st.domain.Util;
import com.st.mapper.ProductMapper;
import com.st.service.IProductService;
@Service
public class ProductServiceImpl implements IProductService {

	@Autowired
	private ProductMapper productMapper;
	
	@Override
	public List<Product> selectProduct(Util util,Product product) {
		// TODO Auto-generated method stub
		return productMapper.selectProduct(util,product);
	}

	@Override
	public Integer getCount() {
		// TODO Auto-generated method stub
		return productMapper.getCount();
	}

	@Override
	public Integer addProduct(Product product) {
		// TODO Auto-generated method stub
		return productMapper.addProduct(product);
	
	}

	@Override
	public Integer updateProduct(Product product) {
		// TODO Auto-generated method stub
		Integer res = productMapper.updateProduct(product);
		if (res>0) {
			return -100;
		}else {
			return -200;
		}
	}

	@Override
	public Integer deleteProduct(Integer pid) {
		// TODO Auto-generated method stub
		return  productMapper.deleteProduct(pid);
	}

	@Override
	public List<Product> getproductByPid(String pid) {
		// TODO Auto-generated method stub
		
		return productMapper.getproductByPid(pid);
		
	}

	@Override
	public List<Product> getAllproduct(String ptype) {
		// TODO Auto-generated method stub
		return productMapper.getAllproduct(ptype);
	}

	@Override
	public List<Product> getProduct() {
		// TODO Auto-generated method stub
		return productMapper.getProduct();
	}

	@Override
	public List<Map<String, Object>> getSalesCount() {
		// TODO Auto-generated method stub
		return productMapper.getSalesCount();
	}

	@Override
	public int updatePcount(Market market) {
		// TODO Auto-generated method stub
		return productMapper.updatePcount(market);
	}

	@Override
	public Product OneProduct(String pid) {
		// TODO Auto-generated method stub
		return productMapper.OneProduct(pid);
	}


}
