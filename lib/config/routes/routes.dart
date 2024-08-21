
import 'package:eccemorce_route_project/features/product_list/presentation/pages/product_details_from_wishlist.dart';
import 'package:eccemorce_route_project/features/product_list/presentation/pages/visa.dart';
import 'package:eccemorce_route_project/features/splach/presentation/pages/splach_screen.dart';
import 'package:flutter/material.dart';
import '../../features/fogot_password/presentation/pages/forgot_password.dart';
import '../../features/fogot_password/presentation/pages/reset_code.dart';
import '../../features/fogot_password/presentation/pages/reset_password.dart';
import '../../features/home/presentation/pages/cart_screen.dart';
import '../../features/home/presentation/pages/change_password_screen.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import '../../features/login/presentation/pages/login.dart';
import '../../features/product_list/presentation/pages/product_details.dart';
import '../../features/product_list/presentation/pages/product_list.dart';
import '../../features/signup/presentation/pages/signup.dart';

class AppRoute {
  static const String splach = '/';
  static const String logIn = "login";
  static const String signUp = "signup";
  static const String homeScreen = "homeScreen";
  static const String productList = "productList";
  static const String productDetails = "productDetails";
  static const String productDetailsFromWishList = "productDetailsFromWishList";

  static const String forgotPassword = "forgotPassword";
  static const String resetCode = "resetCode";
  static const String resetPassword = "resetPassword";
  static const String cartScreen = "cart";
  static const String changePassword = "changPassword";
  static const String visaScreen = "visaScreen";
}

class Routes {
  static Route onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.splach:
        return MaterialPageRoute(builder: (context) => SplachScreen());
      case AppRoute.signUp:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case AppRoute.logIn:
        return MaterialPageRoute(builder: (context) => LogInScreen());
      case AppRoute.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case AppRoute.productList:
        return MaterialPageRoute(
            builder: (context) => const ProductListScreen());
      case AppRoute.productDetails:
        return MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(),
            settings: settings);
      case AppRoute.productDetailsFromWishList:
        return MaterialPageRoute(
            builder: (context) => ProductDetailsScreenFromWishList(),
            settings: settings);
      case AppRoute.forgotPassword:
        return MaterialPageRoute(
            builder: (context) => ForgotPasswordScreen(), settings: settings);
      case AppRoute.resetCode:
        return MaterialPageRoute(
            builder: (context) => const ResetCode(), settings: settings);
      case AppRoute.resetPassword:
        return MaterialPageRoute(
            builder: (context) => ResetPasswordScreen(), settings: settings);
      case AppRoute.cartScreen:
        return MaterialPageRoute(
            builder: (context) => const CartScreen(), settings: settings);
      case AppRoute.changePassword:
        return MaterialPageRoute(
            builder: (context) => ChangePasswordScreen(), settings: settings);
      case AppRoute.visaScreen:
        return MaterialPageRoute(
            builder: (context) => VisaScreen(), settings: settings);
      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(title: const Text("error")),
              body: unDefinedRoute(),
            );
          },
        );
    }
  }

  static Widget unDefinedRoute() {
    return const Center(child: Text("Route Not Found"));
  }
}
