package com.st.mapper;

import java.util.List;

import com.st.domain.Customer;
import com.st.domain.Util;
import com.st.domain.Visit;
import com.st.domain.Visitstate;

public interface VisitMapper {

	List<Visitstate> getvisitstate();

	List<Visit> selectVisit(Util util,Visit visit);

	Integer getCount();

	List<Visit> getvisit();

	Integer updatevisit(Visit visit);

	int insertVisit(Customer customer);

	List<Visit> selectRvisit();

	Integer deletevisit(Integer id);

	List<Visit> rt(String cid);

}
