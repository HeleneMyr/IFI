package enJava.client;

import java.util.ArrayList;
import java.util.List;

import enJava.commande.Order;

public class Client {
	private String name;
	private String address;
	private List<Order> orders;
	
	public Client(String name, String address){
		this.orders = new ArrayList();
		this.name = name;
		this.address = address;
	}
	
	public void addOrder(Order o) {
		this.orders.add(o);
		o.setClient(this);
	}
	
	public boolean hasOrder() {
		return !this.orders.isEmpty();
	}
	
	public void delOrder (Order o) {
		if (o != null && this.orders.contains(o)){
			o.setClient(null);
			this.orders.remove(o);
			System.out.print(" supprimé classe Client "); o.printOrder();
			
		}
			
	}
	
}
