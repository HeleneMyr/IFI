package test.impl;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import impl.Client;
import impl.Clients;

public class ClientsTest {

	private Clients clients;
	
	@Before
	public void init() {
		this.clients = new Clients();
		this.clients.initLstClients();
	}
	
	@Test
	public void initializationClients() {
		assertEquals(0, this.clients.getNbClients());
	}
	
	@Test
	public void testAddClient() {
		Client c1 = new Client("client", "adresse 1");
		this.clients.addClient(c1);
		assertEquals(1, this.clients.getNbClients());
	}

	@Test
	public void testRemoveNullClient() {
		Client c1 = new Client("client", "adresse 1");
		this.clients.addClient(c1);
		this.clients.delClient(null);
		assertEquals(1, clients.getNbClients());
	}
	
	@Test
	public void testRemoveBadClient() {
		Client c1 = new Client("client", "adresse 1");
		Client c2 = new Client("client2", "adresse 2");
		this.clients.addClient(c1);
		this.clients.delClient(c2);
		assertEquals(1, clients.getNbClients());
	}
	
	@Test
	public void testRemoveClient() {
		Client c1 = new Client("client", "adresse 1");
		this.clients.addClient(c1);
		this.clients.delClient(c1);
		assertEquals(0, clients.getNbClients());
	}
}
