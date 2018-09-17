package com.st.btc.util;

import java.util.List;

//辅助分页查询
public class Page {

	//1每页显示记录数
	private Integer pagerows = 5;
	
	//2当前页
	private Integer curpage;
	//3总页数
	private Integer pagecount;
	
	//4总条数
	private Integer rows;
	
	//5查询数据集合
	private List list;
	
	//6查询起点
	private Integer start;
	//7查询条件
	private Object where;

	public Object getWhere() {
		return where;
	}

	public void setWhere(Object where) {
		this.where = where;
	}

	public Integer getStart() {
		return start;
	}

	public void setStart(Integer start) {
		this.start = start;
	}

	public List<Object> getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	public Integer getPagerows() {
		return pagerows;
	}

	public void setPagerows(Integer pagerows) {
		this.pagerows = pagerows;
		this.start = (curpage-1) * this.pagerows;
	}

	public Integer getCurpage() {
		return curpage;
	}

	public void setCurpage(Integer curpage) {
		this.curpage = curpage;
		//计算查询起点
		this.start = (curpage-1) * this.pagerows;
	}

	public Integer getPagecount() {
		return pagecount;
	}

	public void setPagecount(Integer pagecount) {
		this.pagecount = pagecount;
	}

	public Integer getRows() {
		return rows;
	}

	public void setRows(Integer rows) {
		this.rows = rows;
		
		this.pagecount= (this.rows+this.pagerows-1) / this.pagerows;
	}
	
}
