package com.st.domain;

public class Product {

	private Integer pid;
	private String pname;
	private String pdept;
	private Double pprice;
	private Double pprice_min;
	private Integer pcount;
	private String pimg;
	private String ptype;
	private String rname;
	private String tname;
	
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	public String getRname() {
		return rname;
	}
	public void setRname(String rname) {
		this.rname = rname;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getPdept() {
		return pdept;
	}
	public void setPdept(String pdept) {
		this.pdept = pdept;
	}
	public Double getPprice() {
		return pprice;
	}
	public void setPprice(Double pprice) {
		this.pprice = pprice;
	}
	public Double getPprice_min() {
		return pprice_min;
	}
	public void setPprice_min(Double pprice_min) {
		this.pprice_min = pprice_min;
	}
	public Integer getPcount() {
		return pcount;
	}
	public void setPcount(Integer pcount) {
		this.pcount = pcount;
	}
	public String getPimg() {
		return pimg;
	}
	public void setPimg(String pimg) {
		this.pimg = pimg;
	}
	public String getPtype() {
		return ptype;
	}
	public void setPtype(String ptype) {
		this.ptype = ptype;
	}
	
}
