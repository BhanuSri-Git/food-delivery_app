package com.food.Model;

import java.math.BigDecimal;

public class Restaurant {
	private	int RestaurantID;
	private String Name;
	private String CuisineType;
	private int DeliveryTime;
	private String Address;
	private int AdminUserID;
	private BigDecimal Rating;
	private boolean  IsActive;
	private String imagePath;

	public Restaurant() {

	}

	public int getRestaurantID() {
		return RestaurantID;
	}

	public void setRestaurantID(int RestaurantID) {
		this.RestaurantID = RestaurantID;
	}

	public String getName() {
		return Name;
	}

	public void setName(String Name) {
		this.Name = Name;
	}

	public String getCuisineType() {
		return CuisineType;
	}

	public void setCuisineType(String CuisineType) {
		this.CuisineType = CuisineType;
	}

	public int getDeliveryTime() {
		return DeliveryTime;
	}

	public void setDeliveryTime(int DeliveryTime) {
		this.DeliveryTime = DeliveryTime;
	}

	public String getAddress() {
		return Address;
	}

	public void setAddress(String Address) {
		this.Address = Address;
	}

	public int getAdminUserID() {
		return AdminUserID;
	}

	public void setAdminUserID(int AdminUserID) {
		this.AdminUserID = AdminUserID;
	}

	public BigDecimal getRating() {
		return Rating;
	}

	public void setRating(BigDecimal Rating) {
		this.Rating = Rating;
	}

	public boolean getIsActive() {
		return IsActive;
	}

	public void setIsActive(boolean IsActive) {
		this.IsActive = IsActive;
	}


	public String getImagePath() {
	    return imagePath;
	}

	public void setImagePath(String imagePath) {
	    this.imagePath = imagePath;
	}

	@Override
	public String toString() {
	    return "Restaurant [RestaurantID=" + RestaurantID + ", Name=" + Name + ", CuisineType=" + CuisineType
	            + ", DeliveryTime=" + DeliveryTime + ", Address=" + Address + ", AdminUserID=" + AdminUserID
	            + ", Rating=" + Rating + ", IsActive=" + IsActive + ", imagePath=" + imagePath + "]";
	}

	public Restaurant(int RestaurantID, String Name, String CuisineType, int DeliveryTime, String Address,
	        int AdminUserID, BigDecimal Rating, boolean IsActive, String imagePath) {
	    super();
	    this.RestaurantID = RestaurantID;
	    this.Name = Name;
	    this.CuisineType = CuisineType;
	    this.DeliveryTime = DeliveryTime;
	    this.Address = Address;
	    this.AdminUserID = AdminUserID;
	    this.Rating = Rating;
	    this.IsActive = IsActive;
	    this.imagePath = imagePath;
	}
	public Restaurant(String Name, String CuisineType, int DeliveryTime, String Address, int AdminUserID,
	        BigDecimal Rating, boolean IsActive, String imagePath) {
	    super();
	    this.Name = Name;
	    this.CuisineType = CuisineType;
	    this.DeliveryTime = DeliveryTime;
	    this.Address = Address;
	    this.AdminUserID = AdminUserID;
	    this.Rating = Rating;
	    this.IsActive = IsActive;
	    this.imagePath = imagePath;
	}








}