package enAspect.commande;

public class Order {

	private int id;
	private double amount;
	
	public Order (int id, double amount){
		this.id = id;
		this.amount = amount;
	}
	
	public void printOrder() {
		System.out.println(id + " " + amount);
	}
}
