package exec;


import impl.Client;
import impl.Clients;
import impl.Order;
import impl.Orders;

public class Main {
	public static void main(String[] args) {
	
		Client c1 = new Client("Louis", "Lille");
		Client c2 = new Client("Helene", "Sainghin-en-Melantois");
		Client c3 = new Client("client", "ville");
		
		Order o1 = new Order(1, 42);
		Order o2 = new Order(2, 45);
		Order o3 = new Order(3,89);
		Order o4 = new Order(4,189);
		Order o5 = new Order(5,689);
		Order o6 = new Order(6,989);
		
		c1.addOrder(o1);
		c2.addOrder(o3);
		c2.addOrder(o4);
		c2.addOrder(o5);
		
		Clients clients = new Clients();
		clients.addClient(c1);
		clients.addClient(c2);
		
		Orders orders = new Orders();
		orders.addOrder(o1);
		orders.addOrder(o2);
		orders.addOrder(o3);
		orders.addOrder(o4);
		orders.addOrder(o5);
		orders.addOrder(o6);
		
		clients.delClient(c1);
		clients.delClient(c3);
		orders.addOrder(o4);
		
		orders.delOrder(o1);
		orders.delOrder(o6);
		
		clients.delClient(c1);
	}
}
