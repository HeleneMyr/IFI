package impl;

/**
 * Classe représentant la commande
 * 
 * @author Helene MEYER
 *
 */
public class Order{

	/**
	 * id de la commande
	 */
	private int id;
	/**
	 * le montant de la commande
	 */
	private double amount;
	
	/**
	 * Constructeur de la commande
	 * 
	 * @param id l'identifiant de la commande
	 * @param amount le montant de la commande
	 */
	public Order (int id, double amount){
		this.id = id;
		this.amount = amount;
	}
	
	/**
	 * imprimer une commande
	 */
	public void printOrder() {
		System.out.println(id + " " + amount);
	}
}
