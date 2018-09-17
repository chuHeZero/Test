package com.st.btc.service;

import com.st.btc.pojo.User;
import com.st.btc.util.Page;

public interface IUserService {
	User login(User user);
	
	int register(User user, String password1);

	int selectinfo(User user);

	int newpwd(User user, String password1);

	int newmoney(User user, String password);

	Page selectuserAll(User user, Page page);
	
	int updateuser(User user,String password1);
	
	int removeuser(User user);
}
