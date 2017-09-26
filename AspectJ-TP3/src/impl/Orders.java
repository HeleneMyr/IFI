package impl;

import java.util.ArrayList;
import java.util.List;

public class Orders {

	private List<Order> orders;
	
	public Orders () {
		initLstOrders();
	}

	public void initLstOrders() {
		this.orders = new ArrayList<>();
	}
	
	public void addOrder(Order o) {
		orders.add(o);
	}
	
	public void delOrder(Order o) {
		if (o !=null && this.orders.contains(o)) {
			o.printOrder();
			this.orders.remove(o);
		}
			
	}
	
	public boolean printOk() {
		System.out.println("ok");
		return true;
	}
	
	public int getNbOrders() {
		return orders.size();
	}
}
