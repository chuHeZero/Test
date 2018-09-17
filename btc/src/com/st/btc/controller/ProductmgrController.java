package com.st.btc.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.st.btc.pojo.Ftype;
import com.st.btc.pojo.Product;
import com.st.btc.service.IProductService;
import com.st.btc.util.Page;

//管理员管理产品的Controller
@Controller
public class ProductmgrController {

	@Autowired
	IProductService iProductService;
	
	@RequestMapping("/Manager/productmgr.action")
	public String productmgr() {
		
		return "WEB-INF/Manager/productmgr";
	}
	
	@RequestMapping("/Manager/Aaddproduct.action")
	public String addproduct() {
		return "/WEB-INF/Manager/addproduct";
	}
	
	@RequestMapping("/Manager/updateinfo.action")
	public String updateinfo() {
		
		return "WEB-INF/Manager/updateinfo";
	}
	
	@RequestMapping("/Manager/fstypeall.action")
	public String fstypeall() {
		
		return "WEB-INF/Manager/fstype";
	}
	
	@RequestMapping("/Manager/updatetype.action")
	public String updatetype() {
		
		return "WEB-INF/Manager/updatetype";
	}
	
	@RequestMapping("/Manager/sfadd.action")
	public String addfs() {
		
		return "WEB-INF/Manager/addfs";
	}
	
	
	
	@RequestMapping("/Manager/addproduct.action")
	public ModelAndView addproduct(Product product, MultipartFile pic, HttpServletRequest request ) {
		
		if(pic.getSize()>0) {
		//文件保存位置
		String savepath = request.getSession().getServletContext().getRealPath("upload");
		
		String fileName = pic.getOriginalFilename();
		String subfix = fileName.substring(fileName.lastIndexOf("."));
		String saveFile = new Date().getTime() + subfix;
		
		
		//文件如何保存
		InputStream inputStream = null;
		OutputStream outputStream = null;
		try {
			inputStream = pic.getInputStream();
			outputStream = new FileOutputStream(savepath+"/"+saveFile);
			
			IOUtils.copy(inputStream, outputStream);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if (inputStream != null) {
				try {
					inputStream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (outputStream != null) {
				try {
					outputStream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		//文件名写入文件中
		product.setPpic(saveFile);
		}
		//调用service层
		 int res = iProductService.addproduct(product);
		ModelAndView mv = new ModelAndView();
		
		if (res>0) {
			mv.setViewName("WEB-INF/Manager/productmgr");
		}else {
			mv.setViewName("redirect:addproduct.action?error=添加失败");
		}
		
		return mv;
	}
	
	@RequestMapping("/Manager/selectAll.action")
	@ResponseBody	//将方法的返回对象，通过Jackson封装成JSON格式的字符串，返回给客户端
	public Page selsctAll(Product product, Page page) {
		
		System.out.println(page.getCurpage());
		
		Page respage = iProductService.selectAll(product,page);

		return respage;
	}
	
	@RequestMapping("/Manager/updateproduct.action")
	public ModelAndView updetepc(Product product,Integer pid, MultipartFile pic, HttpServletRequest request ) {
		
		product.setPid(pid);
		if(pic.getSize()>0) {
			
		
		//文件保存位置
		String savepath = request.getSession().getServletContext().getRealPath("upload");
		
		String fileName = pic.getOriginalFilename();
		System.out.println(fileName);
		String subfix = fileName.substring(fileName.lastIndexOf("."));
		String saveFile = new Date().getTime() + subfix;
		
		
		//文件如何保存
		InputStream inputStream = null;
		OutputStream outputStream = null;
		try {
			inputStream = pic.getInputStream();
			outputStream = new FileOutputStream(savepath+"/"+saveFile);
			
			IOUtils.copy(inputStream, outputStream);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if (inputStream != null) {
				try {
					inputStream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (outputStream != null) {
				try {
					outputStream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		//文件名写入文件中
		product.setPpic(saveFile);
		}
		//调用service层
		 int res = iProductService.updatepc(product);
		ModelAndView mv = new ModelAndView();
		
		if (res>0) {
			mv.setViewName("WEB-INF/Manager/productmgr");
		}else {
			mv.setViewName("redirect:updateinfo.action?error=修改失败");
		}
		
		return mv;
	}
	@RequestMapping("Manager/removepc.action")
	public ModelAndView removepc(Product product,Integer pstatus) {
		
		product.setPstatus(pstatus);
		
		ModelAndView mv = new ModelAndView();
		
		int res = iProductService.removepc(product);
		if (res>0) {
			mv.setViewName("WEB-INF/Manager/productmgr");
		}else {
			mv.setViewName("redirect:removeproduct.action?error=修改失败");
		}
		
		return mv;
	}
	
	@RequestMapping("Manager/ftype.action")
	@ResponseBody
	public Page fstype(Ftype ftype,Page page) {
		
		
		Page respage = iProductService.fstype(ftype,page);

		return respage;
	}
	
	@RequestMapping("Manager/fsupdate.action")
	public ModelAndView updatefs(Ftype ftype,Integer tid) {
		
		ftype.setTid(tid);
		System.out.println(ftype.getPtid());
		
		ModelAndView mv = new  ModelAndView();
		
		int res = iProductService.updatefs(ftype);
		
		if (res>0) {
			mv.setViewName("WEB-INF/Manager/fstype");
		}else {
			mv.setViewName("redirect:updatetype.action?error=修改失败");
		}
		
		return mv;
	}
	
	@RequestMapping("/Manager/fsremove.action")
	public ModelAndView removefs(Ftype ftype,Integer tid) {
		
		ftype.setTid(tid);
		
		ModelAndView mv = new ModelAndView();
		 int res =  iProductService.removefs(ftype);
		 
		 if (res>0) {
			 mv.setViewName("WEB-INF/Manager/fstype");
		}else {
			mv.setViewName("redirect:updatetype.action?error=删除失败");
		}
		return mv;
	}
	
	@RequestMapping("Manager/typeadd.action")
	public ModelAndView addtype(Ftype ftype) {
		
		ModelAndView mv = new ModelAndView();
		
		int res = iProductService.addtype(ftype);
		if (res==-100) {
			mv.setViewName("redirect:sfadd.action?error=分类名不能为空");
		}else if (res>0) {
			mv.setViewName("WEB-INF/Manager/fstype");
		}else {
			mv.setViewName("redirect:sfadd.action?error=添加失败");
		}
		
		return mv;
		
	}
	
	
	

}
