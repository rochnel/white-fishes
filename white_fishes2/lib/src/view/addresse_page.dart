import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badge;
import 'package:white_fishes2/src/controller/cart_controller.dart';
import 'package:white_fishes2/src/controller/product_controller.dart';
import 'package:white_fishes2/src/view/add_to_cart_page.dart';

class AdressePage extends StatelessWidget {
  AdressePage(this.total);
  double? total;
  final productController = Get.put(ProductController());
  final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * (1 / 852.0);
    var width = MediaQuery.of(context).size.width * (1 / 393.0);
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: Image.asset("assets/images/logo2.png"),
                  ),
                  Obx(() {
                    return productController.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : badge.Badge(
                            position:
                                badge.BadgePosition.topEnd(top: -10, end: -12),
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
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Adresse de Livraison",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(45),
              width: width * 350,
              height: height * 280,
              color: Color.fromARGB(255, 255, 227, 225),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Montant Total :${cartController.totalPrice.value.toStringAsFixed(2)} FCFA'),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Montant Total :1000 FCFA"),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text("Total :${(cartController.totalPrice.value+1000).toStringAsFixed(2)} FCFA"),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: TextField(
                decoration: InputDecoration(labelText: 'Entrez votre nom'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Entrez votre numéro de téléphone'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: TextField(
                decoration: InputDecoration(labelText: 'Entrez votre adresse'),
              ),
            ),
                Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: ElevatedButton(
          onPressed: () {
            // Action à effectuer lorsqu'on appuie sur le bouton Envoyer
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.red, // Couleur rouge pour le bouton
          ),
          child: Text('Envoyer'),
        ),
          ),
          ],
        ),
      ),
    ));
  }
}
