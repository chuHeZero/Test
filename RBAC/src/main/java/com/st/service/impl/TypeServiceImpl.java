package com.st.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.domain.Type;
import com.st.domain.Util;
import com.st.mapper.TypeMapper;
import com.st.service.ITypeService;

@Service
public class TypeServiceImpl implements ITypeService {

	@Autowired
	private TypeMapper typeMapper;
	
	@Override
	public List<Type> selectType(Util util) {
		// TODO Auto-generated method stub
		return typeMapper.selectType(util);
	}

	@Override
	public Integer getCount() {
		// TODO Auto-generated method stub
		return typeMapper.getCount();
	}

	@Override
	public List<Type> gettype() {
		// TODO Auto-generated method stub
		return typeMapper.gettype();
	}

	@Override
	public Integer updateType(Type type) {
		// TODO Auto-generated method stub
		return typeMapper.updateType(type);
	}

	@Override
	public Integer deleteType(Integer tid) {
		// TODO Auto-generated method stub
		return typeMapper.deleteType(tid);
	}

	@Override
	public Integer insertType(Type type) {
		// TODO Auto-generated method stub
		return typeMapper.insertType(type);
	}

}
