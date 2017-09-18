package impl;

public class Client{
	private String name;
	private String address;

	
	public Client(String name, String address){
		this.name = name;
		this.address = address;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.setName("test");
		this.address = address;
	}
	
}
