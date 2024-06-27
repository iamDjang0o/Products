import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pruduct_app/components/colors.dart';
import 'package:pruduct_app/utils/bindings/app_bindings.dart';
import 'package:pruduct_app/utils/route/routes.dart';
import 'package:pruduct_app/utils/services/app_services.dart';

void main() async {
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  await Get.putAsync(() => Services().init());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Products View App',

      initialBinding: InitialBinding(),
      theme: ThemeData(
        colorSchemeSeed: primaryColor,
      ),

      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      getPages: routes, // Define the routes
    );
  }
}
