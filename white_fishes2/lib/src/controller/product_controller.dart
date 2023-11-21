import 'package:get/get.dart';

import '../model/product_response_model.dart';
import '../repositories/get_product_repository.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var products = List<Product>.empty().obs;
  var filteredProducts = List<Product>.empty().obs;
  var searchQuery = ''.obs; // Recherche par nom de poisson

  @override
  Future<void> onInit() async {
    getAllProduct();
    super.onInit();
  }

  Future<void> getAllProduct() async {
    try {
      isLoading(true);
      products.value = await GetProductRepository.getAllProducts();
      filterProducts(); // Filtrer les produits dès le chargement initial
    } catch (e) {
      throw Exception();
    } finally {
      isLoading(false);
    }
  }

  // Fonction pour filtrer les produits par nom de poisson
  void filterProducts() {
    if (searchQuery.isNotEmpty) {
      filteredProducts.value = products
          .where((product) =>
              product.title.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    } else {
      filteredProducts.value = products;
    }
  }
}
