import 'package:smartbuy/models/user.dart';

class ProjectPaths{
  static const String productPlaceholderImage = "assets/images/product_placeholder_image.png";
  static const String heroImage = "assets/images/bg.jpg";
}

class ProjectData{
  static User? user;
}


class APIs{
  // static const _baseUrl = "http://localhost:5000";
  static const _baseUrl = "https://smart-buy-express-app.onrender.com";
  static const getProductsApi = "$_baseUrl/products/get";
  static const registerApi = "$_baseUrl/auth/register";
  static const loginApi = "$_baseUrl/auth/login";
  static const productSubscribeApi = "$_baseUrl/price-track/subscribe";
  static const productSubscriptionVerifyApi = "$_baseUrl/price-track/is-subscribed";
  static const productUnsubscribeApi = "$_baseUrl/price-track/unsubscribe";
}