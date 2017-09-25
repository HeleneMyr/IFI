package impl;

import java.util.ArrayList;
import java.util.List;

public class Clients {

	protected List<Client> clients;
	
	public Clients() {
		this.clients = new ArrayList<>();
	}
	
	public void addClient(Client c) {
		clients.add(c);
	}
	
	public void delClient(Client c) {
		if (c!=null && this.clients.contains(c)) {
			this.clients.remove(c);
		}
			
	}
}
