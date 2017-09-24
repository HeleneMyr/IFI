package impl;

import java.util.ArrayList;
import java.util.List;

public class Orders {

	private List<Order> orders;
	
	public Orders () {
		this.orders = new ArrayList<>();
	}
	
	public void addOrder(Order o) {
		orders.add(o);
		printOk();
	}
	
	public void delOrder(Order o) {
		if (this.orders.contains(o) && o !=null) {
			o.printOrder();
			System.out.println( " supprim� -> class Orders");
			this.orders.remove(o);
		}
			
	}
	
	public boolean printOk() {
		System.out.println("ok");
		return true;
	}
}
