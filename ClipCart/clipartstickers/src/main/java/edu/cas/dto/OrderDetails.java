package edu.cas.dto;

import java.sql.Date;

public class OrderDetails {
	private String order_details_id;
	private int order_id;
	private String product_id;
	private String order_quantity;
	private String total_price;
	private String product_name;
	private String product_image_stringbase64;


	public String getProduct_image_stringbase64() {
		return product_image_stringbase64;
	}




	public void setProduct_image_stringbase64(String product_image_stringbase64) {
		this.product_image_stringbase64 = product_image_stringbase64;
	}




	public String getProduct_name() {
		return product_name;
	}




	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}




	public String getTotal_price() {
		return total_price;
	}




	public void setTotal_price(String total_price) {
		this.total_price = total_price;
	}




	public String getOrder_details_id() {
		return order_details_id;
	}




	public void setOrder_details_id(String order_details_id) {
		this.order_details_id = order_details_id;
	}




	public int getOrder_id() {
		return order_id;
	}




	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}




	public String getProduct_id() {
		return product_id;
	}




	public void setProduct_id(String product_id) {
		this.product_id = product_id;
	}




	public String getOrder_quantity() {
		return order_quantity;
	}




	public void setOrder_quantity(String order_quantity) {
		this.order_quantity = order_quantity;
	}




	@Override
	public String toString() {
		return "Order Details [order_details_id=" + order_details_id + ", order_id=" + order_id + ", product_id=" + product_id + ", order_quantity=" + order_quantity  + "]";
	}

	
}