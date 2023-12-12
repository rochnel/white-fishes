// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:white_fishes2/src/view/app_theme.dart';

import '../controller/cart_controller.dart';
import '../controller/product_controller.dart';
import '../model/complement_model.dart';
import '../model/product_response_model.dart';
import 'addresse_page.dart';

class CommandePage extends StatefulWidget {
  CommandePage({
    Key? key,
    required this.productList,
  }) : super(key: key);
  final List<Product> productList;

  @override
  State<CommandePage> createState() => _CommandePageState();
}

class _CommandePageState extends State<CommandePage> {
  final productController = Get.put(ProductController());

  final cartController = Get.put(CartController());

  final List<Complement> complementList = [
    Complement(name: "Plantain", image: "assets/images/plantain.jpg"),
    Complement(name: "Miondo", image: "assets/images/miondo.jpg"),
    Complement(name: "Pommes", image: "assets/images/frites.jpg"),
    // Ajoutez d'autres compléments ici
  ];
  double totalComplementsPrice() {
    double total = 0.0;
    for (int index = 0; index < complementList.length; index++) {
      total += complementList[index].price;
    }
    intPriceComplement();
    return total;
  }

  void intPriceComplement() {
    for (int index = 0; index < complementList.length; index++) {
      complementList[index].price = 500;
    }
  }

  final RxBool showComplements = RxBool(false);
//double priceComplement =0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                // Code à exécuter lors du retour depuis cette page
                if (showComplements.value == true) {
                  cartController.noComplement(totalComplementsPrice());
                }
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          centerTitle: true,
          title: const Text(
            'Votre commande',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            // Code à exécuter lors du retour depuis cette page
            if (showComplements.value == true) {
              cartController.noComplement(totalComplementsPrice());
            }
            print("Fonction exécutée lors du retour depuis cette page.");
            // Retourne true pour permettre le retour, false pour l'empêcher
            return true;
          },
          child: Obx(
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
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  'Vos poissons',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black), // Texte en noir
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(height: 2);
                                  },
                                  itemCount: productController.products.length,
                                  itemBuilder: (context, index) {
                                    if (index < cartController.cart.length) {
                                      final item = cartController.cart[index];
                                      final singleProductPrice =
                                          item.price * item.quantity;
                                      return Container(
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10),
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.black12),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                            color: Colors
                                                                .black12)),
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
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                        IconButton(
                                                            onPressed: () {
                                                              cartController
                                                                  .removeFromCart(
                                                                      item);
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
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
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
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Qte',
                                                              style: AppTheme.of(
                                                                      context)
                                                                  .bodyText2,
                                                            ),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              child: Text(
                                                                item.quantity
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
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
                              if (showComplements.value)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Vos Compléments',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color:
                                                Colors.black), // Texte en noir
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    for (int index = 0;
                                        index < complementList.length;
                                        index++)
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 10),
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.black12),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                            color: Colors
                                                                .black12)),
                                                    child: Image.asset(
                                                      complementList[index]
                                                          .image,
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
                                                            complementList[
                                                                    index]
                                                                .name,
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                        IconButton(
                                                            onPressed: () {
                                                              if (complementList[
                                                                          index]
                                                                      .price >=
                                                                  100) {
                                                                cartController.removeOneComplement(
                                                                    complementList[
                                                                            index]
                                                                        .price);
                                                                setState(() {
                                                                  complementList[
                                                                          index]
                                                                      .price = 0.00;
                                                                });
                                                                Get.snackbar(
                                                                  'Confirmation', // Titre
                                                                  'compléments ${complementList[index].name} a été retirer de votre commande',
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green, // Couleur d'arrière-plan du Snackbar
                                                                  colorText: Colors
                                                                      .white, // Couleur du texte
                                                                  snackPosition:
                                                                      SnackPosition
                                                                          .BOTTOM, // Position du Snackbar
                                                                  duration: Duration(
                                                                      seconds:
                                                                          3), // Durée d'affichage du Snackbar
                                                                  // Autres propriétés comme color, backgroundColor, etc.
                                                                );
                                                              }
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
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            IconButton(
                                                              onPressed: () {
                                                                if (complementList[
                                                                            index]
                                                                        .price >=
                                                                    100) {
                                                                  cartController
                                                                      .removeComplement();
                                                                  setState(() {
                                                                    complementList[
                                                                            index]
                                                                        .price -= 100.0;
                                                                  });
                                                                }
                                                              },
                                                              icon: Icon(
                                                                  Icons.remove),
                                                            ),
                                                            Text(
                                                              complementList[
                                                                          index]
                                                                      .price
                                                                      .toStringAsFixed(
                                                                          2) +
                                                                  " Fcfa",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            IconButton(
                                                              onPressed: () {
                                                                cartController
                                                                    .addComplement();
                                                                setState(() {
                                                                  complementList[
                                                                          index]
                                                                      .price += 100.0;
                                                                });
                                                              },
                                                              icon: Icon(
                                                                  Icons.add),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
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
                              padding: EdgeInsetsDirectional.only(
                                  start: 10, end: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                ElevatedButton(
                                  onPressed: () {
                                    if (showComplements.value == true) {
                                      cartController.noComplement(
                                          totalComplementsPrice());
                                    } else {
                                      cartController.isComplement();
                                    }
                                    showComplements.value =
                                        !showComplements.value;
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        Colors.white, // Couleur de fond blanche
                                  ),
                                  child: (showComplements.value == true)
                                      ? Text(
                                          'Retirer les compléments',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors
                                                  .black), // Texte en noir
                                        )
                                      : Text(
                                          'Ajouter des compléments',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors
                                                  .black), // Texte en noir
                                        ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.to(AdressePage(
                                        cartController.totalPrice.value,
                                        complementList[0].price,
                                        complementList[2].price,
                                        complementList[1].price));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        Colors.white, // Couleur de fond blanche
                                  ),
                                  child: Text(
                                    'Valider ma commande',
                                    style: TextStyle(
                                        fontSize: 13,
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
          ),
        ));
  }
}
