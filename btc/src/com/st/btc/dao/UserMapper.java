package com.st.btc.dao;

import java.util.List;

import com.st.btc.pojo.User;
import com.st.btc.util.Page;

public interface UserMapper {
	User login(User user);
	
	User selectByName(String uname);
	
	int register(User user);

	int selectinfo(User user);

	int newpwd(User user);

	int newmoney(User user);

	Integer getRows(User user);

	List<User> selectAll(Page page);
	
	int updateuser(User user);
	
	int removeuser(User user);
	
	int updatemoney(Integer uid,Double money);
}
