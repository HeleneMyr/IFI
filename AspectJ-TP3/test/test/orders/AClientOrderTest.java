package test.orders;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import impl.Client;
import impl.Clients;
import impl.Order;
import impl.Orders;

public class AClientOrderTest {

	private Clients clients;
	private Orders orders;
	
	@Before
	public void init() {
		this.clients = new Clients();
		this.clients.initLstClients();
		this.orders = new Orders();
		this.orders.initLstOrders();
	}
	
	@Test
	public void addClientToOrder() {
		Order o1 = new Order(1, 2.);
		Client c1 = new Client("client", "adresse");
		o1.setClient(c1);
		assertNotNull(o1.getClient());
	}
	
	@Test
	public void addOrderToClient() {
		Order o1 = new Order(1, 2.);
		Client c1 = new Client("client", "adresse");
		c1.addOrder(o1);
		assertTrue(c1.hasOrder());
	}
	
	@Test
	public void checkOrderOfClient() {
		Client c1 = new Client("client", "adresse");
		assertFalse(c1.hasOrder());
	}
	
	@Test
	public void deleteOrderOfClient() {
		Order o1 = new Order(1, 2.);
		Client c1 = new Client("client", "adresse");
		c1.addOrder(o1);
		c1.delOrder(o1);
		assertFalse(c1.hasOrder());
		assertNull(o1.getClient());
	}
	
	@Test
	public void deleteNullOrderOfClient() {
		Client c1 = new Client("client", "adresse");
		c1.delOrder(null);
		assertFalse(c1.hasOrder());
	}
	
	@Test
	public void deleteBadOrderOfClient() {
		Order o1 = new Order(1, 2.);
		Order o2 = new Order(2, 4.);
		Client c1 = new Client("client", "adresse");
		c1.addOrder(o1);
		c1.delOrder(o2);
		assertTrue(c1.hasOrder());
		assertNotNull(o1.getClient());
		assertNull(o2.getClient());
	}
	
	@Test
	public void deleteNullClientInClients() {
		this.clients.delClient(null);
		assertEquals(0, this.clients.getNbClients());
	}
	
	@Test
	public void deleteClientWithoutOrderInClients() {
		Client c1 = new Client("client", "adresse");
		this.clients.addClient(c1);
		clients.delClient(c1);
		assertEquals(0, this.clients.getNbClients());
	}

	@Test
	public void deleteClientWithOrderInClients() {
		Order o1 = new Order(1, 2.);
		Client c1 = new Client("client", "adresse");
		c1.addOrder(o1);
		clients.addClient(c1);
		clients.delClient(c1);
		assertEquals(1, this.clients.getNbClients());
	}
}
