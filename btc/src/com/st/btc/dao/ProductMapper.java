package com.st.btc.dao;

import java.util.List;

import com.st.btc.pojo.Ftype;
import com.st.btc.pojo.Product;
import com.st.btc.util.Page;

public interface ProductMapper {

	int add(Product product);

	Integer getRows(Product product);

	List<Product> selectAll(Page page);
	
	int updatepc(Product product);
	
	int removepc(Product product);
	
	Integer getRowss(Ftype ftype);
	
	List<Ftype> ftype(Page page);
	
	int updatefs(Ftype ftype);
	
	int removefs(Ftype ftype);
	
	int addtype(Ftype ftype);

	List<Ftype> FType();

	List<Ftype> SType();

	Product selectproduct(Integer pid);
	
	int updatecount(Integer pid, Integer count);
}
