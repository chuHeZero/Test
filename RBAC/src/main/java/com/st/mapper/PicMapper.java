package com.st.mapper;

import java.util.List;

import com.st.domain.Pic;

public interface PicMapper {

	int insertBatch(String[] pics, Integer pid);

	List<Pic> getPic(String pid);

	int deletePic(Integer pid);

	List<Pic> ManyPic(String pid);
}
