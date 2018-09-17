package com.st.task;

import java.util.Properties;

import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * 发送邮件的定时任务
 * 
 *   @controller   定义springMVC的控制器
 *   @Service     定义服务器的类
 *   @Component  定义组件
 *   @Repository 定义dao层类
 * 
 * 	这些注解的本质是一样的，将注解的类，作为Bean加入到spring容器中
 * 
 */
@Component
public class EmailTask {
	/*@Scheduled(cron="* *  * * * *")
	public void sendEmail() {
		
		System.out.println("发送邮件");
		
		// 统计销售信息
		
		// 将销售信息, 生成HTML
		// 表格
		// 
		
		// 发送邮件
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.qq.com");// 指定邮件的发送服务器地址  参数1
		props.put("mail.smtp.auth", "true");//服务器是否要验证用户的身份信息
		
		Session session = Session.getInstance(props);// 得到Session
		session.setDebug(true);// 代表启用debug模式，可以在控制台输出smtp协议应答的过程
		
       
		try {
			//创建一个MimeMessage格式的邮件
	        MimeMessage message = new MimeMessage(session);
	        MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"UTF-8"); // MimeMessageHelper-->spring的  不加后面两个参数会乱码  
	       
	        //设置发送者
	        messageHelper.setFrom("3188349488@qq.com");//设置发送的邮件地址
			
			//设置接收者
	        messageHelper.setTo("3031954452@qq.com");
	        
	        //设置邮件的主题
	        messageHelper.setSubject("xxxx");
	        //设置邮件的内容
	        messageHelper.setText("<h1>xxxx测试xxxx</h1>", true); // true表示内容中的HTML标签将会被解析
	        //保存邮件
	        //messageHelper.saveChanges();
	        
	        //得到发送邮件的服务器(这里用的是smtp服务器)
			Transport transport = session.getTransport("smtp");

			// 发送者的账号连接到smtp服务器上
			transport.connect("smtp.qq.com", "3188349488@qq.com", "ydrtwizejwradegd");
			// 发送信息
			transport.sendMessage(message, message.getAllRecipients());
			// 关闭服务器通道
			transport.close();
	        
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}*/

}
