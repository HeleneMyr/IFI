package orders;

import java.util.ArrayList;
import java.util.List;

import impl.Client;
import impl.Order;

/**
 * Aspect faisant le lien entre un client et une commande
 * 
 * @author Helene MEYER
 *
 */
public aspect AClientOrder {

	/**
	 * client sur la commande
	 */
	private Client Order.client;
	/**
	 * liste des commandes pour le client
	 */
	private List<Order> Client.orders;

	/**
	 * initialisation de la liste des commande dans la classe du client
	 */
	after():initialization(Client.new(..)) {
		Client monClient = (Client) thisJoinPoint.getTarget();
		monClient.orders = new ArrayList<>();
	}

	/**
	 * Modifier un client sur la commande
	 * 
	 * @param c le nouveau client de la commande
	 */
	public void Order.setClient(Client c) {
		this.client = c;
	}

	/**
	 * Récupérer le client de la commande
	 * 
	 * @return le client de la commande
	 */
	public Client Order.getClient() {
		return this.client;
	}

	/**
	 * Ajouter une commande au client
	 * 
	 * @param o la commande à ajouter
	 */
	public void Client.addOrder(Order o) {
		this.orders.add(o);
		o.setClient(this);
	}

	/**
	 * Retourne vrai si le client a une commande sinon retourne faux
	 * 
	 * @return vrai si le client a une commande sinon retourne faux
	 */
	public boolean Client.hasOrder() {
		return !this.orders.isEmpty();
	}

	/**
	 * Supprimer une commande d'un client
	 * 
	 * @param o la commande du client
	 */
	public void Client.delOrder(Order o) {
		if (o != null && this.orders.contains(o)) {
			o.setClient(null);
			this.orders.remove(o);
		}

	}
	
	/**
	 * Si le client a des commande, on ne peut pas supprimer le client
	 * 
	 * @param c le client à supprimer
	 */
	pointcut checkOrdersExist(Client c):
		call( void impl.Clients.delClient(Client)) && args(c);
	
	void around(Client c) : checkOrdersExist(c)
	{
		if (c != null && ! c.hasOrder()) {
			proceed(c);
		} 
	
	}
	
	/**
	 * Si on supprimer une commande, il faut supprimer la commande du client également
	 * 
	 * @param o la commande à supprimer
	 */
	pointcut delClientOrder(Order o):
		call( void impl.Orders.delOrder(Order)) && args(o);
	
	after(Order o) : delClientOrder(o)
	{
		if (o != null && o.client != null) {
			o.client.delOrder(o);
		}
	
	}
	
}
