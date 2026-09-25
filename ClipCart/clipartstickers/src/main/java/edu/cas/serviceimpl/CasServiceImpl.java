package edu.cas.serviceimpl;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.cas.dao.CasDao;
import edu.cas.dto.Product;
import edu.cas.dto.User;
import edu.cas.services.CasService;
import edu.cas.dto.Order;

@Service
public class CasServiceImpl implements CasService{
	
	@Autowired
	private CasDao casdao;

	@Override
	public String  addUser(User user) {
		return casdao.addUser(user);
		
	};

	@Override
	public String loginSubmit(User user) {
		return casdao.loginSubmit(user);

	}
	
	@Override
	public ArrayList<Product> getProducts(String roleid){
		return casdao.getProducts(roleid);
	}
	
	@Override
	public User getUser(String userid){
		return casdao.getUser(userid);
	}
	
	@Override
	public String saveUser(User user) {
		return casdao.saveUser(user);
	};
	
	@Override
	public Order createOrder(String userid, String productid, String orderqty, String totalprice, String orderprice) {
		return casdao.createOrder(userid, productid, orderqty, totalprice, orderprice);
	};
	
	@Override
	public ArrayList<Order> getOrderHistory(String userid, String roleid){
		return casdao.getOrderHistory(userid, roleid);
	};
	
	@Override
	public ArrayList<Order> updateOrder(String userid, String orderid, String ordersatus) {
		return casdao.updateOrder(userid, orderid, ordersatus);
	};
	
	@Override
	public int updateProductInventory(String action, String user_id, String product_id, String product_name, String product_quantity, String product_price) {
		return casdao.updateProductInventory( action,  user_id,  product_id,  product_name,  product_quantity,  product_price);
	};
	
	@Override
	public ArrayList<User> getUsers(){
		return casdao.getUsers();
	}
	
	@Override
	public int updateuser(String action, String firstname, String lastname, String address, String emailid, String userid, String roleid) {
		return casdao.updateuser( action,  firstname,  lastname,  address,  emailid,  userid, roleid);
	};
}
