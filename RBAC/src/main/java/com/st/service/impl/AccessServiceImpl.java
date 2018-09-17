package com.st.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.domain.Access;
import com.st.mapper.AccessMapper;
import com.st.service.IAccessService;
@Service
public class AccessServiceImpl implements IAccessService {

	@Autowired
	private AccessMapper accessMapper;
	
	@Override
	public Map<String, String> selectByRid(Integer rid) {
		// TODO Auto-generated method stub
		List<Access> accesses = accessMapper.selectByRid(rid);
		
		//通过list生成map
		Map<String, String> map = new HashMap<>();
		
		
		for (Access access : accesses) {
			
			map.put(access.getUrl(), access.getUrlname());
		}
		
		return map;
	}

}
