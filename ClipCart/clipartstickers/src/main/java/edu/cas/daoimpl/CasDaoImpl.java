package edu.cas.daoimpl;

import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.annotation.PostConstruct;
import javax.sql.DataSource;
import javax.sql.RowSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import edu.cas.dao.CasDao;
import edu.cas.dto.Order;
import edu.cas.dto.OrderDetails;
import edu.cas.dto.Product;
import edu.cas.dto.User;

@Repository
public class CasDaoImpl extends JdbcDaoSupport implements CasDao{
	
	@Autowired
	DataSource datasource;
	
	@PostConstruct
	private void initialize() {
		setDataSource(datasource);
	}

	//Add user upon registration. Username must be unique.
	@Override
	public  String addUser(User user) {
		// TODO Auto-generated method stub
		
		//System.out.println(user.toString());
		//Check User Name Exists
		String sql = "select * from cass.user where user_name=?";
		SqlRowSet rs =  getJdbcTemplate().queryForRowSet(sql, new Object[] {user.getUser_name()});
		
		if(rs.next()) {
			System.out.println("User exist");
			 return "User Name already exists";
		}else {
			System.out.println("User does not exist");
			sql = "INSERT INTO cass.user (user_id,user_roleid, user_name, user_password, user_firstname, user_lastname, user_address, user_emailid) "
					+ "values (nextval('cass.user_id'),?,?,?,?,?,?,?) ";
			int iupdcnt = getJdbcTemplate().update(sql, new Object[] {
				user.getUser_roleid(), user.getUser_name(), user.getUser_password(), user.getUser_firstname(), user.getUser_lastname(), user.getUser_address(), user.getUser_emailid()	
			});
			
			return "Success";
		}
	};
		
		//When the user logs in, check if the user exists and credentials match. 
		@Override
		public  String loginSubmit(User user) {
			// TODO Auto-generated method stub
			
			//System.out.println(user.toString());
			//Check User Name Exists
			String sql = "select * from cass.user, cass.role  where user_name=? and cass.user.user_roleid = cass.role.role_id";
			SqlRowSet rs =  getJdbcTemplate().queryForRowSet(sql, new Object[] {user.getUser_name()});
			
			if(rs.next()) {
				System.out.println("User Login");
				String password = rs.getString("user_password");
				if(user.getUser_password().equals(password)) {
					user.setUser_id(rs.getInt("user_id"));
					user.setUser_roleid(rs.getInt("user_roleid"));
					user.setUser_firstname(rs.getString("user_firstname"));
					user.setUser_lastname(rs.getString("user_lastname"));
					user.setUser_address(rs.getString("user_address"));
					user.setUser_emailid(rs.getString("user_emailid"));
					user.setUser_rolename(rs.getString("role_name"));
					return "Success";
				}else {
					return "User credentials do not match";
				}
			}else {
				System.out.println("User does not exist");			
				return "User does not exist";
			}
	};

	//Get products. For users, only show if the available quantity > 0. Admins can see all products
	public ArrayList<Product> getProducts(String roleid){		
		ArrayList<Product> productlist = new ArrayList<Product>();
		String sql = "";
		if (roleid.equalsIgnoreCase("1")) {
			 sql = "select product_id, product_name, product_price, product_quantity, encode(product_image, 'base64') as product_image from cass.products order by product_id asc ";
		}else {
			 sql = "select product_id, product_name, product_price, product_quantity, encode(product_image, 'base64') as product_image from cass.products where product_quantity>0  order by product_id asc";
		}
		SqlRowSet rs =  getJdbcTemplate().queryForRowSet(sql);
		while(rs.next()) {
			Product product = new Product();
			product.setProduct_id(rs.getInt("product_id"));
			product.setProduct_name(rs.getString("product_name"));
			product.setProduct_price(rs.getString("product_price"));
			product.setProduct_quantity(rs.getString("product_quantity"));
			product.setOrder_quantity(0);
			product.setProduct_image_stringbase64(rs.getString("product_image"));
			productlist.add(product);
		}	
		return productlist;
	};	
	
	//Get user profile information
	@Override
	public  User getUser(String userid) {
		// TODO Auto-generated method stub
		User user = new User();
		int uid = 0;
		try { uid = Integer.parseInt(userid); }catch(Exception e) {}
		
		String sql = "select * from cass.user, cass.role  where user_id=? and cass.user.user_roleid = cass.role.role_id";
		SqlRowSet rs =  getJdbcTemplate().queryForRowSet(sql, new Object[] {uid});
		
		if(rs.next()) {
			System.out.println("get User");
			user.setUser_id(rs.getInt("user_id"));
			user.setUser_roleid(rs.getInt("user_roleid"));
			user.setUser_firstname(rs.getString("user_firstname"));
			user.setUser_lastname(rs.getString("user_lastname"));
			user.setUser_name(rs.getString("user_name"));
			user.setUser_address(rs.getString("user_address"));
			user.setUser_emailid(rs.getString("user_emailid"));		
			user.setUser_rolename(rs.getString("role_name"));
		}
		
		return user;
	};
	
	//Save the user's updated profile information
	@Override
	public  String saveUser(User user) {
		// TODO Auto-generated method stub

			System.out.println("User update ");
			String sql = "UPDATE cass.user set  user_roleid = ?, user_password = ?, user_firstname = ?, user_lastname = ?, user_address = ?, user_emailid = ?  where user_id = ? " ;
			int iupdcnt = getJdbcTemplate().update(sql, new Object[] {
				user.getUser_roleid(), user.getUser_password(), user.getUser_firstname(), user.getUser_lastname(), user.getUser_address(), user.getUser_emailid(), user.getUser_id()	
			});
			
			return "Success";
		
	};
	
	//User can create an order 
	public Order createOrder(String userid, String productid, String orderqty, String totalprice, String orderprice) {
		Order order = new Order();
		//System.out.println("createOrder " +  userid );
		//System.out.println("createOrder " + productid );
		//System.out.println("createOrder " + orderqty );
		//System.out.println("createOrder " + totalprice );
		
		
		String[] productarray = productid.split(","); 
		String[] orderqtyarray = orderqty.split(","); 
		String[] totalpricearray = totalprice.split(","); 
		String[] useridarray = userid.split(","); 
		int orderid = 0;
		
		//Get Order Sequence
		String sql = "select nextval('cass.order_id') orderid";
		SqlRowSet rs =  getJdbcTemplate().queryForRowSet(sql);
		
		if(rs.next()) {
			 orderid = rs.getInt("orderid");
		}
		
		//System.out.println("orderid " + orderid );
		
		order.setOrder_id(orderid);
		
		
		
		//Create Order
		sql = "INSERT INTO cass.orders (order_id, order_status, user_id, order_date, order_total) "
				+ "values (?,?,?,current_timestamp,?) ";
		int iupdcnt = getJdbcTemplate().update(sql, new Object[] {
			orderid, "Created", Integer.parseInt(useridarray[0]), Float.parseFloat(orderprice)
		});
		
		sql = "select user_firstname, user_lastname, order_status,  to_char(order_date, 'mm/dd/yyyy hh24:mi:ss') as order_date,  to_char(ship_date, 'mm/dd/yyyy hh24:mi:ss') as ship_date, order_total from cass.orders , cass.user where cass.orders.order_id = ? and cass.orders.user_id = cass.user.user_id";
		rs =  getJdbcTemplate().queryForRowSet(sql, new Object[] {
			orderid
		});
		while(rs.next()) {
			order.setOrder_status(rs.getString("order_status"));	
			order.setOrder_date(rs.getString("order_date"));
			order.setShip_date(rs.getString("ship_date"));
			order.setOrder_total(rs.getString("order_total"));
			order.setUser_name(rs.getString("user_firstname") + ", " + rs.getString("user_lastname"));
		}	
		//Create Order details		
		ArrayList<OrderDetails> orderdetailslist = new ArrayList<OrderDetails>();
		
		  Connection conn = null;
		  try {
			   conn = getJdbcTemplate().getDataSource().getConnection();
		  	   for( int i = 0; i <= productarray.length - 1; i++)
				{
				   if (Integer.parseInt(orderqtyarray[i]) > 0) {
						sql = "INSERT INTO cass.order_details (order_details_id, order_id, product_id, order_quantity, total_price) "
								+ "values (nextval('cass.order_details_id'),?,?,?,?) ";
						iupdcnt = getJdbcTemplate().update(sql, new Object[] {
							orderid, Integer.parseInt(productarray[i]), Integer.parseInt(orderqtyarray[i]),  Float.parseFloat(totalpricearray[i])
						});
						
						//call stored procedure to update product inventory based on the order quantity
						PreparedStatement stmt = conn.prepareStatement("call cass.update_product_inventory(?,?)");
				         stmt.setInt(1,Integer.parseInt(orderqtyarray[i]));
				         stmt.setInt(2,Integer.parseInt(productarray[i]));
				         stmt.execute();
				         stmt.close();
				   }
		   
	            }
		    }
	        catch(Exception err)
	        {
	           System.out.println("An error has occurred.");
	           System.out.println("See full details below.");
	           err.printStackTrace();
	        }finally {
	        	try {
					if (conn != null) {
						conn.close();
						conn = null;
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					//e.printStackTrace();
				}
	        }
			
		
		
		sql = "select product_name, order_quantity, total_price, encode(product_image, 'base64') as product_image  from cass.order_details , cass.products where  order_id = ? and cass.order_details.product_id = cass.products.product_id";
		rs =  getJdbcTemplate().queryForRowSet(sql, new Object[] {
			orderid
		});
		while(rs.next()) {
			OrderDetails orderdetails = new OrderDetails();
			orderdetails.setProduct_name(rs.getString("product_name"));	
			orderdetails.setOrder_quantity(rs.getString("order_quantity"));
			orderdetails.setTotal_price(rs.getString("total_price"));
			orderdetails.setProduct_image_stringbase64(rs.getString("product_image"));
			orderdetailslist.add(orderdetails);
		}	
		order.setOrderdetailslist(orderdetailslist);
		
		return order;		
	};	
	
	//get user's order history 
	public ArrayList<Order> getOrderHistory(String userid, String roleid){
		ArrayList<Order> orders = new ArrayList<Order>();
		
		String sql = "";
		SqlRowSet rs = null;
		
		if (roleid.equalsIgnoreCase("2")) {
				sql = "select user_firstname, user_lastname, order_id , order_status,  to_char(order_date, 'mm/dd/yyyy hh24:mi:ss') as order_date ,  to_char(ship_date, 'mm/dd/yyyy hh24:mi:ss') as ship_date, order_total from cass.orders, cass.user where cass.orders.user_id = ? and cass.orders.user_id = cass.user.user_id order by order_id desc";
				 rs =  getJdbcTemplate().queryForRowSet(sql, new Object[] {
						Integer.parseInt(userid)
				});
		}else {
			  	sql = "select user_firstname, user_lastname, order_id , order_status,  to_char(order_date, 'mm/dd/yyyy hh24:mi:ss') as order_date ,  to_char(ship_date, 'mm/dd/yyyy hh24:mi:ss') as ship_date, order_total from cass.orders, cass.user where cass.orders.user_id = cass.user.user_id order by order_id desc";	
			  	 rs =  getJdbcTemplate().queryForRowSet(sql);
		}
		
		//for every order returned from the sql query, get the details
		while(rs.next()) {
			Order order = new Order();
			order.setOrder_id(rs.getInt("order_id"));
			order.setOrder_status(rs.getString("order_status"));	
			order.setOrder_date(rs.getString("order_date"));
			order.setShip_date(rs.getString("ship_date"));
			order.setOrder_total(rs.getString("order_total"));
			order.setUser_name(rs.getString("user_firstname") + ", " + rs.getString("user_lastname"));
			
			ArrayList<OrderDetails> orderdetailslist = new ArrayList<OrderDetails>();
			String sql1 = "select product_name, order_quantity, total_price, encode(product_image, 'base64') as product_image from cass.order_details , cass.products where  order_id = ? and cass.order_details.product_id = cass.products.product_id";
			SqlRowSet rs1 =  getJdbcTemplate().queryForRowSet(sql1, new Object[] {
				order.getOrder_id()
			});
			while(rs1.next()) {
				OrderDetails orderdetails = new OrderDetails();
				orderdetails.setProduct_name(rs1.getString("product_name"));	
				orderdetails.setOrder_quantity(rs1.getString("order_quantity"));
				orderdetails.setTotal_price(rs1.getString("total_price"));
				orderdetails.setProduct_image_stringbase64(rs1.getString("product_image"));
				orderdetailslist.add(orderdetails);
			}	
			
			order.setOrderdetailslist(orderdetailslist);
			orders.add(order);
		}	
		
		return orders;
	}
	
	//admin can update order status. Doing so updates the ship date with the system time stamp. 
	public ArrayList<Order> updateOrder(String userid, String orderid, String orderstatus) {
		
		System.out.println("updateOrder " +  userid ); // admin userid
		System.out.println("updateOrder " + orderid );
		System.out.println("updateOrder " + orderstatus );
		String sql = "";
		SqlRowSet rs =  null;

		//update Order
		if (orderstatus.equalsIgnoreCase("Shipped") || orderstatus.equalsIgnoreCase("Delivered")) {
		     sql = "Update  cass.orders  set order_status= ? , ship_date = current_timestamp  where order_id = ? ";
		}else{
			 sql = "Update  cass.orders  set order_status= ? , ship_date = null  where order_id = ? ";
		}
		int iupdcnt = getJdbcTemplate().update(sql, new Object[] {
				orderstatus, Integer.parseInt(orderid)
		});
		
		if (iupdcnt > 0 && orderstatus.equalsIgnoreCase("Canceled") ) {
			Connection conn = null;
			try {
				conn = getJdbcTemplate().getDataSource().getConnection();
				//call procedure to increase the product quantity for canceled order				
				PreparedStatement stmt = conn.prepareStatement("call cass.update_product_inventory_by_orderid(?)");
				 stmt.setInt(1,Integer.parseInt(orderid));
				 stmt.execute();
				 stmt.close();
			} catch(Exception err)
	        {
	           System.out.println("An error has occurred.");
	           err.printStackTrace();
	        }finally {
	        	try {
					if (conn != null) {
						conn.close();
						conn = null;
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					//e.printStackTrace();
				}
	        }
		}
		
		
        ArrayList<Order> orders = new ArrayList<Order>();

	    sql = "select user_firstname, user_lastname, order_id , order_status,  to_char(order_date, 'mm/dd/yyyy hh24:mi:ss') as order_date ,  to_char(ship_date, 'mm/dd/yyyy hh24:mi:ss') as ship_date, order_total from cass.orders, cass.user where cass.orders.user_id = cass.user.user_id order by order_id desc";	
	    rs =  getJdbcTemplate().queryForRowSet(sql);
		
		
		
		while(rs.next()) {
			Order order = new Order();
			order.setOrder_id(rs.getInt("order_id"));
			order.setOrder_status(rs.getString("order_status"));	
			order.setOrder_date(rs.getString("order_date"));
			order.setShip_date(rs.getString("ship_date"));
			order.setOrder_total(rs.getString("order_total"));
			order.setUser_name(rs.getString("user_firstname") + ", " + rs.getString("user_lastname"));
			
			ArrayList<OrderDetails> orderdetailslist = new ArrayList<OrderDetails>();
			String sql1 = "select product_name, order_quantity, total_price, encode(product_image, 'base64') as product_image from cass.order_details , cass.products where  order_id = ? and cass.order_details.product_id = cass.products.product_id";
			SqlRowSet rs1 =  getJdbcTemplate().queryForRowSet(sql1, new Object[] {
				order.getOrder_id()
			});
			while(rs1.next()) {
				OrderDetails orderdetails = new OrderDetails();
				orderdetails.setProduct_name(rs1.getString("product_name"));	
				orderdetails.setOrder_quantity(rs1.getString("order_quantity"));
				orderdetails.setTotal_price(rs1.getString("total_price"));
				orderdetails.setProduct_image_stringbase64(rs1.getString("product_image"));
				orderdetailslist.add(orderdetails);
			}	
			
			order.setOrderdetailslist(orderdetailslist);
			orders.add(order);
		}	
		
		
		return orders;		
	};
	
	//admin can add/delete/update products 
	@Override
	public  int updateProductInventory(String action, String user_id, String product_id, String product_name, String product_quantity, String product_price) {
		    // TODO Auto-generated method stub
		    int rcnt = 0;
		    String sql = "";

		    if (action != null && action.equalsIgnoreCase("Delete") && Integer.parseInt(product_id) > 4) {
		    	System.out.println(" Delete product ");
		    	sql = "Delete from cass.products where product_id = ? " ;
		    	rcnt = getJdbcTemplate().update(sql, new Object[] {
		    			Integer.parseInt(product_id)
				});
		    }else if (action != null && action.equalsIgnoreCase("Update") ) {
		    	System.out.println(" Update product ");
		    	sql = "UPDATE cass.products set product_name = ?, product_quantity = ?, product_price = ? where product_id = ? " ;
		    	rcnt = getJdbcTemplate().update(sql, new Object[] {
		    			product_name, Integer.parseInt(product_quantity), Float.parseFloat(product_price), Integer.parseInt(product_id)
				});
		    }else if (action != null && action.equalsIgnoreCase("Add") ) {
		    	System.out.println(" Add product ");
		    	sql = "Insert into cass.products (product_id, product_name , product_quantity , product_price) values (nextval('cass.product_id') , ?, ?, ?) " ;
		    	rcnt = getJdbcTemplate().update(sql, new Object[] {
		    			product_name, Integer.parseInt(product_quantity), Float.parseFloat(product_price)
				});
		    }
			
			
			
			return rcnt;
		
	};
	
	//The admin can see all the details of all users
	public ArrayList<User> getUsers(){		
		ArrayList<User> userslist = new ArrayList<User>();
		String sql = "";
	    sql = "select * from cass.user order by user_id asc ";
		
		SqlRowSet rs =  getJdbcTemplate().queryForRowSet(sql);
		while(rs.next()) {
			User user = new User();
			user.setUser_id(rs.getInt("user_id"));
			user.setUser_roleid(rs.getInt("user_roleid"));
			user.setUser_name(rs.getString("user_name"));
			user.setUser_firstname(rs.getString("user_firstname"));
			user.setUser_lastname(rs.getString("user_lastname"));
			user.setUser_address(rs.getString("user_address"));
			user.setUser_emailid(rs.getString("user_emailid"));
		
			userslist.add(user);
		}	
		return userslist;
	};	
	
	//The admin can update user profile details (except for the username/password). They cannot delete the default admin record.
	@Override
	public  int updateuser(String action, String firstname, String lastname, String address, String emailid, String userid, String roleid) {
		    // TODO Auto-generated method stub
		    int rcnt = 0;
		    String sql = "";

		    if (action != null && action.equalsIgnoreCase("Delete") && Integer.parseInt(userid) > 1) {
		    	System.out.println(" Delete user ");
		    	sql = "Delete from cass.user where user_id = ? " ;
		    	rcnt = getJdbcTemplate().update(sql, new Object[] {
		    			Integer.parseInt(userid)
				});
		    }else if (action != null && action.equalsIgnoreCase("Update") ) {
		    	System.out.println(" Update user ");
		    	sql = "UPDATE cass.user set user_firstname = ?, user_lastname = ?,  user_address = ? , user_emailid = ?,  user_roleid = ?  where user_id = ? " ;
		    	rcnt = getJdbcTemplate().update(sql, new Object[] {
		    			firstname, lastname, address, emailid,  Integer.parseInt(roleid),  Integer.parseInt(userid)
				});
		    }
			
			
			
			return rcnt;
		
	};
}