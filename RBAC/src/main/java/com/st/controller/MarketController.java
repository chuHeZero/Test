package com.st.controller;


import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.st.domain.Market;
import com.st.domain.MessInfo;
import com.st.domain.Product;
import com.st.domain.Resbody;
import com.st.domain.ScoketMessage;
import com.st.domain.Staff;
import com.st.domain.Util;
import com.st.service.IMarketService;
import com.st.service.IMessInfoService;
import com.st.service.IProductService;
import com.st.soket.MessageScoket;

@RestController
@RequestMapping("/Market")
public class MarketController {

	@Autowired
	private IMarketService iMarketService;
	
	@Autowired
	private IProductService iProductService;
	
	@Autowired
	private MessageScoket msgScoket;
	
	@Autowired
	private IMessInfoService iMessInfoService;
	
	@RequestMapping("/selectMarket.action")
	public Resbody selectMarket(Util util,Market market) {
		
		Integer start = (util.getPage()-1)*util.getLimit();
		util.setStart(start);
		List<Market> list = iMarketService.selectMarket(util,market);
		System.out.println(list);
		Integer count = iMarketService.getCount();
		Resbody resbody = new Resbody();
		resbody.setCode(0);
		resbody.setCount(count);
		resbody.setData(list);
		resbody.setMsg("");
		
		return resbody;
	}
	
	@RequestMapping("/updateMarket.action")
	public int updateMarket(Market market) {
		
		Integer res = iMarketService.updateMarket(market);
		
		return res;

	}
	
	@RequestMapping("insertMarket.action")
	public Resbody insertMarket(Market market,HttpSession session) throws IOException {
		
		Resbody resbody = new Resbody();
		
		
		int res2 = iProductService.updatePcount(market);
		if (res2<=0) {
			resbody.setCode(-1);
			resbody.setMsg("库存不足");
		}else {
			Integer res = iMarketService.insertMarket(market);
			if (res <= 0) {
				resbody.setCode(-2);
				resbody.setMsg("添加订单失败");
			}else {
				resbody.setCode(0);
			}
			//当员工卖出产品后通过webscoket向所有人发送一条消息
			ScoketMessage msg = new ScoketMessage();
			Staff staff = (Staff) session.getAttribute("staff");
			Product product = iProductService.OneProduct(market.getPid());
			String info = "刚刚["+staff.getSname()+"]卖出"+market.getMcount()+"台"+product.getPname();
			msg.setMsg(info);
			
			//先去查所有员工的sid
			
			//将信息写入数据库
			
			
			msgScoket.sendInfo(msg);
		}
		return resbody;
	}
	
	@RequestMapping("/deleteMarket.action")
	public int deleteMarket(Integer mid) {
		
		Integer res =  iMarketService.deleteMarket(mid);
		
		return res;
	}
}
