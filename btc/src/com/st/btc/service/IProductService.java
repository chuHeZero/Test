package com.st.btc.service;



import java.util.List;

import com.st.btc.pojo.Ftype;
import com.st.btc.pojo.Product;
import com.st.btc.util.Page;

public interface IProductService {

	int addproduct(Product product);

	Page selectAll(Product product, Page page);
	
	int updatepc(Product product);
	
	int removepc(Product product);
	
	Page fstype(Ftype ftype,Page page);
	
	int updatefs(Ftype ftype);
	
	int removefs(Ftype ftype);
	
	int addtype(Ftype ftype);

	List<Ftype> FType();

	List<Ftype> SType();

	Product selectproduct(Integer pid);
}
