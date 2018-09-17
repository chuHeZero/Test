package com.st.btc.dao;

import com.st.btc.pojo.Manager;

public interface ManagerMapper {

	Manager login(Manager mgr);
	
	int newpwd(Manager mgr);
}
