package enAspect;

import java.util.ArrayList;
import java.util.List;

import org.aspectj.lang.ProceedingJoinPoint;

import enAspect.client.Client;
import enAspect.commande.Order;

public aspect AClientOrder {

	private Client Order.client;
	private List<Order> Client.orders;

	after():initialization(Client.new(..)) {
		Client monClient = (Client) thisJoinPoint.getTarget();
		monClient.orders = new ArrayList();
	}

	public void Order.setClient(Client c) {
		this.client = c;
	}

	public Client Order.getClient() {
		return this.client;
	}

	public void Client.addOrder(Order o) {
		this.orders.add(o);
		o.setClient(this);
	}

	public boolean Client.hasOrder() {
		return !this.orders.isEmpty();
	}

	public void Client.delOrder(Order o) {
		if (o != null && this.orders.contains(o)) {
			o.setClient(null);
			this.orders.remove(o);
			System.out.print(" supprimé classe Client ");
			o.printOrder();

		}

	}
	
	pointcut checkOrdersExist(Client c):
		call( void enAspect.client.Clients.delClient(Client)) && args(c);
	
	void around(Client c) : checkOrdersExist(c)
	{
		System.out.println("check exist");
		
		if (! c.hasOrder()) {
			System.out.println("pas order");
			proceed(c);
		} else {
			System.out.println("a order");
		}
	
	}
	
	pointcut delClientOrder(Order o):
		call( void enAspect.commande.Orders.delOrder(Order)) && args(o);
	
	after(Order o) : delClientOrder(o)
	{
		System.out.println("check order");
		
		if (o.getClient() != null) o.getClient().delOrder(o);
	
	}
	
}
