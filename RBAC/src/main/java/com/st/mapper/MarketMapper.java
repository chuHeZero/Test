package com.st.mapper;

import java.util.List;

import com.st.domain.Market;
import com.st.domain.Util;

public interface MarketMapper {

	List<Market> selectMarket(Util util,Market market);
	
	Integer  getCount();

	Integer updateMarket(Market market);

	Integer insertMarket(Market market);

	Integer deleteMarket(Integer mid);
}
