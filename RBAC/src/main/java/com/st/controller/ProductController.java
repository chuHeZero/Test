package com.st.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.st.domain.Pic;
import com.st.domain.Product;
import com.st.domain.Resbody;
import com.st.domain.ScoketMessage;
import com.st.domain.Util;
import com.st.service.IPicService;
import com.st.service.IProductService;
import com.st.soket.MessageScoket;

@RestController
@RequestMapping("/Product")
public class ProductController {

	@Autowired
	private IProductService iProductService;
	
	@Autowired
	private IPicService iPicService;
	
	@Autowired
	private MessageScoket msgScoket;
	
	@RequestMapping("/selectProduct.action")
	public Resbody selectProduct(Util util,Product product) {
		
		Integer start = (util.getPage()-1)*util.getLimit();
		util.setStart(start);
		List<Product> list = iProductService.selectProduct(util,product);
		Integer count = iProductService.getCount();
		Resbody resbody = new Resbody();
		resbody.setCode(0);
		resbody.setCount(count);
		resbody.setData(list);
		resbody.setMsg("");
		
		return resbody;
	}
	
	@RequestMapping("/getProduct.action")
	public List<Product> getProduct() {
		
		List<Product> products = iProductService.getProduct();
	
		return products;
	}
	
	@RequestMapping("/addProduct.action")
	public Resbody addProduct(Product product,String[] pics) throws IOException {
		
		Resbody resbody = new Resbody();
		
		//将产品插入数据库
		int res = iProductService.addProduct(product);
		
		if (res <= 0) {
			resbody.setCode(-1);
			resbody.setMsg("产品添加失败");
		} else {
			int res2 = iPicService.addBatch(pics, product.getPid());
			
			if (res2 <= 0) {
				resbody.setCode(-2);
				resbody.setMsg("图片添加失败");
			}else {
				resbody.setCode(0);
			}
			
			//当添加成功过后通过webscoket向所有员工发送一条消息
			ScoketMessage msg = new ScoketMessage();
			msg.setMsg("公司新上一款名为["+product.getPname()+"的汽车]");
			msgScoket.sendMsg(msg);
		}
		
		return resbody;
	}
	
	/*
	 * 上传文件, 1. 需要依赖commons-fileuplad.jar, commons-io.jar 2.
	 * 需要在SpringMVC.xml文件中添加文件解析器的设置 3.
	 */
	@RequestMapping("/uploadPic.action")
	public Resbody uploadPic(MultipartFile file, HttpServletRequest request) {
		// 文件保存到哪里?
		String savePath = request.getSession().getServletContext().getRealPath("/upload");

		// 保存文件名
		String fileName = file.getOriginalFilename();
		String subfix = fileName.substring(fileName.lastIndexOf("."));
		String saveFile = UUID.randomUUID() + subfix;
		
		// 文件如何保存?
		InputStream inputStream = null;
		OutputStream outputStream = null;
		try {
			inputStream = file.getInputStream();

			outputStream = new FileOutputStream(savePath + "/" + saveFile);

			IOUtils.copy(inputStream, outputStream);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
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
		
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Pic picRes = new Pic();
		picRes.setPurl("upload/"+saveFile);
		
		Resbody resbody = new Resbody();
		resbody.setCode(0);
		resbody.setMsg("上传成功");
		resbody.setData(picRes);

		return resbody;
	}

	
	@RequestMapping("/updateProduct.action")
	public int updateProduct(Product product) {
		
		Integer res = iProductService.updateProduct(product);
		
		return res;
	}
	@RequestMapping("/deleteProduct.action")
	public Resbody deleteProduct(Integer pid) {
		
		Resbody resbody = new Resbody();
		
		
		int res = iProductService.deleteProduct(pid);
		if (res<=0) {
			resbody.setCode(-1);
			resbody.setMsg("产品删除失败");
		}else {
			int res2 = iPicService.deletePic(pid);
			if (res2 <= 0) {
				resbody.setCode(-2);
				resbody.setMsg("图片删除失败");
			}else {
				resbody.setCode(0);
			}
		}
		return resbody;
	}
	
	@RequestMapping("/getSalesCount.action")
	public List<Map<String, Object>> getSalesCount() {
		
		//多个产品，以及销售数量
		List<Map<String, Object>> list = iProductService.getSalesCount();
		
		return list;
	}
	//修改图片
	@RequestMapping("/updatePic.action")
	public Resbody updatePic(Integer pid,String[] pics) {
		
		Resbody resbody = new Resbody();
			
		//将图片从数据库删除
		int res = iPicService.deletePic(pid);
		
		if (res < 0) {
			resbody.setCode(-1);
			resbody.setMsg("图片删除失败");
		} else {
			int res2 = iPicService.addBatch(pics, pid);
			
			if (res2 <= 0) {
				resbody.setCode(-2);
				resbody.setMsg("图片添加失败");
			}else {
				resbody.setCode(0);
			}
		}
		
		return resbody;
	}
}
