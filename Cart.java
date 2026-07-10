package com.food.Model;

import java.util.HashMap;
import java.util.Map;

public class Cart {

    private Map<Integer, CartItem> items;

    public Cart() {
        items = new HashMap<>();
    }

    // Return all cart items
    public Map<Integer, CartItem> getItems() {
        return items;
    }

    // Add item to cart
    public void addItem(CartItem cartItem) {

        int menuID = cartItem.getMenuID();

        if (items.containsKey(menuID)) {

            CartItem existingItem = items.get(menuID);

            existingItem.setQuantity(
                    existingItem.getQuantity() + cartItem.getQuantity());

        } else {

            items.put(menuID, cartItem);

        }
    }

    // Update quantity
    public void updateItem(int menuID, int quantity) {

        if (items.containsKey(menuID)) {

            if (quantity <= 0) {

                items.remove(menuID);

            } else {

                items.get(menuID).setQuantity(quantity);

            }
        }
    }

    // Remove one item completely
    public void removeItem(int menuID) {

        items.remove(menuID);

    }

    // Clear complete cart
    public void clear() {

        items.clear();

    }

    // Total number of items in cart
    public int getTotalQuantity() {

        int total = 0;

        for (CartItem item : items.values()) {

            total += item.getQuantity();

        }

        return total;
    }

    // Check whether cart is empty
    public boolean isEmpty() {

        return items.isEmpty();

    }

}