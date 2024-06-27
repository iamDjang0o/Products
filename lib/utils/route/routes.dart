import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pruduct_app/pages/auth/auth_middleware.dart';
import 'package:pruduct_app/pages/auth/login/view/login_page.dart';
import 'package:pruduct_app/pages/home/view/home_page.dart';
import 'package:pruduct_app/pages/home/view/product_details_page.dart';
import 'package:pruduct_app/utils/bindings/app_bindings.dart'; // Import the InitialRouteMiddleware

class Routes {
  static const String home = '/home';
  static const String login = '/login';
  static const String details = '/details';
  static const String initial = '/initial'; // Add initial route
}

List<GetPage<dynamic>>? routes = [
  GetPage(
    name: Routes.home,
    page: () => HomePage(),
    middlewares: [AuthMiddleWare()], // Attach the middleware here
  ),
  GetPage(name: Routes.login, page: () => SignInPage()),
  GetPage(
    name: Routes.details,
    page: () => DetailPage(),
    middlewares: [AuthMiddleWare()], // And here
  ),
  GetPage(
    name: Routes.initial, // Add the initial route page
    page: () => Container(), // Dummy page, we won't navigate here
    middlewares: [InitialRouteMiddleware()], // Attach initial route middleware
  ),
];
