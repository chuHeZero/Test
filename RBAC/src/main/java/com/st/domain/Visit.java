package com.st.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Visit {

	private Integer id;
	private String cid;
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	private Date vtime;
	private String vdecpt;
	private String vremarks;
	private String sid;
	
	private String vname;
	private String cname;
	private String sname;
	
	
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public String getVname() {
		return vname;
	}
	public void setVname(String vname) {
		this.vname = vname;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public Date getVtime() {
		return vtime;
	}
	public void setVtime(Date vtime) {
		this.vtime = vtime;
	}
	
	public String getVdecpt() {
		return vdecpt;
	}
	public void setVdecpt(String vdecpt) {
		this.vdecpt = vdecpt;
	}
	public String getVremarks() {
		return vremarks;
	}
	public void setVremarks(String vremarks) {
		this.vremarks = vremarks;
	}
	
}
