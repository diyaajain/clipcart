package edu.cas.dto;


public class Product {
	private int product_id;
	private String product_name;
	private String product_price;
	private String product_quantity;	
	private int order_quantity;
	private String product_image_stringbase64;

	public String getProduct_image_stringbase64() {
		return product_image_stringbase64;
	}

	public void setProduct_image_stringbase64(String product_image_stringbase64) {
		this.product_image_stringbase64 = product_image_stringbase64;
	}

	public int getOrder_quantity() {
		return order_quantity;
	}

	public void setOrder_quantity(int order_quantity) {
		this.order_quantity = order_quantity;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}




	public String getProduct_name() {
		return product_name;
	}




	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}




	public String getProduct_price() {
		return product_price;
	}




	public void setProduct_price(String product_price) {
		this.product_price = product_price;
	}




	public String getProduct_quantity() {
		return product_quantity;
	}




	public void setProduct_quantity(String product_quantity) {
		this.product_quantity = product_quantity;
	}


	@Override
	public String toString() {
		return "Product [product_id=" + product_id + ", product_name=" + product_name + ", product_price=" + product_price + ", product_quantity=" + product_quantity + "]";
	}

	
}