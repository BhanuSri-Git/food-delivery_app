package com.food.DAO;

import java.util.List;
import com.food.Model.Offer;

public interface OfferDAO {
    void addOffer(Offer offer);
    Offer getOffer(int offerId);
    void updateOffer(Offer offer);
    void deleteOffer(int offerId);
    List<Offer> getAllActiveOffers();
    List<Offer> getAllOffers();
    void toggleActive(int offerId, boolean isActive);
}
