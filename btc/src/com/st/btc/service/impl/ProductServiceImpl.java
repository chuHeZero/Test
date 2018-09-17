package com.st.btc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.btc.dao.ProductMapper;
import com.st.btc.pojo.Ftype;
import com.st.btc.pojo.Product;
import com.st.btc.service.IProductService;
import com.st.btc.util.Page;
@Service
public class ProductServiceImpl implements IProductService {

	@Autowired
	private ProductMapper productMapper;
	
	@Override
	public int addproduct(Product product) {
		// TODO Auto-generated method stub
		return productMapper.add(product);
	}

	@Override
	public Page selectAll(Product product, Page page) {
		// 需要知道有几条数据

		Integer count = productMapper.getRows(product);
		
		//计算有几个页面
		page.setRows(count);
		page.setWhere(product);
		
		List<Product> list = productMapper.selectAll(page);
		page.setList(list);
		
		return page;
	}

	@Override
	public int updatepc(Product product) {
		// 
		
		return productMapper.updatepc(product);
	}

	@Override
	public int removepc(Product product) {
		// TODO Auto-generated method stub
		return productMapper.removepc(product);
	}

	@Override
	public Page fstype(Ftype ftype ,Page page) {
		// 
		Integer count = productMapper.getRowss(ftype);
		
		//计算有几个页面
		page.setRows(count);
		page.setWhere(ftype);
		
		List<Ftype> list = productMapper.ftype(page);
		page.setList(list);
		
		return page;
	}

	@Override
	public int updatefs(Ftype ftype) {
		// 
		return productMapper.updatefs(ftype);
	}

	@Override
	public int removefs(Ftype ftype) {
		// 
		return productMapper.removefs(ftype);
	}

	@Override
	public int addtype(Ftype ftype) {
		// TODO Auto-generated method stub
		if ("".equals(ftype.getTname())) {
			return -100;
		}
		
		return productMapper.addtype(ftype);
	}

	@Override
	public List<Ftype> FType() {
		// 
		return productMapper.FType();
	}

	@Override
	public List<Ftype> SType() {
		
		return productMapper.SType();
	}

	@Override
	public Product selectproduct(Integer pid) {
		// TODO Auto-generated method stub
		return productMapper.selectproduct(pid);
	}

}
