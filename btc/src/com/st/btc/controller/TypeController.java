package com.st.btc.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.st.btc.service.ITypeService;

//产品大小分类的controller
@Controller
public class TypeController {

	@Autowired
	private ITypeService iTypeService;
	
	@RequestMapping("/getFType.action")
	@ResponseBody
	public List<HashMap<String, Object>> getFType(){
		
		return iTypeService.getFType();
	}
	
	@RequestMapping("/getSType.action")
	@ResponseBody
	public List<HashMap<String, Object>> getSType(Integer ptid){
		
		return iTypeService.getSType(ptid);
	}
	
	@RequestMapping("/getSTypeP.action")
	@ResponseBody
	public List<HashMap<String, Object>> getSTypeP(Integer tid){
		
		return iTypeService.getSTypeP(tid);
	}
	

}
