package com.st.service;

import java.util.List;

import com.st.domain.Market;
import com.st.domain.Util;

public interface IMarketService {

	List<Market> selectMarket(Util util,Market market);
	
	Integer getCount();

	Integer updateMarket(Market market);

	Integer insertMarket(Market market);

	Integer deleteMarket(Integer mid);
}
