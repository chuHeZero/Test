package com.st.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Market {

	private Integer mid;
	private String cid;
	private String sid;
	private String pid;
	private Integer mcount;
	private Double mprice;
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	private Date mtime;
	private String mremarks;
	private String cname;
	private String sname;
	private String pname;
	
	 
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getMremarks() {
		return mremarks;
	}
	public void setMremarks(String mremarks) {
		this.mremarks = mremarks;
	}
	public Integer getMid() {
		return mid;
	}
	public void setMid(Integer mid) {
		this.mid = mid;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public Integer getMcount() {
		return mcount;
	}
	public void setMcount(Integer mcount) {
		this.mcount = mcount;
	}
	public Double getMprice() {
		return mprice;
	}
	public void setMprice(Double mprice) {
		this.mprice = mprice;
	}
	public Date getMtime() {
		return mtime;
	}
	public void setMtime(Date mtime) {
		this.mtime = mtime;
	}
	@Override
	public String toString() {
		return "Market [mid=" + mid + ", cid=" + cid + ", sid=" + sid + ", pid=" + pid + ", mcount=" + mcount
				+ ", mprice=" + mprice + ", mtime=" + mtime + ", mremarks=" + mremarks + ", cname=" + cname + ", sname="
				+ sname + ", pname=" + pname + "]";
	}
	
}
