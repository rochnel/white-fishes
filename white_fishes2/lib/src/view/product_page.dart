import 'package:white_fishes2/src/view/product_tile_animation.dart';

import '../controller/cart_controller.dart';
import '../controller/product_controller.dart';
import 'add_to_cart_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badge;

class ProductPage extends StatelessWidget {
  ProductPage({super.key});

  final productController = Get.put(ProductController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(onPressed: (){}, icon: Icon(Icons.help, size: 30, color: Colors.black,)),
          title: Padding(
            padding: EdgeInsets.only(left: 10),
            child: SizedBox(
              width: 100,
              child: Image.asset("assets/images/logo2.png"),
            ),
          ),
          centerTitle: true,
          actions: [
            Obx(() {
              return productController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : badge.Badge(
                      position: badge.BadgePosition.topEnd(top: -10, end: -12),
                      showBadge: true,
                      ignorePointer: false,
                      badgeContent: Text(
                        cartController.cart.length.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                      child: GestureDetector(
                        onTap: () {
                          Get.to(AddToCartPage(
                            productList: productController.products,
                          ));
                        },
                        child: const Icon(
                          Icons.shopping_cart,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    );
            }),
            const SizedBox(width: 20),
          ],
        ),
        body: Obx(
          () => productController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      // Champ de recherche
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Rechercher par nom de poisson',
                            labelStyle: TextStyle(
                              color: Colors
                                  .red, // Couleur du texte d'indice (hint text) lorsque le champ est en surbrillance
                            ), 
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors
                                  .red, // Couleur de l'icône lorsque le champ est en surbrillance
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            hintStyle: TextStyle(
                              color: Colors
                                  .red, // Couleur du texte d'indice (hint text) lorsque le champ est en surbrillance
                            ),
                          ),
                          onChanged: (value) {
                            productController.searchQuery.value = value;
                            productController.filterProducts();
                          },
                        ),
                      ),
                      Expanded(
                        child: LayoutBuilder(builder: (context, constraints) {
                          return GridView.builder(
                            itemCount:
                                productController.filteredProducts.length,
                            itemBuilder: (context, index) =>
                                ProductTileAnimation(
                              itemNo: index,
                              product:
                                  productController.filteredProducts[index],
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 1,
                              crossAxisCount:
                                  constraints.maxWidth > 700 ? 4 : 2,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
        ));
  }
}
