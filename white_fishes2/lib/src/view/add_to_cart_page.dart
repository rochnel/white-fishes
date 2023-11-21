// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:white_fishes2/src/view/app_theme.dart';
import 'package:white_fishes2/src/view/commande_page.dart';

import '../controller/cart_controller.dart';
import '../controller/product_controller.dart';
import '../model/product_response_model.dart';

class AddToCartPage extends StatelessWidget {
  AddToCartPage({
    Key? key,
    required this.productList,
  }) : super(key: key);
  final List<Product> productList;
  final productController = Get.put(ProductController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          centerTitle: true,
          title: const Text(
            "Votre panier",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Obx(
          () => cartController.cart.isEmpty
              ? const Center(
                  child: Text(
                    "Aucun produit n'a été ajouté pour le moment. Veuillez selectionner un produit dans l'onglet",
                    textAlign: TextAlign.center,
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                          itemCount: productController.products.length,
                          itemBuilder: (context, index) {
                            if (index < cartController.cart.length) {
                              final item = cartController.cart[index];
                              final singleProductPrice =
                                  item.price * item.quantity;
                              return Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black12)),
                                            child: Image.asset(
                                              item.image,
                                              height: 80,
                                              width: 90,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 150,
                                                  child: Text(
                                                    item.title,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      cartController
                                                          .removeFromCart(item);
                                                    },
                                                    icon: const Icon(
                                                      Icons
                                                          .delete_outline_outlined,
                                                      color: Colors.red,
                                                    ))
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  // ignore: unnecessary_null_comparison
                                                  item.quantity == 0
                                                      ? "${item.price} Fcfa"
                                                      : "${singleProductPrice.toStringAsFixed(2)} Fcfa",
                                                  style: const TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Qte',
                                                      style:
                                                          AppTheme.of(context)
                                                              .bodyText2,
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          cartController
                                                              .decrement(item);
                                                        },
                                                        icon: const Icon(
                                                            Icons.remove)),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(2),
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              219, 227, 228)),
                                                      child: Text(
                                                        item.quantity
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          cartController
                                                              .increment(item);
                                                        },
                                                        icon: const Icon(
                                                            Icons.add)),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }
                            return const SizedBox();
                          }),
                    ),
                    //     Container(
                    //       padding: const EdgeInsets.all(20),
                    //       margin: const EdgeInsets.all(10),
                    //       decoration: BoxDecoration(
                    //           color: Colors.black12.withOpacity(.1),
                    //           borderRadius: BorderRadius.circular(16)),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Text(
                    //             "Total items (${cartController.totalQuantity.value})",
                    //             style: const TextStyle(
                    //                 fontSize: 18, fontWeight: FontWeight.w700),
                    //           ),
                    //           Text(
                    //             "Total Prices: ${cartController.totalPrice.value.toStringAsFixed(2)}",
                    //             style: const TextStyle(
                    //                 fontSize: 18, fontWeight: FontWeight.w700),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    Container(
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppTheme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x320E151B),
                            offset: Offset(0, -2),
                          )
                        ],
                      ),
                      alignment: AlignmentDirectional(0, -0.35),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.only(start: 10, end: 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Total',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.info_outlined,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      onPressed: () {
                                        print('IconButton pressed ...');
                                      },
                                    ),
                                  ],
                                ),
                                Text(
                                  '${cartController.totalPrice.value.toStringAsFixed(2)} FCFA',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Text(
                              //   'Envoyer la cammande',
                              //   style: AppTheme.of(context).title2.override(
                              //         fontFamily: 'Poppins',
                              //         color: AppTheme.of(context).primaryBtnText,
                              //       ),
                              // ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      Colors.white, // Couleur de fond blanche
                                ),
                                child: Text(
                                  'Continuer les achats',
                                  style: TextStyle(
                                      color: Colors.black), // Texte en noir
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.to(CommandePage(
                                    productList: productController.products,
                                  ));
                                },
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      Colors.white, // Couleur de fond blanche
                                ),
                                child: Text(
                                  'Voir ma commande',
                                  style: TextStyle(
                                      color: Colors.black), // Texte en noir
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ));
  }
}
