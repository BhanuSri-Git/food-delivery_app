package com.food.Model;

import java.math.BigDecimal;
import java.sql.Timestamp;
public class Menu {
	private int MenuID;
	private int RestaurantID;
	private String ItemName;
	private String Description;
	private BigDecimal Price;
	private boolean IsAvailable;
	private String Category;
	private double Rating;
	private Timestamp CreatedAt;
	private Timestamp UpdatedAt;
	private Timestamp DeletedAt;
	private String imagePath;

	public String getImagePath() {
	    return imagePath;
	}

	public void setImagePath(String imagePath) {
	    this.imagePath = imagePath;
	}

	public  int getMenuID() {
		return MenuID;
	}
	public void setMenuID(int MenuID) {
		this.MenuID = MenuID;
	}
	public int getRestaurantID() {
		return RestaurantID;
	}
	public void setRestaurantID(int RestaurantID) {
		this.RestaurantID = RestaurantID;
	}
	public String getItemName() {
		return ItemName;
	}
	public void setItemName(String ItemName) {
		this.ItemName = ItemName;
	}
	public String getDescription() {
		return Description;
	}
	public void setDescription(String Description) {
		this.Description = Description;
	}
	public BigDecimal getPrice() {
		return Price;
	}
	public void setPrice(BigDecimal Price) {
		this.Price = Price;
	}
	public Menu(int RestaurantID, String ItemName, String Description, BigDecimal Price, boolean IsAvailable,String Category) {
		super();
		this.RestaurantID = RestaurantID;
		this.ItemName = ItemName;
		this.Description = Description;
		this.Price = Price;
		this.IsAvailable = IsAvailable;
		this.Category = Category;
	}
	public boolean getIsAvailable() {
		return IsAvailable;
	}
	public void setIsAvailable(boolean IsAvailable) {
		this.IsAvailable = IsAvailable;
	}
	public String getCategory() {
		return Category;
	}
	public void setCategory(String Category) {
		this.Category = Category;
	}
	public Timestamp getCreatedAt() {
		return CreatedAt;
	}
	public void setCreatedAt(Timestamp CreatedAt) {
		this.CreatedAt = CreatedAt;
	}
	public Timestamp getUpdatedAt() {
		return UpdatedAt;
	}
	public void setUpdatedAt(Timestamp UpdatedAt) {
		this.UpdatedAt = UpdatedAt;
	}
	public Timestamp getDeletedAt() {
		return DeletedAt;
	}
	public void setDeletedAt(Timestamp DeletedAt) {
		this.DeletedAt = DeletedAt;
	}
	@Override
	public String toString() {
		return "Menu [MenuID=" + MenuID + ", RestaurantID=" + RestaurantID + ", ItemName=" + ItemName + ", Description="
				+ Description + ", Price=" + Price + ", IsAvailable=" + IsAvailable + ", Category=" + Category
				+ ", CreatedAt=" + CreatedAt + ", UpdatedAt=" + UpdatedAt + ", DeletedAt=" + DeletedAt + "]";
	}
	public Menu(int MenuID, int RestaurantID, String ItemName, String Description,
            BigDecimal Price, boolean IsAvailable, String Category,
            double Rating, Timestamp CreatedAt,
            Timestamp UpdatedAt, Timestamp DeletedAt,
            String imagePath) {

    super();
    this.MenuID = MenuID;
    this.RestaurantID = RestaurantID;
    this.ItemName = ItemName;
    this.Description = Description;
    this.Price = Price;
    this.IsAvailable = IsAvailable;
    this.Category = Category;
    this.Rating = Rating;
    this.CreatedAt = CreatedAt;
    this.UpdatedAt = UpdatedAt;
    this.DeletedAt = DeletedAt;
    this.imagePath = imagePath;
}


	public Menu(int RestaurantID, String ItemName, String Description,
            BigDecimal Price, boolean IsAvailable, String Category,
            double Rating, Timestamp CreatedAt,
            Timestamp UpdatedAt, Timestamp DeletedAt,
            String imagePath) {

    super();
    this.RestaurantID = RestaurantID;
    this.ItemName = ItemName;
    this.Description = Description;
    this.Price = Price;
    this.IsAvailable = IsAvailable;
    this.Category = Category;
    this.Rating = Rating;
    this.CreatedAt = CreatedAt;
    this.UpdatedAt = UpdatedAt;
    this.DeletedAt = DeletedAt;
    this.imagePath = imagePath;
}
	public double getRating() {
		return Rating;
	}
	public void setRating(double rating) {
		Rating = rating;
	}



}