package com.st.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.domain.Menu;
import com.st.mapper.MenuMapper;
import com.st.service.IMenuService;
@Service
public class MenuServiceImpl implements IMenuService {

	@Autowired
	private MenuMapper menuMapper;
	

	@Override
	public List<Menu> getmenu(Integer roleid) {
		// TODO Auto-generated method stub
		return menuMapper.getmenu(roleid);
	}



}
