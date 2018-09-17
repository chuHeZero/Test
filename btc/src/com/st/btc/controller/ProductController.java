package com.st.btc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.st.btc.pojo.Product;
import com.st.btc.service.IProductService;
import com.st.btc.util.Page;

//ǰ̨ҳ����ʾ��Ʒ��Controller
@Controller
public class ProductController  {

	@Autowired
	IProductService iProductService;
	
	@RequestMapping("/productinfo.action")
	public String productmgr() {
		
		return "WEB-INF/product/productinfo";
	}
	
	@RequestMapping("/search.action")
	public  ModelAndView search() {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/WEB-INF/product/search");
		return mv;
	}
	
	@RequestMapping("/selectAll.action")
	@ResponseBody	//�������ķ��ض���ͨ��Jackson��װ��JSON��ʽ���ַ��������ظ��ͻ���
	public Page selsctAll(Product product, Page page) {
		
		
		
		Page respage = iProductService.selectAll(product,page);

		return respage;
	}
	@RequestMapping("/productcount.action")
	@ResponseBody
	public Product Product(Integer pid){
		
		Product product = iProductService.selectproduct(pid);
		
		return product;
	}
}
