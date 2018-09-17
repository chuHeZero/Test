package com.st.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.st.domain.Resbody;
import com.st.domain.Util;
import com.st.domain.Visit;
import com.st.domain.Visitstate;
import com.st.service.IVisitService;

@Controller
@RequestMapping("/Visit")
public class VisitController {

	@Autowired
	private IVisitService iVisitService;
	
	@RequestMapping("/selectVisit.action")
	@ResponseBody
	public Resbody selectVisit(Util util,Visit visit) {
		
		Integer start = (util.getPage()-1)*util.getLimit();
		util.setStart(start);
		List<Visit> list = iVisitService.selectVisit(util,visit);
		Integer count = iVisitService.getCount();
		Resbody resbody = new Resbody();
		resbody.setCode(0);
		resbody.setCount(count);
		resbody.setData(list);
		resbody.setMsg("");
		
		return resbody;
	}
	
	@RequestMapping("/rt.action")
	@ResponseBody
	public Resbody rt(String cid) {
		System.out.println(cid);
		List<Visit> visits = iVisitService.rt(cid);
		Resbody resbody = new Resbody();
		resbody.setCode(0);
		resbody.setData(visits);
		resbody.setMsg("");
		
		return resbody;
	}
	
	@RequestMapping("/selectRvisit.action")
	@ResponseBody
	public Resbody selectRvisit() {
		
		List<Visit> list = iVisitService.selectRvisit();
		Resbody resbody = new Resbody();
		resbody.setCode(0);
		resbody.setData(list);
		resbody.setMsg("");
		
		return resbody;
	}
	
	@RequestMapping("/getvisit.action")
	@ResponseBody
	public List<Visit> getvisit() {
		List<Visit> visits = iVisitService.getvisit();
		
		return visits;
	}
	
	@RequestMapping("/getvisitstate.action")
	@ResponseBody
	public List<Visitstate> getvisitstate(){
		
		List<Visitstate> visitstates = iVisitService.getvisitstate();
		
		return visitstates;
	}
	
	@RequestMapping("/updatevisit.action")
	@ResponseBody
	public Integer updatevisit(Visit visit) {
		
		Integer res = iVisitService.updatevisit(visit);
		
		return res;
	}
	
	@RequestMapping("/deletevisit.action")
	@ResponseBody
	public Integer deletevisit(Integer id) {
		
		Integer res = iVisitService.deletevisit(id);
		
		return res;
	}
}
