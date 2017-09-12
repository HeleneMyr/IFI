package enAspect.client;

import java.util.ArrayList;
import java.util.List;

public class Clients {

	private List<Client> clients;
	
	public Clients() {
		this.clients = new ArrayList<>();
	}
	
	public void addClient(Client c) {
		clients.add(c);
	}
	
	public void delClient(Client c) {
		if (c!=null && this.clients.contains(c)) {
			System.out.println("client supprimé ");
			this.clients.remove(c);
		}
			
	}
}
