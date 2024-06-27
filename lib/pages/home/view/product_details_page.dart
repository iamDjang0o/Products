import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pruduct_app/components/colors.dart';
import 'package:pruduct_app/components/images.dart';
import 'package:pruduct_app/models/product/product.dart';

class DetailPage extends StatelessWidget {
  // Directly access Get.arguments where needed instead of passing through constructor
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the arguments directly from Get
    final Product product = Get.arguments;

    return Stack(
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
          appBar: AppBar(
            backgroundColor: Colors.white.withOpacity(0.1),
            title: Text(product.title),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: const Color.fromARGB(19, 0, 0, 0)),
                          color: Colors.white.withOpacity(0.8),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: product.thumbnail,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(
                            child:
                                Lottie.asset(AssetPaths.imagesLoadingAnimation),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ))),
                const Gap(16),
                Text(product.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                const Gap(8),
                Row(
                  children: [
                    const Text('Price: ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('\$${product.price}',
                        style:
                            const TextStyle(fontSize: 16, color: primaryColor)),
                  ],
                ),
                const Gap(8),
                Row(
                  children: [
                    const Text('Rating: ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('${product.rating.toString().substring(0, 3)} / 5',
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 235, 150, 21))),
                  ],
                ),
                const Gap(16),
                Text(product.description,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700])),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
