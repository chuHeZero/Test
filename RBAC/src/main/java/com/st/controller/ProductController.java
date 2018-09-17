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
		
		//����Ʒ�������ݿ�
		int res = iProductService.addProduct(product);
		
		if (res <= 0) {
			resbody.setCode(-1);
			resbody.setMsg("��Ʒ���ʧ��");
		} else {
			int res2 = iPicService.addBatch(pics, product.getPid());
			
			if (res2 <= 0) {
				resbody.setCode(-2);
				resbody.setMsg("ͼƬ���ʧ��");
			}else {
				resbody.setCode(0);
			}
			
			//����ӳɹ�����ͨ��webscoket������Ա������һ����Ϣ
			ScoketMessage msg = new ScoketMessage();
			msg.setMsg("��˾����һ����Ϊ["+product.getPname()+"������]");
			msgScoket.sendMsg(msg);
		}
		
		return resbody;
	}
	
	/*
	 * �ϴ��ļ�, 1. ��Ҫ����commons-fileuplad.jar, commons-io.jar 2.
	 * ��Ҫ��SpringMVC.xml�ļ�������ļ������������� 3.
	 */
	@RequestMapping("/uploadPic.action")
	public Resbody uploadPic(MultipartFile file, HttpServletRequest request) {
		// �ļ����浽����?
		String savePath = request.getSession().getServletContext().getRealPath("/upload");

		// �����ļ���
		String fileName = file.getOriginalFilename();
		String subfix = fileName.substring(fileName.lastIndexOf("."));
		String saveFile = UUID.randomUUID() + subfix;
		
		// �ļ���α���?
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
		resbody.setMsg("�ϴ��ɹ�");
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
			resbody.setMsg("��Ʒɾ��ʧ��");
		}else {
			int res2 = iPicService.deletePic(pid);
			if (res2 <= 0) {
				resbody.setCode(-2);
				resbody.setMsg("ͼƬɾ��ʧ��");
			}else {
				resbody.setCode(0);
			}
		}
		return resbody;
	}
	
	@RequestMapping("/getSalesCount.action")
	public List<Map<String, Object>> getSalesCount() {
		
		//�����Ʒ���Լ���������
		List<Map<String, Object>> list = iProductService.getSalesCount();
		
		return list;
	}
	//�޸�ͼƬ
	@RequestMapping("/updatePic.action")
	public Resbody updatePic(Integer pid,String[] pics) {
		
		Resbody resbody = new Resbody();
			
		//��ͼƬ�����ݿ�ɾ��
		int res = iPicService.deletePic(pid);
		
		if (res < 0) {
			resbody.setCode(-1);
			resbody.setMsg("ͼƬɾ��ʧ��");
		} else {
			int res2 = iPicService.addBatch(pics, pid);
			
			if (res2 <= 0) {
				resbody.setCode(-2);
				resbody.setMsg("ͼƬ���ʧ��");
			}else {
				resbody.setCode(0);
			}
		}
		
		return resbody;
	}
}
