import 'package:flutter/material.dart';
import 'package:pruduct_app/models/product/product.dart';
import 'package:pruduct_app/pages/home/controller/product_controller.dart'; // Ensure this import is correct
import 'package:pruduct_app/utils/route/routes.dart';
import 'package:search_page/search_page.dart';

class CustomAppBar extends StatelessWidget {
  final ProductController productController; // Define productController here

  const CustomAppBar(
      {super.key, required this.productController}); // Modify this line

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white.withOpacity(0.1),
      automaticallyImplyLeading: false,
      title: const Text('Products'),
      actions: [
        IconButton(
          onPressed: () {
            showSearch(
                context: context,
                delegate: SearchPage<Product>(
                  items: productController.products,
                  searchLabel: 'Search products...',
                  suggestion: const Center(
                    child: Text('Filter products by name'),
                  ),
                  failure: const Center(
                    child: Text('No product found :('),
                  ),
                  filter: (product) => [product.title],
                  builder: (product) => ListTile(
                    title: Text(product.title),
                    subtitle:
                        Text('\$${product.price} • Rating: ${product.rating}'),
                    leading: CircleAvatar(
                        backgroundImage: NetworkImage(product.thumbnail),
                        child: Image.network(product.thumbnail)),
                    onTap: () {
                      // Navigate to the product details page
                      Navigator.of(context).pushNamed(
                        Routes.details,
                        arguments: product,
                      );
                    },
                  ),
                ));
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }
}
