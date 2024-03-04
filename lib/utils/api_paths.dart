class ApiPaths {
  static String products() => 'products/';
  static String product(String id) => 'products/$id';
  
  static String announcements() => 'announcements/';
  static String announcement(String id) => 'announcements/$id';

  static String onboardings() => 'onboardings/';
  static String onboarding(String id) => 'onboardings/$id';

  static String categories() => 'categories/';
  static String category(String id) => 'categories/$id';

  static String user(String uid) => 'users/$uid';

  static String cartItem(String uid, String cartItemId) => 'users/$uid/cartItems/$cartItemId';
  static String cartItems(String uid) => 'users/$uid/cartItems/';

  static String favoriteItem(String uid, String favoriteItemId) => 'users/$uid/favoriteItems/$favoriteItemId';
  static String favoriteItems(String uid) => 'users/$uid/favoriteItems/';

  static String locations(String uid) => 'users/$uid/locations/';
  static String location(String uid, String locationId) => 'users/$uid/locations/$locationId';

  static String payments(String uid) => 'users/$uid/payments/';
  static String payment(String uid, String paymentId) => 'users/$uid/payments/$paymentId';

}