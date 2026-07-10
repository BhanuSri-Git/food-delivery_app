package com.food.DAOImpl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.food.DAO.OfferDAO;
import com.food.Model.Offer;
import com.tap.utility.DBConnection;

public class OfferDAOImpl implements OfferDAO {

    private static final String INSERT =
        "INSERT INTO offers(Title,Description,CouponCode,DiscountPercent,OfferType,IsActive,ExpiryDate,ImagePath) VALUES(?,?,?,?,?,?,?,?)";
    private static final String SELECT_BY_ID  = "SELECT * FROM offers WHERE OfferID=?";
    private static final String UPDATE =
        "UPDATE offers SET Title=?,Description=?,CouponCode=?,DiscountPercent=?,OfferType=?,IsActive=?,ExpiryDate=?,ImagePath=? WHERE OfferID=?";
    private static final String DELETE        = "DELETE FROM offers WHERE OfferID=?";
    private static final String SELECT_ACTIVE = "SELECT * FROM offers WHERE IsActive=TRUE ORDER BY OfferID DESC";
    private static final String SELECT_ALL    = "SELECT * FROM offers ORDER BY OfferID DESC";
    private static final String TOGGLE        = "UPDATE offers SET IsActive=? WHERE OfferID=?";

    private Offer mapRow(ResultSet rs) throws SQLException {
        return new Offer(
            rs.getInt("OfferID"),
            rs.getString("Title"),
            rs.getString("Description"),
            rs.getString("CouponCode"),
            rs.getInt("DiscountPercent"),
            rs.getString("OfferType"),
            rs.getBoolean("IsActive"),
            rs.getTimestamp("ExpiryDate"),
            rs.getString("ImagePath")
        );
    }

    @Override public void addOffer(Offer o) {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(INSERT)) {
            ps.setString(1, o.getTitle());
            ps.setString(2, o.getDescription());
            ps.setString(3, o.getCouponCode());
            ps.setInt(4, o.getDiscountPercent());
            ps.setString(5, o.getOfferType());
            ps.setBoolean(6, o.getIsActive());
            ps.setTimestamp(7, o.getExpiryDate());
            ps.setString(8, o.getImagePath());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    @Override public Offer getOffer(int id) {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(SELECT_BY_ID)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    @Override public void updateOffer(Offer o) {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(UPDATE)) {
            ps.setString(1, o.getTitle());
            ps.setString(2, o.getDescription());
            ps.setString(3, o.getCouponCode());
            ps.setInt(4, o.getDiscountPercent());
            ps.setString(5, o.getOfferType());
            ps.setBoolean(6, o.getIsActive());
            ps.setTimestamp(7, o.getExpiryDate());
            ps.setString(8, o.getImagePath());
            ps.setInt(9, o.getOfferID());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    @Override public void deleteOffer(int id) {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(DELETE)) {
            ps.setInt(1, id); ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    @Override public List<Offer> getAllActiveOffers() {
        List<Offer> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(SELECT_ACTIVE);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    @Override public List<Offer> getAllOffers() {
        List<Offer> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(SELECT_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    @Override public void toggleActive(int id, boolean active) {
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(TOGGLE)) {
            ps.setBoolean(1, active); ps.setInt(2, id); ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }
}
