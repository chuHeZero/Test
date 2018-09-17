package com.st.service;

import java.util.List;

import com.st.domain.Menu;
import com.st.domain.Role;


public interface IMenuService {


	List<Menu> getmenu(Integer roleid);

	



}
