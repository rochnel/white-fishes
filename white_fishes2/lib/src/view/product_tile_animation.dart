import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/cart_controller.dart';
import '../controller/product_controller.dart';
import '../model/product_response_model.dart';
import 'add_to_cart_page.dart';
import 'app_theme.dart';

class ProductTileAnimation extends StatelessWidget {
  final int itemNo;
  final Product product;

  ProductTileAnimation({this.itemNo = 0, required this.product});
  final cartController = Get.put(CartController());
    final productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * (1 / 852.0);
    var width = MediaQuery.of(context).size.width * (1 / 393.0);
    return Container(
      width: width * 181,
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                  width: width * 175,
                  height: height * 124.55,
                  child: Image.asset(
                    product.image,
                    fit: BoxFit.fill,
                  )),

              Positioned(
                top: 6,
                left: 6,
                child: GestureDetector(
                  onTap: () {
                     cartController.addToCart(product);
                      Get.to(AddToCartPage(
                            productList: productController.products,
                          ));
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Ajouter',
                          style: TextStyle(color: Colors.white, fontSize: 14.6),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
             
            ],
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: AppTheme.of(context).bodyText1,
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  '${product.price} FCFA',
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
