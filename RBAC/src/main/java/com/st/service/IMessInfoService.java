package com.st.service;

import java.util.List;

import com.st.domain.MessInfo;

public interface IMessInfoService {

	List<MessInfo> getMessInfo(Integer sid);


}
