package com.st.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.domain.Intentionstate;
import com.st.mapper.TetMapper;
import com.st.service.ItetService;

@Service
public class TetServiceImpl implements ItetService {

	@Autowired
	private TetMapper tetMapper;
	
	@Override
	public List<Intentionstate> gettent(String iid) {
		// TODO Auto-generated method stub
		return tetMapper.gettent(iid);
	}

}
