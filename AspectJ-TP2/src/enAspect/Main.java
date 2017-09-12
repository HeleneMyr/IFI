package enAspect;

import enAspect.client.Client;
import enAspect.client.Clients;
import enAspect.commande.Order;
import enAspect.commande.Orders;

public class Main {
	public static void main(String[] args) {
		Client c1 = new Client("Louis", "Lille");
		Client c2 = new Client("Hélène", "Sainghin-en-Mélantois");
		Client c3 = new Client("Alex", "Dans son appartement");
		Client c4 = new Client("Maximou", "Hellemmes");
		
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
		clients.addClient(c3);
		clients.addClient(c4);
		
		Orders orders = new Orders();
		orders.addOrder(o1);
		orders.addOrder(o2);
		orders.addOrder(o3);
		orders.addOrder(o4);
		orders.addOrder(o5);
		orders.addOrder(o6);
		
		System.out.println("supprimé c1");
		clients.delClient(c1);
		System.out.println("supprimé c3");
		clients.delClient(c3);
		
		System.out.println("Supprimé order appartenant c1");
		orders.delOrder(o1);
		System.out.println("Supprimé order vide");
		orders.delOrder(o6);
		
		System.out.println("Censé supprimé c1");
		clients.delClient(c1);
	}
}
