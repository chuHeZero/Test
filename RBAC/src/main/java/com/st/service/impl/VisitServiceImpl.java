package com.st.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.domain.Customer;
import com.st.domain.Util;
import com.st.domain.Visit;
import com.st.domain.Visitstate;
import com.st.mapper.VisitMapper;
import com.st.service.IVisitService;

@Service
public class VisitServiceImpl implements IVisitService {

	@Autowired
	private VisitMapper visitMapper;
	
	@Override
	public List<Visitstate> getvisitstate() {
		// TODO Auto-generated method stub
		return visitMapper.getvisitstate();
	}

	@Override
	public List<Visit> selectVisit(Util util,Visit visit) {
		// TODO Auto-generated method stub
		return visitMapper.selectVisit(util,visit);
	}

	@Override
	public Integer getCount() {
		// TODO Auto-generated method stub
		return visitMapper.getCount();
	}

	@Override
	public List<Visit> getvisit() {
		// TODO Auto-generated method stub
		return visitMapper.getvisit();
	}

	@Override
	public Integer updatevisit(Visit visit) {
		// TODO Auto-generated method stub
		return visitMapper.updatevisit(visit);
	}

	@Override
	public int insertVisit(Customer customer) {
		// TODO Auto-generated method stub
		return visitMapper.insertVisit(customer);
	}

	@Override
	public List<Visit> selectRvisit() {
		// TODO Auto-generated method stub
		return visitMapper.selectRvisit();
	}

	@Override
	public Integer deletevisit(Integer id) {
		// TODO Auto-generated method stub
		return visitMapper.deletevisit(id);
	}

	@Override
	public List<Visit> rt(String cid) {
		// TODO Auto-generated method stub
		return visitMapper.rt(cid);
	}

}
