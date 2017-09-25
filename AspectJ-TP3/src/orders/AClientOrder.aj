package orders;

import java.util.ArrayList;
import java.util.List;

import impl.Client;
import impl.Order;

public aspect AClientOrder {

	private Client Order.client;
	private List<Order> Client.orders;

	after():initialization(Client.new(..)) {
		Client monClient = (Client) thisJoinPoint.getTarget();
		monClient.orders = new ArrayList<>();
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
			o.printOrder();

		}

	}
	
	pointcut checkOrdersExist(Client c):
		call( void impl.Clients.delClient(Client)) && args(c);
	
	void around(Client c) : checkOrdersExist(c)
	{
		if (c != null && ! c.hasOrder()) {
			proceed(c);
		} 
	
	}
	
	pointcut delClientOrder(Order o):
		call( void impl.Orders.delOrder(Order)) && args(o);
	
	after(Order o) : delClientOrder(o)
	{
		if (o.client != null) {
			o.client.delOrder(o);
		}
	
	}
	
}
