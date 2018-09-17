package com.st.mapper;

import java.util.List;
import java.util.Map;

import com.st.domain.Staff;
import com.st.domain.Util;

public interface StaffMapper {

	List<Staff> selectStaff(Staff staff,Util util);

	Staff loginstaff(Staff staff);

	Integer getCount();

	List<Staff> getstaffByRoleid(String sid_leader);

	List<Staff> getByroleid(Integer roleid);

	Integer updateStaff(Staff staff);

	Integer insertStaff(Staff sta);

	Integer deleteStaff(Integer sid);

	List<Staff> getstaff();

	List<Map<String, Object>> getStaffCount();

	int updatePwd(Staff staff);

	Integer updateMyInfo(Staff staff);

}
