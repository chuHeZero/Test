package com.st.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.uutil.MD5Util;
import com.st.domain.Staff;
import com.st.domain.Util;
import com.st.mapper.StaffMapper;
import com.st.service.IStaffService;

@Service
public class StaffServiceImpl implements IStaffService {

	@Autowired
	private StaffMapper staffMapper;
	
	@Override
	public List<Staff> selectStaff(Staff staff,Util util) {
		// TODO Auto-generated method stub
		return staffMapper.selectStaff(staff,util);
	}

	@Override
	public Staff loginstaff(Staff staff) {
		// TODO Auto-generated method stub
		
		//MD5加密
		String vpwd = MD5Util.getMD5(staff.getSpassword());
		staff.setSpassword(vpwd);
		return staffMapper.loginstaff(staff);
	}

	@Override
	public Integer getCount() {
		// TODO Auto-generated method stub
		return staffMapper.getCount();
	}

	@Override
	public List<Staff> getstaffByRoleid(String sid_leader) {
		// TODO Auto-generated method stub
		return staffMapper.getstaffByRoleid(sid_leader);
	}

	@Override
	public List<Staff> getByroleid(Integer roleid) {
		// TODO Auto-generated method stub
		return staffMapper.getByroleid(roleid);
	}

	@Override
	public Integer updateStaff(Staff staff) {
		// TODO Auto-generated method stub
		//MD5加密
		String vpwd = MD5Util.getMD5(staff.getSpassword());
		staff.setSpassword(vpwd);
		return staffMapper.updateStaff(staff);
	}

	@Override
	public Integer insertStaff(Staff sta) {
		//MD5加密
		String vpwd = MD5Util.getMD5(sta.getSpassword());
		sta.setSpassword(vpwd);
		int res = staffMapper.insertStaff(sta);
		if (res>0) {
			return -100;
		}else {
			return -200;
		}
		
		
	}

	@Override
	public Integer deleteStaff(Integer sid) {
		// TODO Auto-generated method stub
		return staffMapper.deleteStaff(sid);
	}

	@Override
	public List<Staff> getstaff() {
		// TODO Auto-generated method stub
		return staffMapper.getstaff();
	}

	@Override
	public List<Map<String, Object>> getStaffCount() {
		// TODO Auto-generated method stub
		return staffMapper.getStaffCount();
	}

	@Override
	public int updatePwd(Staff staff, String spwd, String pwd1, String pwd2) {
		// TODO Auto-generated method stub
		
		//两次新密码是否一致
		if (pwd1.equals(pwd2)) {
			//旧密码是否匹配
			String npwd = MD5Util.getMD5(spwd);
			System.out.println("旧密码"+spwd);
			System.out.println("加密后旧密码"+npwd);
			System.out.println("session中"+staff.getSpassword());
			
			if (npwd.equals(staff.getSpassword())) {
				
				String newpwd = MD5Util.getMD5(pwd2);
				staff.setSpassword(newpwd);
				System.out.println("加密过后的新密码"+newpwd);
				return staffMapper.updatePwd(staff);
			}else {
				return -200;
			}
		}else {
			return -100;
		}
	}

	@Override
	public Integer updateMyInfo(Staff staff) {
		// TODO Auto-generated method stub
		return staffMapper.updateMyInfo(staff);
	}

	

}
