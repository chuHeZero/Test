package com.st.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.st.domain.Resbody;
import com.st.domain.Type;
import com.st.domain.Util;
import com.st.service.ITypeService;

@RestController
@RequestMapping("/Type")
public class TypeController {

	@Autowired
	private ITypeService iTypeService;
	
	@RequestMapping("/selectType.action")
	public Resbody selectType(Util util) {
		
		Integer start = (util.getPage()-1)*util.getLimit();
		util.setStart(start);
		List<Type> list = iTypeService.selectType(util);
		Integer count = iTypeService.getCount();
		Resbody resbody = new Resbody();
		resbody.setCode(0);
		resbody.setCount(count);
		resbody.setData(list);
		resbody.setMsg("");
		
		return resbody;
	}
	
	@RequestMapping("/updateType.action")
	public int updateType(Type type) {
		Integer res = iTypeService.updateType(type);
		return res;
	}
	
	@RequestMapping("/deleteType.action")
	public int deleteType(Integer tid) {
		
		Integer res = iTypeService.deleteType(tid);
		
		return res;
	}
	
	@RequestMapping("/insertType.action")
	public int insertType(Type type) {
		
		Integer res = iTypeService.insertType(type);
		return res;
	}
	
}
