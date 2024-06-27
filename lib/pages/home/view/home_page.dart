import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pruduct_app/components/appbar.dart';
import 'package:pruduct_app/components/colors.dart';
import 'package:pruduct_app/components/images.dart';
import 'package:pruduct_app/pages/home/controller/product_controller.dart';
import 'package:pruduct_app/utils/route/routes.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        SystemNavigator.pop();
      },
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Image.asset(
                AssetPaths.background,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Scaffold(
            backgroundColor:
                const Color.fromARGB(255, 215, 238, 252).withOpacity(0.8),
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(65),
                child: CustomAppBar(productController: productController)),
            // **** RefreshIndicator is used to refresh the list of products when the user pulls down the list ****
            body: RefreshIndicator(
              color: primaryColor.withOpacity(0.6),
              onRefresh: () async {
                productController.refreshProducts();
              },
              // **** Obx is used to listen to the changes in list and update the UI ****
              child: Obx(() {
                if (productController.isLoading.value &&
                        productController.products.isEmpty ||
                    productController.products.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (productController.isLoading.value)
                          Column(
                            children: [
                              Lottie.asset(
                                AssetPaths.dataLoadingAnimation,
                                height: 100,
                                width: 100,
                              ),
                              const Text(
                                'Loading products...',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          )
                        else
                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'No products found, check your internet connection and try again.',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              const Gap(8),

                              // button to refresh the list of products
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    primaryColor.withOpacity(0.6),
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  productController.refreshProducts();
                                },
                                child: const Text(
                                  'Reload',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  );
                }
                // **** NotificationListener is used to listen to the scroll event of the listview and fetch the next page of products when the user reaches the end of the list ****
                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent &&
                        !productController.isLoading.value) {
                      productController.fetchProducts();
                      return true;
                    }
                    return false;
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                      ),
                    ),
                    child: ListView.builder(
                      itemCount: productController.products.length + 1,
                      itemBuilder: (context, index) {
                        // **** condition to show loading indicator at the end of the list ****
                        if (index == productController.products.length &&
                            productController.products.length >= 10) {
                          return Center(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Lottie.asset(
                                  AssetPaths.dataLoadingAnimation,
                                  height: 80,
                                  width: 80,
                                )),
                          );
                        } else if (index >= productController.products.length) {
                          return const SizedBox.shrink();
                        }
                        final product = productController.products[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.details, arguments: product);
                            },
                            child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.7),
                                border: Border.all(
                                    color: const Color.fromARGB(40, 0, 0, 0),
                                    width: 0.5),
                                borderRadius: BorderRadius.circular(14),
                              ),

                              // **** used row instead of ListTile to have more control over the layout specially the image thumbnail ****
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color:
                                                primaryColor.withOpacity(0.4),
                                            width: 0.3),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color.fromARGB(
                                                    255, 179, 178, 178)
                                                .withOpacity(0.2),
                                            blurRadius: 5,
                                            spreadRadius: 2,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: product.thumbnail,
                                        placeholder: (context, url) =>
                                            Lottie.asset(
                                          AssetPaths.imagesLoadingAnimation,
                                          fit: BoxFit.scaleDown,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            maxLines: 2,
                                            product.title,
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          const Gap(8),
                                          Text(
                                            '\$${product.price}  •  Rating: ${product.rating.toString().substring(0, 3)}',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: primaryColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
