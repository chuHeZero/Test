package com.st.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Staff {

	private Integer sid;
	private String sname;
	private String spassword;
	private String ssex;
	 @JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	private Date sbirthday;
	private String sphone;
	private Integer roleid;
	private String sid_leader;
	private String sstate;
	private Integer stime;
	
	private String rname;
	private String sleader;
	
	//经理只显示自己手下的员工需要的参数,直接不让经理修改 此处两个参数无效
	private Integer fid;
	private Integer rid;
	
	
	public Integer getFid() {
		return fid;
	}
	public void setFid(Integer fid) {
		this.fid = fid;
	}
	public Integer getRid() {
		return rid;
	}
	public void setRid(Integer rid) {
		this.rid = rid;
	}
	public String getRname() {
		return rname;
	}
	public void setRname(String rname) {
		this.rname = rname;
	}
	public String getSleader() {
		return sleader;
	}
	public void setSleader(String sleader) {
		this.sleader = sleader;
	}
	public Integer getSid() {
		return sid;
	}
	public void setSid(Integer sid) {
		this.sid = sid;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	
	public String getSpassword() {
		return spassword;
	}
	public void setSpassword(String spassword) {
		this.spassword = spassword;
	}
	public String getSsex() {
		return ssex;
	}
	public void setSsex(String ssex) {
		this.ssex = ssex;
	}
	public Date getSbirthday() {
		return sbirthday;
	}
	public void setSbirthday(Date sbirthday) {
		this.sbirthday = sbirthday;
	}
	public String getSphone() {
		return sphone;
	}
	public void setSphone(String sphone) {
		this.sphone = sphone;
	}
	public Integer getRoleid() {
		return roleid;
	}
	public void setRoleid(Integer roleid) {
		this.roleid = roleid;
	}
	public String getSid_leader() {
		return sid_leader;
	}
	public void setSid_leader(String sid_leader) {
		this.sid_leader = sid_leader;
	}
	public String getSstate() {
		return sstate;
	}
	public void setSstate(String sstate) {
		this.sstate = sstate;
	}
	public Integer getStime() {
		return stime;
	}
	public void setStime(Integer stime) {
		this.stime = stime;
	}
	@Override
	public String toString() {
		return "Staff [sid=" + sid + ", sname=" + sname + ", spassword=" + spassword + ", ssex=" + ssex + ", sbirthday="
				+ sbirthday + ", sphone=" + sphone + ", roleid=" + roleid + ", sid_leader=" + sid_leader + ", sstate="
				+ sstate + ", stime=" + stime + ", rname=" + rname + ", sleader=" + sleader + "]";
	}
	
	
}
