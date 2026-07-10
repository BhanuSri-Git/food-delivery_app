package com.food.Model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class OrderTable {
	private int OrderID;
	private int UserID;
	private int RestaurantID;
	private Timestamp OrderDate;
	private BigDecimal TotalAmount;
	private String Status;
	private String PaymentMethod;
	private String fullName;
	private String phone;
	private String addressLine1;
	private String addressLine2;
	private String city;
	private String pincode;

	public int getOrderID() {
		return OrderID;
	}
	public void setOrderID(int OrderID) {
		this.OrderID = OrderID;
	}
	public int getUserID() {
		return UserID;
	}
	public void setUserID(int UserID) {
		this.UserID = UserID;
	}
	public int getRestaurantID() {
		return RestaurantID;
	}
	public void setRestaurantID(int RestaurantID) {
		this.RestaurantID = RestaurantID;
	}
	public Timestamp getOrderDate() {
		return OrderDate;
	}
	public void setOrderDate(Timestamp OrderDate) {
		this.OrderDate = OrderDate;
	}
	public BigDecimal getTotalAmount() {
		return TotalAmount;
	}
	public void setTotalAmount(BigDecimal TotalAmount) {
		this.TotalAmount = TotalAmount;
	}
	public String getStatus() {
		return Status;
	}
	public void setStatus(String Status) {
		this.Status = Status;
	}
	public String getPaymentMethod() {
		return PaymentMethod;
	}
	public void setPaymentMethod(String PaymentMethod) {
		this.PaymentMethod = PaymentMethod;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddressLine1() {
		return addressLine1;
	}

	public void setAddressLine1(String addressLine1) {
		this.addressLine1 = addressLine1;
	}

	public String getAddressLine2() {
		return addressLine2;
	}

	public void setAddressLine2(String addressLine2) {
		this.addressLine2 = addressLine2;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getPincode() {
		return pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	@Override
	public String toString() {
		return "OrderTable [OrderID=" + OrderID + ", UserID=" + UserID + ", RestaurantID=" + RestaurantID
				+ ", OrderDate=" + OrderDate + ", TotalAmount=" + TotalAmount + ", Status=" + Status
				+ ", PaymentMethod=" + PaymentMethod + ", fullName=" + fullName + ", phone=" + phone
				+ ", city=" + city + ", pincode=" + pincode + "]";
	}

	public OrderTable(int OrderID, int UserID, int RestaurantID, Timestamp OrderDate, BigDecimal TotalAmount,
			String Status, String PaymentMethod) {
		super();
		this.OrderID = OrderID;
		this.UserID = UserID;
		this.RestaurantID = RestaurantID;
		this.OrderDate = OrderDate;
		this.TotalAmount = TotalAmount;
		this.Status = Status;
		this.PaymentMethod = PaymentMethod;
	}

	public OrderTable(int UserID, int RestaurantID, BigDecimal TotalAmount,
			String Status, String PaymentMethod) {
		super();
		this.UserID = UserID;
		this.RestaurantID = RestaurantID;
		this.TotalAmount = TotalAmount;
		this.Status = Status;
		this.PaymentMethod = PaymentMethod;
	}

	public OrderTable(int UserID, int RestaurantID, BigDecimal TotalAmount, String Status, String PaymentMethod,
			String fullName, String phone, String addressLine1, String addressLine2, String city, String pincode) {
		super();
		this.UserID = UserID;
		this.RestaurantID = RestaurantID;
		this.TotalAmount = TotalAmount;
		this.Status = Status;
		this.PaymentMethod = PaymentMethod;
		this.fullName = fullName;
		this.phone = phone;
		this.addressLine1 = addressLine1;
		this.addressLine2 = addressLine2;
		this.city = city;
		this.pincode = pincode;
	}

}