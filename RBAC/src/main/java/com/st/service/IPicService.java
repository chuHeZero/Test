package com.st.service;

import java.util.List;

import com.st.domain.Pic;

public interface IPicService {

	int addBatch(String[] pics, Integer pid);

	List<Pic> getPic(String pid);

	int deletePic(Integer pid);

	List<Pic> ManyPic(String pid);
}
