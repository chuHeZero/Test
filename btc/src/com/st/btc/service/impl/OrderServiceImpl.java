package com.st.btc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.btc.dao.DetailsMapper;
import com.st.btc.dao.OrderMapper;
import com.st.btc.dao.ProductMapper;
import com.st.btc.dao.UserMapper;
import com.st.btc.pojo.Details;
import com.st.btc.pojo.Order;
import com.st.btc.pojo.Product;
import com.st.btc.service.IOrderService;
@Service
public class OrderServiceImpl implements IOrderService {

	@Autowired
	ProductMapper productMapper;
	
	@Autowired
	UserMapper userMapper;
	
	@Autowired
	OrderMapper orderMapper;
	
	@Autowired
	DetailsMapper detailsMapper;
	
	@Override
	public int addorder(Order order) {
		
		Double oprice=0.0;
		//�����Ʒ �޸Ŀ��
		for(Details details:order.getList()) {
			
			
			try {
			//�޸�Details�Ŀ��
			productMapper.updatecount(details.getPid(), details.getPcount());
			
			//ȡ����Ʒ����ϸ��Ϣ
			Product product = productMapper.selectproduct(details.getPid());
			
			details.setPprice(product.getPprice());
			//�ڼ���һ�μ۸� �ܼ�Ǯ
			oprice += details.getPcount()*details.getPprice();
			}catch (Exception e) {
				//���ؿ�治��Ĵ�����Ϣ
				e.printStackTrace();
				throw new RuntimeException("��治��!��С�����ڼӼ�����,�����ĵȴ�");
			}
		}
		
		try {
		//��Ǯ
		int res =  userMapper.updatemoney(order.getUid(), oprice);
		}catch (Exception e) {
			//�����������Ϣ
			e.printStackTrace();
			throw new RuntimeException("����ʧ��,����Ҳ�Ѳ���!�뼰ʱ��ֵ!");
		}
		//д��order��
		order.setOprice(oprice);
		orderMapper.addorder(order);
		
		//д��details��
		for(Details details:order.getList()) {
			
			details.setOnum(order.getOnum());
			
			detailsMapper.adddetails(details);
		}
		
		
		return 1;
	}

	@Override
	public List<Order> selectByUId(Integer uid) {
		//��ѯ
		return orderMapper.selectByUId(uid);
	}

	@Override
	public List<Details> getorinfo(String onum) {
		// TODO Auto-generated method stub
		return orderMapper.getorinfo(onum);
	}

	@Override
	public List<Order> selectorder(String oname) {
		// TODO Auto-generated method stub
		return orderMapper.selectorder(oname);
	}

	@Override
	public List<Details> getmgrorinfo(String onum) {
		// TODO Auto-generated method stub
		return orderMapper.getmgrorinfo(onum);
	}


}
