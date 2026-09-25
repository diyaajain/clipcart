package edu.cas.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import edu.cas.dto.Order;
import edu.cas.dto.Product;
import edu.cas.dto.User;
import edu.cas.services.CasService;

@Controller
public class CasController {
	
	@Autowired
	private CasService casservice;
	
	@RequestMapping("/")
	public String home() {
		System.out.println("Going home...");
		return "index";
	}
	
	//New user registration form 
	@GetMapping("/register")
	public String showForm(Model model) {
		User user = new User();
		user.setUser_roleid(2);
		model.addAttribute("user", user);
		
		return "register_form";
	}
	
	//If registration succeeds, redirects to success page. Otherwise, returns back to registration form.
	@PostMapping("/register")
	public String AddUser(Model model, @ModelAttribute("user") User user) {
		System.out.println(user.toString());
		
		String sreturn = casservice.addUser(user);
		System.out.println("sreturn: " + sreturn);
		if (!sreturn.equalsIgnoreCase("Success")) {	
			model.addAttribute("errMessage" , sreturn);
			return "register_form";
		}else return "register_success";
	}
	
	//shows login page
	@GetMapping("/login")
	public String loginForm(Model model) {
		User user = new User();
		model.addAttribute("user", user);
		
		return "login";
	}
	
	//upon successful login, redirects to welcome page. Otherwise, stay at login page.
	@PostMapping("/login")
	public String loginSubmit(Model model, @ModelAttribute("user") User user, HttpServletRequest request) {
		System.out.println(user.toString());
		
		String sreturn = casservice.loginSubmit(user);
		System.out.println("sreturn: " + sreturn);
		if (!sreturn.equalsIgnoreCase("Success")) {	
			model.addAttribute("errMessage" , sreturn);
			return "login";
		}else {
			 HttpSession session = request.getSession(true);
			 session.setAttribute("username", user.getUser_name());
			 
			return "welcome";
		}
	}
	
	//logout page. Go back to login screen.
	@GetMapping("/logout")
	public String logoutForm(Model model, HttpServletRequest request) {
		User user = new User();
		model.addAttribute("user", user);
		request.getSession().removeAttribute("username");
		request.getSession().invalidate();
		
		return "login";
	}
	
	//home page. If logged in, shows a welcome message to user.
	@RequestMapping(value = "/home", method = RequestMethod.POST)
	public String welcomeHome(Model model, @RequestParam("user_id") String userid) {
			
		if (userid != null && userid.trim().length() > 0) {
		System.out.println("userid: " + userid);
		User user = casservice.getUser(userid);
		model.addAttribute("user", user);
		}
		return "welcome";
	}
	
	//profile page. User can make adjustments to account details.
	@RequestMapping(value = "/profile", method = RequestMethod.POST)
	public String getUser(Model model, @RequestParam("user_id") String userid, HttpServletRequest request) {
			
	   if (request.getSession() != null && request.getSession().getAttribute("username") != null)	{
		System.out.println("userid: " + userid);
		User user = casservice.getUser(userid);
		model.addAttribute("user", user);
		return "profile";
	   } else {
		   User user = new User();
		   model.addAttribute("user", user);
		   return "login";
	   }
		
		
	}
	
	//shop page that displays available products to the user to order
	@RequestMapping(value = "/shop", method = RequestMethod.POST)
	public String getProducts(Model model, @RequestParam("user_id") String userid, @RequestParam("role_id") String roleid, HttpServletRequest request) {
		
		if (request.getSession() != null && request.getSession().getAttribute("username") != null)	{
			ArrayList<Product> products = casservice.getProducts(roleid);
			model.addAttribute("products", products);
			
			System.out.println("shop: " + userid);
			User user = casservice.getUser(userid);
			model.addAttribute("user", user);
			return "shop";
		} else {
			   User user = new User();
			   model.addAttribute("user", user);
			   return "login";
		}
		
	}
	
	//Profile page after user updates profile information
	@PostMapping("/saveuser")
	public String saveUser(Model model, @ModelAttribute("user") User user, HttpServletRequest request) {
		if (request.getSession() != null && request.getSession().getAttribute("username") != null)	{
			System.out.println(user.toString());		
			String sreturn = casservice.saveUser(user);
			System.out.println("sreturn: " + sreturn);
			if (!sreturn.equalsIgnoreCase("Success")) {	
				model.addAttribute("errMessage" , sreturn);
				model.addAttribute("user", user);
				return "profile";
			}else {
				model.addAttribute("successMessage" , "User profile saved successfully");
				model.addAttribute("user", user);
				return "profile";
			}
		}else {
			   user = new User();
			   model.addAttribute("user", user);
			   return "login";
		}
	}
	
	//Shop page where users complete their order confirmation
	@PostMapping("/order")
	public String AddOrder(Model model, @RequestParam("user_id") String userid, @RequestParam("product_id") String productid, @RequestParam("order_quantity") String orderqty, @RequestParam("totalprice") String totalprice, @RequestParam("orderprice") String orderprice, HttpServletRequest request) {
		//System.out.println( userid );
		//System.out.println( productid );
		//System.out.println( totalprice);	
		//System.out.println( orderqty);	
		//System.out.println( orderprice);	
		if (request.getSession() != null && request.getSession().getAttribute("username") != null)	{		
			Order order = casservice.createOrder(userid, productid, orderqty, totalprice, orderprice);
			model.addAttribute("successMessage" , "Order created successfully");
			model.addAttribute("order", order);
			model.addAttribute("orderdetails", order.getOrderdetailslist());
			
			String[] useridarray = userid.split(","); 
			
			User user = casservice.getUser(useridarray[0]);
			model.addAttribute("user", user);
			
			return "orderconfirmation";
		}else {
			   User user = new User();
			   model.addAttribute("user", user);
			   return "login";
		}	
		
		

	}
	
	//Order history page where users can see the details of all of their orders, and admins can see the order history of all users
	@RequestMapping(value = "/orderhistory", method = RequestMethod.POST)
	public String getOrderHistory(Model model, @RequestParam("user_id") String userid, @RequestParam("role_id") String roleid , HttpServletRequest request) {
		if (request.getSession() != null && request.getSession().getAttribute("username") != null)	{
			ArrayList<Order> orders = casservice.getOrderHistory(userid, roleid);
			model.addAttribute("orders", orders);
			
			User user = casservice.getUser(userid);
			model.addAttribute("user", user);
			
			
			 List<String> orderstatusList = Arrays.asList("Canceled", "Created", "Shipped", "Delivered"); 
			 model.addAttribute("orderstatusList", orderstatusList);
			 
			 return "orderhistory";
		}else {
			   User user = new User();
			   model.addAttribute("user", user);
			   return "login";
		}
		
		
		
	}
	
	//page after the admin updates order information 
	@PostMapping("/updateorder")
	public String UpdateOrder(Model model, @RequestParam("user_id") String userid, @RequestParam("order_id") String orderid, @RequestParam("order_status") String orderstatus , HttpServletRequest request) {
		//System.out.println( userid );
		//System.out.println( orderid );
		//System.out.println( orderstatus);
		if (request.getSession() != null && request.getSession().getAttribute("username") != null)	{	
			ArrayList<Order> orders = casservice.updateOrder(userid, orderid, orderstatus);
			model.addAttribute("successMessage" , "Order CAS# " + orderid + " updated successfully");
			model.addAttribute("orders", orders);
			
			
			User user = casservice.getUser(userid);
			model.addAttribute("user", user);
			return "orderhistory";
		}else {
			   User user = new User();
			   model.addAttribute("user", user);
			   return "login";
		}
	}
	
	//page where the admin can update the product inventory 
	@RequestMapping(value = "/productinventory", method = RequestMethod.POST)
	public String getProductInventory(Model model, @RequestParam("user_id") String userid, @RequestParam("role_id") String roleid , HttpServletRequest request) {
		
		if (request.getSession() != null && request.getSession().getAttribute("username") != null)	{		
			ArrayList<Product> products = casservice.getProducts(roleid);
			model.addAttribute("products", products);
			
			System.out.println("productinventory: " + userid);
			User user = casservice.getUser(userid);
			model.addAttribute("user", user);
			
			return "productinventory";
		}else {
			   User user = new User();
			   model.addAttribute("user", user);
			   return "login";
		}
	}
	
	//page after the admin has updated products in the productinventory page
	@RequestMapping(value = "/updateproductinventory", method = RequestMethod.POST)
	public String updateProductInventory(Model model, @RequestParam("action") String action, @RequestParam("user_id") String user_id, @RequestParam("role_id") String role_id, @RequestParam("product_id") String product_id, @RequestParam("product_name") String product_name, @RequestParam("product_quantity") String product_quantity, @RequestParam("product_price") String product_price , HttpServletRequest request) {
		
		if (request.getSession() != null && request.getSession().getAttribute("username") != null)	{	
			int icnt = casservice.updateProductInventory(action, user_id, product_id, product_name, product_quantity, product_price );
			System.out.println("add/updated product inventory : " + icnt);
			
			
			ArrayList<Product> products = casservice.getProducts(role_id);
			model.addAttribute("products", products);
			
			System.out.println("productinventory: " + user_id);
			User user = casservice.getUser(user_id);
			model.addAttribute("user", user);
			
			model.addAttribute("successMessage", "");
			model.addAttribute("errorMessage", "");
			if (icnt > 0) {
				if (action.equalsIgnoreCase("Add")) {
					model.addAttribute("successMessage", "Product Added Successfully");
				}else if (action.equalsIgnoreCase("Update")) {
					model.addAttribute("successMessage", "Product Updated Successfully");
				}else if (action.equalsIgnoreCase("Delete")) {
					model.addAttribute("successMessage", "Product Deleted Successfully");
				}
			}else {
				model.addAttribute("errorMessage", "Request not successfully completed");
			}
			
			
			return "productinventory";
		}else {
			   User user = new User();
			   model.addAttribute("user", user);
			   return "login";
		}	
	}
	
	//page for the admin where they can read/update the profile details of all users
	@RequestMapping(value = "/useradministration", method = RequestMethod.POST)
	public String getUsers(Model model, @RequestParam("user_id") String userid, @RequestParam("role_id") String roleid , HttpServletRequest request) {
		
		if (request.getSession() != null && request.getSession().getAttribute("username") != null)	{	
			ArrayList<User> users = casservice.getUsers();
			model.addAttribute("users", users);
			
			System.out.println("useradministration: " + userid);
			User user = casservice.getUser(userid);
			model.addAttribute("user", user);
			
			return "useradministration";
		}else {
			   User user = new User();
			   model.addAttribute("user", user);
			   return "login";
		}	
	}
	
	//page after the admin has updated profile details of a user 
	@RequestMapping(value = "/updateuser", method = RequestMethod.POST)
	public String updateuser(Model model, @RequestParam("action") String action, @RequestParam("user_firstname") String firstname, @RequestParam("user_lastname") String lastname, @RequestParam("user_address") String address, @RequestParam("user_emailid") String emailid, @RequestParam("user_userid") String userid, @RequestParam("user_roleid") String roleid, @RequestParam("luser_id") String luserid , HttpServletRequest request) {
		
		if (request.getSession() != null && request.getSession().getAttribute("username") != null)	{	
			int icnt = casservice.updateuser(action, firstname, lastname, address, emailid, userid, roleid );
			System.out.println("delete/update user : " + icnt);
			
			
			ArrayList<User> users = casservice.getUsers();
			model.addAttribute("users", users);
			
			System.out.println("useradministration: " + luserid);
			User user = casservice.getUser(luserid);
			model.addAttribute("user", user);
			
			model.addAttribute("successMessage", "");
			model.addAttribute("errorMessage", "");
			if (icnt > 0) {
				 if (action.equalsIgnoreCase("Update")) {
					model.addAttribute("successMessage", "User Updated Successfully");
				}else if (action.equalsIgnoreCase("Delete")) {
					model.addAttribute("successMessage", "User Deleted Successfully");
				}
			}else {
				model.addAttribute("errorMessage", "Request not successfully completed");
			}
			
			
			return "useradministration";
		}else {
			   User user = new User();
			   model.addAttribute("user", user);
			   return "login";
		}		
	}
}
