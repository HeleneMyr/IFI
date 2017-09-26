package impl;

import java.util.ArrayList;
import java.util.List;

public class Clients {

	protected List<Client> clients;
	
	public Clients() {
		initLstClients();
	}
	
	public void addClient(Client c) {
		clients.add(c);
	}
	
	public void delClient(Client c) {
		if (c!=null && this.clients.contains(c)) {
			this.clients.remove(c);
		}
			
	}
	
	public void initLstClients() {
		this.clients = new ArrayList<>();
	}
	
	public int getNbClients() {
		return clients.size();
	}
}
