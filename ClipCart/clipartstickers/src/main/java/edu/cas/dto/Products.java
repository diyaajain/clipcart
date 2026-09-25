package edu.cas.dto;

import java.util.ArrayList;
import edu.cas.dto.Product;

public class Products {
	private ArrayList<Product> products = new ArrayList<Product>();

	public ArrayList<Product> getProducts() {
		return products;
	}

	public void setProducts(ArrayList<Product> products) {
		this.products = products;
	}

}