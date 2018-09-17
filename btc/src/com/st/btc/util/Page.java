package com.st.btc.util;

import java.util.List;

//������ҳ��ѯ
public class Page {

	//1ÿҳ��ʾ��¼��
	private Integer pagerows = 5;
	
	//2��ǰҳ
	private Integer curpage;
	//3��ҳ��
	private Integer pagecount;
	
	//4������
	private Integer rows;
	
	//5��ѯ���ݼ���
	private List list;
	
	//6��ѯ���
	private Integer start;
	//7��ѯ����
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
		//�����ѯ���
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
