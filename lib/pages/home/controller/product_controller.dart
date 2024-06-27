import 'package:get/get.dart';

import 'package:pruduct_app/models/product/product.dart';
import 'package:pruduct_app/utils/services/api_services.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = false.obs;

  var currentPage = 0.obs;
  final int pageSize = 10;

  final ApiService apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    if (isLoading.value) return;

    isLoading.value = true;

    try {
      final newProducts = await apiService.fetchProducts(
        skip: currentPage.value * pageSize,
        limit: pageSize,
      );
      products.addAll(newProducts);
      currentPage.value += 1;
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  //function to refresh the products
  void refreshProducts() {
    products.clear();
    currentPage.value = 0;
    fetchProducts();
  }
}
