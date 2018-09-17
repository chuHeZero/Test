package com.st.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.domain.Pic;
import com.st.mapper.PicMapper;
import com.st.service.IPicService;
@Service
public class PicServiceImpl implements IPicService {

	@Autowired
	private PicMapper picMapper;
	
	@Override
	public int addBatch(String[] pics, Integer pid) {
		// TODO Auto-generated method stub
		return picMapper.insertBatch(pics, pid);
	}

	@Override
	public List<Pic> getPic(String pid) {
		// TODO Auto-generated method stub
		return picMapper.getPic(pid);
	}

	@Override
	public int deletePic(Integer pid) {
		// TODO Auto-generated method stub
		return picMapper.deletePic(pid);
	}

	@Override
	public List<Pic> ManyPic(String pid) {
		// TODO Auto-generated method stub
		return picMapper.ManyPic(pid);
	}

}
