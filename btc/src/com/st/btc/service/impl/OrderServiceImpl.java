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
		//逐个商品 修改库存
		for(Details details:order.getList()) {
			
			
			try {
			//修改Details的库存
			productMapper.updatecount(details.getPid(), details.getPcount());
			
			//取出商品的详细信息
			Product product = productMapper.selectproduct(details.getPid());
			
			details.setPprice(product.getPprice());
			//在计算一次价格 总价钱
			oprice += details.getPcount()*details.getPprice();
			}catch (Exception e) {
				//返回库存不足的错误信息
				e.printStackTrace();
				throw new RuntimeException("库存不足!店小二正在加急备货,请耐心等待");
			}
		}
		
		try {
		//扣钱
		int res =  userMapper.updatemoney(order.getUid(), oprice);
		}catch (Exception e) {
			//返回余额不足的信息
			e.printStackTrace();
			throw new RuntimeException("购买失败,您的也已不足!请及时充值!");
		}
		//写入order表
		order.setOprice(oprice);
		orderMapper.addorder(order);
		
		//写入details表
		for(Details details:order.getList()) {
			
			details.setOnum(order.getOnum());
			
			detailsMapper.adddetails(details);
		}
		
		
		return 1;
	}

	@Override
	public List<Order> selectByUId(Integer uid) {
		//查询
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
