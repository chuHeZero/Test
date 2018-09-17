package com.st.btc.pojo;

public class Details {

	private Integer did;
	private String onum;
	private Integer pid;
	private Integer pcount;
	private Double pprice;
	
	private Product product;
	
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public Integer getDid() {
		return did;
	}
	public void setDid(Integer did) {
		this.did = did;
	}
	public String getOnum() {
		return onum;
	}
	public void setOnum(String onum) {
		this.onum = onum;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public Integer getPcount() {
		return pcount;
	}
	public void setPcount(Integer pcount) {
		this.pcount = pcount;
	}
	public Double getPprice() {
		return pprice;
	}
	public void setPprice(Double pprice) {
		this.pprice = pprice;
	}
	
}
