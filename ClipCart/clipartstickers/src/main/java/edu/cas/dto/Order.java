package edu.cas.dto;

import java.sql.Date;
import java.util.ArrayList;

public class Order {
	private int order_id;
	private String order_status;
	private String user_id;
	private String order_date;	
	private String ship_date;
	private String order_total;
	private ArrayList<OrderDetails> orderdetailslist = new ArrayList<OrderDetails>();
	private String user_name;

//for each table, need getter/setter for attributes to transfer between model(dao,controller) and view(jsp)

	public String getUser_name() {
		return user_name;
	}




	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}




	public ArrayList<OrderDetails> getOrderdetailslist() {
		return orderdetailslist;
	}




	public void setOrderdetailslist(ArrayList<OrderDetails> orderdetailslist) {
		this.orderdetailslist = orderdetailslist;
	}




	public String getOrder_total() {
		return order_total;
	}




	public void setOrder_total(String order_total) {
		this.order_total = order_total;
	}




	public int getOrder_id() {
		return order_id;
	}




	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}




	public String getOrder_status() {
		return order_status;
	}




	public void setOrder_status(String order_status) {
		this.order_status = order_status;
	}




	public String getUser_id() {
		return user_id;
	}




	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}




	public String getOrder_date() {
		return order_date;
	}




	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}




	public String getShip_date() {
		return ship_date;
	}




	public void setShip_date(String ship_date) {
		this.ship_date = ship_date;
	}



	@Override
	public String toString() {
		return "Order [order_id=" + order_id + ", order_status=" + order_status + ", user_id=" + user_id + ", order_date=" + order_date  + ", ship_date=" + ship_date + "]";
	}





	
}