package singleton;

import impl.Client;
import impl.Order;

public class ExecSingleton {

	public static void main(String[] args) {		
		System.out.println("__________________________");
		System.out.println("*** Classe singleton *** \n");
		System.out.println("-> Creer un client avec le nom Bob");
		Client c3 = new Client("Bob", "Lille");
		System.out.println("-> Creer un autre client avec le nom Albert");
		Client c4 = new Client("Albert", "Paris");
		System.out.println("name of client 2 : " + c4.getName() + "\n");
		
		System.out.println("-> Creer une commande avec l'id 1");
		Order o1 = new Order(1, 12L);
		System.out.println("-> Creer une autre commande avec l'id 2");
		Order o2 = new Order(2, 22L);
		System.out.println("order 2 : ");
		o2.printOrder();
	}
}
