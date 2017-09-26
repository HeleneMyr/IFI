package test.impl;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import impl.Client;
import impl.Order;
import impl.Orders;

public class OrdersTest {

	private Orders orders;
	
	@Before
	public void init() {
		this.orders = new Orders();
		this.orders.initLstOrders();
	}
	
	@Test
	public void initializationOrders() {
		assertEquals(0, this.orders.getNbOrders());
	}
	
	@Test
	public void testAddOrder() {
		Order o1 = new Order(1, 12.);
		this.orders.addOrder(o1);
		assertEquals(1, this.orders.getNbOrders());
	}

	@Test
	public void testRemoveNullOrder() {
		Order o1 = new Order(1, 2.);
		this.orders.addOrder(o1);
		this.orders.delOrder(null);
		assertEquals(1, orders.getNbOrders());
	}
	
	@Test
	public void testRemoveBadOrder() {
		Order o1 = new Order(1, 2.);
		Order o2 = new Order(2, 3.);
		this.orders.addOrder(o1);
		this.orders.delOrder(o2);
		assertEquals(1, orders.getNbOrders());
	}
	
	@Test
	public void testRemoveClient() {
		Order o1 = new Order(1, 2.);
		this.orders.addOrder(o1);
		this.orders.delOrder(o1);
		assertEquals(0, orders.getNbOrders());
	}
}
