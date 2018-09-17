package com.st.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.domain.Market;
import com.st.domain.Util;
import com.st.mapper.MarketMapper;
import com.st.service.IMarketService;

@Service
public class MarketServiceImpl implements IMarketService {

	@Autowired
	private MarketMapper marketMapper;
	
	@Override
	public List<Market> selectMarket(Util util,Market market) {
		// TODO Auto-generated method stub
		return marketMapper.selectMarket(util,market);
	}

	@Override
	public Integer getCount() {
		// TODO Auto-generated method stub
		return marketMapper.getCount();
	}

	@Override
	public Integer updateMarket(Market market) {
		// TODO Auto-generated method stub
		return marketMapper.updateMarket(market);
	}

	@Override
	public Integer insertMarket(Market market) {
		// TODO Auto-generated method stub
		return marketMapper.insertMarket(market);
	}

	@Override
	public Integer deleteMarket(Integer mid) {
		// TODO Auto-generated method stub
		return marketMapper.deleteMarket(mid);
	}

}
