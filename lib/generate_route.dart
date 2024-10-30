import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartbuy/screens/auth/login_screen.dart';
import 'package:smartbuy/screens/auth/register_screen.dart';
import 'package:smartbuy/screens/home/home.dart';
import 'package:smartbuy/screens/product/product_screen.dart';
import 'package:smartbuy/screens/webview/product_on_site.dart';
import 'package:smartbuy/xutils/xtext.dart';

import 'models/product_model.dart';

class Routes{
  static const String home = "/";
  static const product = "/product";
  static const login = "/login";
  static const register = "/register";
  static const productOnSite = "/product-on-site";
}

class RouteGenerator {
  static Route<dynamic> generateRoute(
      BuildContext context, RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) {
          return const Home();
        });

      case Routes.product:
        return MaterialPageRoute(builder: (_) {
          return ProductScreen(product: args as ProductModel);
        });

      case Routes.login:
        return MaterialPageRoute(builder: (_) {
          return const LoginScreen();
        });

      case Routes.register:
        return MaterialPageRoute(builder: (_) {
          return const Register();
        });
      case Routes.productOnSite:
        return MaterialPageRoute(builder: (_) {
          return ProductOnSiteState(args as Uri);
        });

      default:
        return MaterialPageRoute(builder: (_) {
          return const ErrorScreen();
        });
    }
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Error"), centerTitle: true),
      body: const Center(
        child: XText("Could not find your Route"),
      ),
    );
  }
}
