package com.st.btc.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.btc.dao.ManagerMapper;
import com.st.btc.pojo.Manager;
import com.st.btc.service.IManagerService;
import com.st.btc.util.MD5Util;

@Service
public class ManagerServiceImpl implements IManagerService {

	@Autowired
	private ManagerMapper iManagerMapper;
	
	@Override
	public Manager login(Manager mgr) {
		// 
		return iManagerMapper.login(mgr);
	}

	@Override
	public int newpwd(Manager mgr, String mpassword1) {
		//
		
		if (!mpassword1.equals(mgr.getMpassword())) {
			return -100;
		}
		if ("".equals(mpassword1)) {
			return -200;
		}
		return iManagerMapper.newpwd(mgr);
	}

}
