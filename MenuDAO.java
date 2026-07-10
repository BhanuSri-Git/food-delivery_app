package com.food.DAO;
import java.util.List;

import com.food.Model.Menu;

public interface MenuDAO {
	void addMenu(Menu menu);
	Menu getMenu(int MenuId);
	void updateMenu(Menu menu);
	void deleteMenu(int MenuId);
	List<Menu> getAllMenus();
	 List<Menu> getAllMenusByRestaurant(int restaurantId);

}




