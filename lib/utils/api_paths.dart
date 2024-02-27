class ApiPaths {
  static String products() => 'products/';
  static String product(String id) => 'products/$id';
  
  static String announcements() => 'announcements/';
  static String announcement(String id) => 'announcements/$id';

  static String categories() => 'categories/';
  static String category(String id) => 'categories/$id';

  static String user(String uid) => 'users/$uid';

  static String cartItem(String uid, String cartItemId) => 'users/$uid/cartItems/$cartItemId';
  static String cartItems(String uid) => 'users/$uid/cartItems/';

  static String favoriteItem(String uid, String favoriteItemId) => 'users/$uid/favoriteItems/$favoriteItemId';
  static String favoriteItems(String uid) => 'users/$uid/favoriteItems/';
}