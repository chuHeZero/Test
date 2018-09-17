package com.st.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.domain.MessInfo;
import com.st.mapper.MessInfoMapper;
import com.st.service.IMessInfoService;
@Service
public class MessInfoServiceImpl implements IMessInfoService {

	@Autowired
	private MessInfoMapper messInfoMapper;
	
	@Override
	public List<MessInfo> getMessInfo(Integer sid) {
		// TODO Auto-generated method stub
		return messInfoMapper.getMessInfo(sid);
	}

}
