package com.st.service;

import java.util.List;
import java.util.Map;

import com.st.domain.Staff;
import com.st.domain.Util;

public interface IStaffService {

	Staff loginstaff(Staff staff);
	
	List<Staff> selectStaff(Staff staff,Util util);

	Integer getCount();

	List<Staff> getstaffByRoleid(String sid_leader);

	List<Staff> getByroleid(Integer roleid);

	Integer updateStaff(Staff staff);

	Integer insertStaff(Staff sta);

	Integer deleteStaff(Integer sid);

	List<Staff> getstaff();

	List<Map<String, Object>> getStaffCount();

	int updatePwd(Staff staff, String spwd, String pwd1, String pwd2);

	Integer updateMyInfo(Staff staff);

	

}
