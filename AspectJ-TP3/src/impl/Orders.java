package impl;

import java.util.ArrayList;
import java.util.List;

/**
 * Classe représentant l'ensemble des commandes
 * 
 * @author Helene MEYER
 *
 */
public class Orders {

	/**
	 * liste de toutes les commandes
	 */
	private List<Order> orders;
	
	/**
	 * Constructeur de l'ensemble des commandes
	 */
	public Orders () {
		initLstOrders();
	}

	/**
	 * Initialise la liste des commandes
	 */
	public void initLstOrders() {
		this.orders = new ArrayList<>();
	}
	
	/**
	 * Ajouter une commande
	 * 
	 * @param o la commande à ajouter
	 */
	public void addOrder(Order o) {
		orders.add(o);
	}
	
	/**
	 * Supprimer une commande
	 * 
	 * @param o la commande à supprimer
	 */
	public void delOrder(Order o) {
		if (o !=null && this.orders.contains(o)) {
			this.orders.remove(o);
		}
			
	}
	
	/**
	 * Retourne le nombre de commandes dans la liste
	 * 
	 * @return le nombre de commande
	 */
	public int getNbOrders() {
		return orders.size();
	}
}
