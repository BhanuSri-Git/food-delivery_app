package com.food.Model;

import java.sql.Timestamp;

public class Offer {
    private int OfferID;
    private String Title;
    private String Description;
    private String CouponCode;
    private int DiscountPercent;
    private String OfferType;   // FLAT | COMBO | FREE_DELIVERY | BANK | FESTIVAL
    private boolean IsActive;
    private Timestamp ExpiryDate;
    private String ImagePath;

    public Offer() {}

    public Offer(String title, String description, String couponCode,
                 int discountPercent, String offerType, boolean isActive,
                 Timestamp expiryDate, String imagePath) {
        this.Title = title;
        this.Description = description;
        this.CouponCode = couponCode;
        this.DiscountPercent = discountPercent;
        this.OfferType = offerType;
        this.IsActive = isActive;
        this.ExpiryDate = expiryDate;
        this.ImagePath = imagePath;
    }

    public Offer(int offerID, String title, String description, String couponCode,
                 int discountPercent, String offerType, boolean isActive,
                 Timestamp expiryDate, String imagePath) {
        this.OfferID = offerID;
        this.Title = title;
        this.Description = description;
        this.CouponCode = couponCode;
        this.DiscountPercent = discountPercent;
        this.OfferType = offerType;
        this.IsActive = isActive;
        this.ExpiryDate = expiryDate;
        this.ImagePath = imagePath;
    }

    public int getOfferID()            { return OfferID; }
    public void setOfferID(int id)     { this.OfferID = id; }
    public String getTitle()           { return Title; }
    public void setTitle(String t)     { this.Title = t; }
    public String getDescription()     { return Description; }
    public void setDescription(String d){ this.Description = d; }
    public String getCouponCode()      { return CouponCode; }
    public void setCouponCode(String c){ this.CouponCode = c; }
    public int getDiscountPercent()    { return DiscountPercent; }
    public void setDiscountPercent(int d){ this.DiscountPercent = d; }
    public String getOfferType()       { return OfferType; }
    public void setOfferType(String t) { this.OfferType = t; }
    public boolean getIsActive()       { return IsActive; }
    public void setIsActive(boolean a) { this.IsActive = a; }
    public Timestamp getExpiryDate()   { return ExpiryDate; }
    public void setExpiryDate(Timestamp e){ this.ExpiryDate = e; }
    public String getImagePath()       { return ImagePath; }
    public void setImagePath(String p) { this.ImagePath = p; }
}
