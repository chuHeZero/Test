package com.st.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.domain.Role;
import com.st.mapper.RoleMapper;
import com.st.service.IRoleService;

@Service
public class RoleServiceImpl implements IRoleService {

	@Autowired
	private RoleMapper RoleMapper;
	
	@Override
	public List<Role> getrole() {
		// TODO Auto-generated method stub
		return RoleMapper.getrole();
	}

}
