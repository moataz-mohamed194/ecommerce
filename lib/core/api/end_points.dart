class EndPoints {
  static const String baseUrl = 'https://fakestoreapi.com/';
  static const String signInUrl = '${baseUrl}auth/login';
  static const String signUpUrl = '${baseUrl}users';
  static const String getAllProductsUrl = '${baseUrl}products';
  static const String getAllCategoryUrl = '${baseUrl}products/categories';
  static const String getAllProductSearchUrl = '${baseUrl}products/category';

  static String getOneProduct(int id) {
    return "$getAllProductsUrl/$id";
  }
  static String deleteOneProductsUrl(int id) {
    return "$getAllProductsUrl/$id";
  }
  static String editOneProductsUrl(int id) {
    return "$getAllProductsUrl/$id";
  }
  static String getProfileUrl(int id) {
    return "$signUpUrl/$id";
  }
}
