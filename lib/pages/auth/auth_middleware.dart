import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:pruduct_app/utils/route/routes.dart';
import 'package:pruduct_app/utils/storage/keys.dart';

class AuthMiddleWare extends GetMiddleware {
  final _box = GetStorage();

  @override
  RouteSettings? redirect(String? route) {
    // Check if the token exists in the storage to determine if the user is logged in.
    if (_box.hasData(StorageKeys.tokenKey)) {
      // If token exists, proceed to the desired route.
      return null;
    } else {
      // If token does not exist, redirect the user to the login page.
      return const RouteSettings(name: Routes.login);
    }
  }
}
