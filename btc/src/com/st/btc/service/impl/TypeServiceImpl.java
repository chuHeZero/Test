package com.st.btc.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.btc.dao.TypeMapper;
import com.st.btc.service.ITypeService;
@Service
public class TypeServiceImpl implements ITypeService {

	@Autowired
	private TypeMapper typeMapper;
	@Override
	public List<HashMap<String, Object>> getFType() {
		// 
		return typeMapper.getFType();
	}
	@Override
	public List<HashMap<String, Object>> getSType(Integer ptid) {
		// TODO Auto-generated method stub
		return typeMapper.getSType(ptid);
	}
	
	@Override
	public List<HashMap<String, Object>> getSTypeP(Integer tid) {
		// TODO Auto-generated method stub
		return typeMapper.getSTypeP(tid);
	}

}
