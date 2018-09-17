package com.st.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.st.domain.Customer;
import com.st.domain.Intentionstate;
import com.st.domain.Menu;
import com.st.domain.MessInfo;
import com.st.domain.Pic;
import com.st.domain.PicRes;
import com.st.domain.Product;
import com.st.domain.Resbody;
import com.st.domain.Role;
import com.st.domain.Staff;
import com.st.domain.Type;
import com.st.domain.Visitstate;
import com.st.service.ItetService;
import com.st.service.ICustomerService;
import com.st.service.IMenuService;
import com.st.service.IMessInfoService;
import com.st.service.IPicService;
import com.st.service.IProductService;
import com.st.service.IRoleService;
import com.st.service.IStaffService;
import com.st.service.ITypeService;
import com.st.service.IVisitService;

@Controller
public class ViewController {

	@Autowired
	private IMenuService iMenuService;
	
	@Autowired
	private IRoleService iRoleService;
	
	@Autowired
	private IStaffService iStaffService;
	
	@Autowired
	private ITypeService iTypeService;
	
	@Autowired
	private IProductService iProductService;
	
	@Autowired
	private ItetService itetService;
	
	@Autowired
	private IPicService iPicService;
	
	@Autowired
	private IVisitService iVisitService;
	
	@Autowired
	private ICustomerService iCustomerService;
	
	@Autowired
	private IMessInfoService iMessInfoService;
	
	@RequestMapping("/view/staff.action")
	public String staff() {
		return "WEB-INF/views/staff";
	}
	@RequestMapping("/view/product.action")
	public String product() {
		return "WEB-INF/views/product";
	}
	@RequestMapping("/view/customer.action")
	public String customer() {
		return "WEB-INF/views/customer";
	}
	@RequestMapping("/view/type.action")
	public String type() {
		return "WEB-INF/views/type";
	}
	@RequestMapping("/view/market.action")
	public String market() {
		return "WEB-INF/views/market";
	}
	@RequestMapping("/view/updateStaff.action")
	public String updateStaff() {
		return "WEB-INF/views/updateStaff";
	}
	@RequestMapping("/access/view/insertStaffV.action")
	public String insertStaffV() {
		return "WEB-INF/views/insertStaffV";
	}
	@RequestMapping("/access/view/insertProduct.action")
	public String insertProduct() {
		return "WEB-INF/views/insertProduct";
	}
	@RequestMapping("/view/updateProduct.action")
	public String updateProduct() {
		return "WEB-INF/views/updateProduct";
	}
	@RequestMapping("/view/updateCustomer.action")
	public String updateCustomer() {
		return "WEB-INF/views/updateCustomer";
	}
	@RequestMapping("/access/view/insertCustomer.action")
	public String insertCustomer() {
		return "WEB-INF/views/insertCustomer";
	}
	@RequestMapping("/view/getPic.action")
	public String getPic() {
		return "WEB-INF/views/GetPic";
	}
	@RequestMapping("/view/updateMarket.action")
	public String updateMarket() {
		return "WEB-INF/views/updateMarket";
	}
	@RequestMapping("/access/view/insertMarket.action")
	public String insertMarket() {
		return "WEB-INF/views/insertMarket";
	}
	@RequestMapping("/view/updateType.action")
	public String updateType() {
		return "WEB-INF/views/updateType";
	}
	@RequestMapping("/access/view/insertType.action")
	public String insertType(Type type) {
		return "WEB-INF/views/insertType";
	}
	@RequestMapping("view/visit.action")
	public String visit() {
		return "WEB-INF/views/visit";
	}
	@RequestMapping("/view/updateVisit.action")
	public String updateVisit() {
		return "WEB-INF/views/updateVisit";
	}
	@RequestMapping("/view/sales.action")
	public String sales() {
		return "WEB-INF/views/sales";
	}
	@RequestMapping("/access/view/Rvisit.action")
	public String Rvisit() {
		return "WEB-INF/views/Rvisit";
	}
	@RequestMapping("/view/Myinfo.action")
	public String Myinfo() {
		return "WEB-INF/views/Myinfo";
	}
	@RequestMapping("/view/updatepwd.action")
	public String updatepwd() {
		return "WEB-INF/views/updatepwd";
	}
	@RequestMapping("/view/insertvisit.action")
	public String insertvisit() {
		return "WEB-INF/views/insertVisit";
	}
	@RequestMapping("view/rv.action")
	public String rv() {
		return "WEB-INF/views/rv";
	}
	
	@RequestMapping("/view/index.action")
	public String index() {
		return "/WEB-INF/views/index";
	}
	
	@RequestMapping("/view/logout.action")
	public String logout(HttpSession session) {
		session.removeAttribute("staff");
		return"redirect:../login.jsp" ;
	} 
	
	@RequestMapping("/view/getmenu.action")
	@ResponseBody
	public	List<Menu> getmenu(HttpSession session){
		
		Staff staff = (Staff) session.getAttribute("staff");
		List<Menu> menus = iMenuService.getmenu(staff.getRoleid());
		return menus;
	}
	
	
	@RequestMapping("/view/getrole.action")
	@ResponseBody
	public List<Role> getrole(){
		
		List<Role> roles = iRoleService.getrole();
		return roles;
	}
	
	
	@RequestMapping("/view/getstaffBysleader.action")
	@ResponseBody
	public List<Staff> getsleader(String sid_leader){
		
		List<Staff> staffs = iStaffService.getstaffByRoleid(sid_leader);
		
		return staffs;
	}
	
	@RequestMapping("/view/getByroleid.action")
	@ResponseBody
	public List<Staff> getByroleid(Integer roleid, HttpSession session){
		
		List<Staff> staffs = iStaffService.getByroleid(roleid);
		return staffs;
	}
	
	@RequestMapping("/view/gettype.action")
	@ResponseBody
	public List<Type> gettype(){
		List<Type> types = iTypeService.gettype();
		return types;
	}
	
	@RequestMapping("/view/getproductByPid.action")
	@ResponseBody
	public List<Product> getproductByPid(String pid){
		List<Product> products = iProductService.getproductByPid(pid);
		return products;
	}
	
	@RequestMapping("/view/getAllproduct.action")
	@ResponseBody
	public List<Product> getAllproduct(String ptype){
		List<Product> products = iProductService.getAllproduct(ptype);
		return products;
	}
	
	@RequestMapping("/view/gettent.action")
	@ResponseBody
	public List<Intentionstate> gettent(String iid){
		List<Intentionstate> intentionstates = itetService.gettent(iid);
		return intentionstates;
	}
	
	@RequestMapping("/view/getvisitstate.action")
	@ResponseBody
	public List<Visitstate> getvisitstate(){
		List<Visitstate> visitstates = iVisitService.getvisitstate();
		return visitstates;
	}
	
	@RequestMapping("/view/getstaff.action")
	@ResponseBody
	public List<Staff> getstaff(){
		List<Staff> staffs = iStaffService.getstaff();
		return staffs;
	}
	
	@RequestMapping("/view/AllPic.action")
	@ResponseBody
	public List<Pic> selectPic(String pid){
		List<Pic> pics = iPicService.getPic(pid);
		return pics;
	}
	
	@RequestMapping("/view/ManyPic.action")
	@ResponseBody
	public PicRes ManyPic(String pid){
		
		 /* System.out.println(pid);*/
		  PicRes picRes=new PicRes();
		  List<Pic> pics = iPicService.ManyPic(pid);
		  List<Map<String, Object>> list2=new ArrayList<>();
		  for (Pic pic : pics) {
			Map<String,Object> map=new HashMap<>();
			map.put("alt","");
			map.put("pid",pic.getPicid());
			map.put("src", pic.getPurl());
			map.put("thumb","");
			list2.add(map);
		}
		  picRes.setTitle("");
		  picRes.setId(1);
		  picRes.setStart(0);
		  picRes.setData(list2);
		  return picRes;
	}
	
	@RequestMapping("/view/getCustomer.action")
	@ResponseBody
	public List<Customer> getCustomer() {
		List<Customer> customers = iCustomerService.getCustomer();
		
		return customers;
	}
	
	@RequestMapping("view/getMessInfo.action")
	@ResponseBody
	public List<MessInfo> getMessInfo(HttpSession session) {
		
		Staff staff = (Staff) session.getAttribute("staff");
		List<MessInfo> messInfos = iMessInfoService.getMessInfo(staff.getSid());
		
		return messInfos;
	}
	
	@RequestMapping("/view/Pwd.action")
	@ResponseBody
	public Resbody updatePwd(Staff staff,String spwd,String pwd1,String pwd2,HttpSession session) {
		
		Resbody resbody = new Resbody();
		
		Staff staff2 = (Staff) session.getAttribute("staff");
		
		staff.setSpassword(staff2.getSpassword());
		int res = iStaffService.updatePwd(staff,spwd,pwd1,pwd2);

		if(res==-100){
			resbody.setCode(-1);
			resbody.setMsg("¡Ω¥Œ–¬√‹¬Î ß∞‹");
		}else if(res==-200){
			resbody.setCode(-2);
			resbody.setMsg("æ…√‹¬Î¥ÌŒÛ");
		}else {
			resbody.setCode(0);
			session.removeAttribute("staff");
		}
		
		return resbody;
	}
	
	
}
