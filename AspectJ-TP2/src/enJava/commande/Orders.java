package enJava.commande;

import java.util.ArrayList;
import java.util.List;

public class Orders {

	private List<Order> orders;
	
	public Orders () {
		this.orders = new ArrayList<>();
	}
	
	public void addOrder(Order o) {
		orders.add(o);
	}
	
	public void delOrder(Order o) {
		if (this.orders.contains(o) && o !=null) {
			o.printOrder();
			System.out.println( " supprimé -> class Orders");
			if (o.getClient() != null) o.getClient().delOrder(o);
			this.orders.remove(o);
		}
			
	}
}
