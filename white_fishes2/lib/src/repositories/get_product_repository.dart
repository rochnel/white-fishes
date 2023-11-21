// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

import '../model/product_response_model.dart';
import '../../core/providers/dio_providers.dart';
import '../../core/strings/app_strings.dart';

class GetProductRepository {
  static final DioProvider dioProvider = DioProvider();

  static Future<List<Product>> getAllProducts() async {
    try {
      

      List<Product> products =
          Product.productList;

      return products;
    } catch (e) {
      throw Exception();
    }
  }
}
