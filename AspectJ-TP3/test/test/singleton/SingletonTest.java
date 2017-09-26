package test.singleton;

import static org.junit.Assert.*;

import org.junit.Test;

import impl.Clients;

public class SingletonTest {

	@Test
	public void test() {
		Clients clients = new Clients();
		clients.addClient(null);
		
		assertEquals(1, (new Clients().getNbClients()));
	}
}
