package com.st.btc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.btc.dao.UserMapper;
import com.st.btc.pojo.User;
import com.st.btc.service.IUserService;
import com.st.btc.util.MD5Util;
import com.st.btc.util.Page;
@Service
public class UserServiceImpl implements IUserService {

	@Autowired
	UserMapper iUserMapper;
	
	@Override
	public User login(User user) {
		//访问数据库之前，进行MD5加密
		
		String vpwd = MD5Util.getMD5(user.getPassword());
		user.setPassword(vpwd);
		
	 return iUserMapper.login(user);
	}

	@Override
	public int register(User user, String password1) {
	
		User user2 = iUserMapper.selectByName(user.getUname());

		if (user2 != null) {
			return -100;
		} else {

			if (password1.equals(user.getPassword())) {

				String vpwd = MD5Util.getMD5(user.getPassword());
				user.setPassword(vpwd);
				return iUserMapper.register(user);
			} else {
				return -200;
			}
		}
	}

	@Override
	public int selectinfo(User user) {
		// 密码不一致
		// 字段为空
		// 密码加密
		// 调用mapper
		
		
		String vpwd = MD5Util.getMD5(user.getPassword());
		user.setPassword(vpwd);
		
		return iUserMapper.selectinfo(user);
		
	}

	@Override
	public int newpwd(User user, String password1) {
		// 密码不一致
		// 字段为空
		// 密码加密
		// 调用mapper
		if (!password1.equals(user.getPassword())) {
			return -100;
		}
		if ("".equals(password1)) {
			return -200;
		}
		
		String vpwd = MD5Util.getMD5(user.getPassword());
		user.setPassword(vpwd);
		
		return iUserMapper.newpwd(user);
	}

	@Override
	public int newmoney(User user, String password) {
		// 判断密码是否一致
		String vpwd = MD5Util.getMD5(password);
		
		if (!vpwd.equals(user.getPassword())) {
			return -100;
		}
		if (user.getUmoney()==null) {
			//充值金额为空
			return -200;
		}
		if (user.getUmoney()<=0) {
			//充值金额大于等于0
			return -300;
		}
		return iUserMapper.newmoney(user);
	}

	@Override
	public Page selectuserAll(User user, Page page) {
		// 需要知道有几条数据

		Integer count = iUserMapper.getRows(user);
		
		//计算有几个页面
		page.setRows(count);
		page.setWhere(user);
		
		List<User> list = iUserMapper.selectAll(page);
		page.setList(list);
		
		return page;
	}

	@Override
	public int updateuser(User user,String password1) {
		// 
		if (!password1.equals(user.getPassword())) {
			return -100;
		}
		if ("".equals(password1)) {
			return -200;
		}
		String vpwd = MD5Util.getMD5(user.getPassword());
		user.setPassword(vpwd);
		
		return iUserMapper.updateuser(user);
	}

	@Override
	public int removeuser(User user) {
		// 
		return iUserMapper.removeuser(user);
	}


}
