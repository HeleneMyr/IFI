package impl;

/**
 * Classe représentant un client
 * 
 * @author Helene MEYER
 *
 */
public class Client{
	/**
	 * Nom du client
	 */
	private String name;
	/**
	 * Adresse du client
	 */
	private String address;

	/**
	 * Constructeur du client
	 * 
	 * @param name le nom du client
	 * @param address l'adresse du client
	 */
	public Client(String name, String address){
		this.name = name;
		this.address = address;
	}


	/**
	 * Récupérer le nom du client
	 * 
	 * @return le nom du client
	 */
	public String getName() {
		return name;
	}


	/**
	 * Modifier le nom du client
	 * 
	 * @param name le nouveau nom du client
	 */
	public void setName(String name) {
		this.name = name;
	}


	/**
	 * Récupérer l'adresse du client
	 * 
	 * @return l'adresse du client
	 */
	public String getAddress() {
		return address;
	}


	/**
	 * Modifier l'adresse du client
	 * 
	 * @param address la nouvelle adresse du client
	 */
	public void setAddress(String address) {
		this.address = address;
	}
	
}
