package com.st.btc.service;

import com.st.btc.pojo.Manager;

public interface IManagerService {

	Manager login(Manager mgr);

	int newpwd(Manager mgr, String password1);
}
