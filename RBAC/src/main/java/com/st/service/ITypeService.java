package com.st.service;

import java.util.List;

import com.st.domain.Type;
import com.st.domain.Util;

public interface ITypeService {

	List<Type> selectType(Util util);

	Integer getCount();

	List<Type> gettype();

	Integer updateType(Type type);

	Integer deleteType(Integer tid);

	Integer insertType(Type type);


}
