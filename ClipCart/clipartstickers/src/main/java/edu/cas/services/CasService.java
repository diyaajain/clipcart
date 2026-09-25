package edu.cas.services;

import java.util.ArrayList;

import edu.cas.dto.Order;
import edu.cas.dto.Product;
import edu.cas.dto.User;

public interface CasService{

	public String addUser(User user);

	public String loginSubmit(User user);

	public ArrayList<Product> getProducts(String roleid);

	public User getUser(String userid);

	public String saveUser(User user);

	public Order createOrder(String userid, String productid, String orderqty, String totalprice, String orderprice);

	public ArrayList<Order> getOrderHistory(String userid, String roleid);

	public ArrayList<Order> updateOrder(String userid, String orderid, String orderstatus);

	public int updateProductInventory(String action, String user_id, String product_id, String product_name, String product_quantity, String product_price);

	public ArrayList<User> getUsers();

	public int updateuser(String action, String firstname, String lastname, String address, String emailid, String userid, String roleid);
	
	
}