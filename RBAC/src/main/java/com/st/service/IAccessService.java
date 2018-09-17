package com.st.service;

import java.util.List;
import java.util.Map;

import com.st.domain.Access;

public interface IAccessService {

	Map<String, String> selectByRid(Integer rid);
}
