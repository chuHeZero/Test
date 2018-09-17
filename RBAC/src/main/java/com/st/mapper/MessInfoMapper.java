package com.st.mapper;

import java.util.List;

import com.st.domain.MessInfo;

public interface MessInfoMapper {

	List<MessInfo> getMessInfo(Integer sid);

}
