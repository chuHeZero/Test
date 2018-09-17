package com.st.mapper;

import java.util.List;

import com.st.domain.Access;

public interface AccessMapper {

	List<Access> selectByRid(Integer rid);
}
