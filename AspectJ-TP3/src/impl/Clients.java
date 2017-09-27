package impl;

import java.util.ArrayList;
import java.util.List;

/**
 * Classe representant l'ensemble des clients
 * 
 * @author Helene MEYER
 *
 */
public class Clients {

	/**
	 * liste de tous les clients
	 */
	protected List<Client> clients;
	
	/**
	 * Constructeur de l'ensemble des clients
	 */
	public Clients() {
		initLstClients();
	}
	
	/**
	 * Ajouter un client
	 * 
	 * @param c le client à ajouter
	 */
	public void addClient(Client c) {
		clients.add(c);
	}
	
	/**
	 * Supprimer un client
	 * 
	 * @param c le client à supprimer
	 */
	public void delClient(Client c) {
		if (c!=null && this.clients.contains(c)) {
			this.clients.remove(c);
		}
			
	}
	
	/**
	 * Initialiser la liste des clients
	 */
	public void initLstClients() {
		this.clients = new ArrayList<>();
	}
	
	/**
	 * Retourne le nombre de clients dans la liste
	 * 
	 * @return le nombre de client dans la liste
	 */
	public int getNbClients() {
		return clients.size();
	}
}
