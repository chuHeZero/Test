package com.st.btc.dao;

import java.util.HashMap;
import java.util.List;

public interface TypeMapper {

	List<HashMap<String, Object>> getFType();

	List<HashMap<String, Object>> getSType(Integer ptid);
	
	List<HashMap<String, Object>> getSTypeP(Integer tid);
}
