package test.singleton;

import static org.junit.Assert.*;

import org.junit.Test;

import impl.Clients;

public class SingletonTest {

	@Test
	public void test() {
		ClientsMock clients = new ClientsMock();
		clients.addClient(null);
		
		assertEquals(1, (new ClientsMock().getNbClients()));
	}

	public class ClientsMock extends Clients {
		public int getNbClients() {
			return clients.size();
		}
	}
}
