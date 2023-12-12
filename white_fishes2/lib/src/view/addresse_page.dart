import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badge;
import 'package:white_fishes2/src/controller/cart_controller.dart';
import 'package:white_fishes2/src/controller/product_controller.dart';
import 'package:white_fishes2/src/view/add_to_cart_page.dart';
import 'package:white_fishes2/src/view/product_page.dart';

class AdressePage extends StatelessWidget {
  AdressePage(this.total, this.plantaint, this.pomme, this.miondo);
  double? total, plantaint, pomme, miondo;
  final productController = Get.put(ProductController());
  final cartController = Get.put(CartController());

  final TextEditingController nomController = TextEditingController();
  final TextEditingController telController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();

  void sendOrderToAPI() async {
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    String nom = nomController.text;
    String tel = telController.text;
    String adresse = adresseController.text;

    var orderData = {
      "client": {
        "tel": tel,
        "email": "toto@gmail.com",
        "localisation": adresse,
        "name": nom,
        "bills": [
          {
            "amount": cartController.totalPrice.value + 1000,
            "complements": [
              {"name": "plantain", "price": plantaint},
              {"name": "pomme", "price": pomme},
              {"name": "miondo", "price": miondo}
            ],
            "fishList": cartController.cart.map((product) {
              return {
                "unit_price": product.price,
                "quantity": product.quantity,
                "name": product.title,
              };
            }).toList()
          }
        ]
      }
    };

    var apiUrl =
        'http://51.195.137.143:8080/whitefish-v0/deliveryWhiteFish/email';

    try {
      print(orderData);
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(orderData),
      );

      Get.back(); // Fermer le loader

      if (response.statusCode == 200) {
        Get.snackbar('Succès', 'Commande envoyée avec succès',
            backgroundColor: Colors.green, colorText: Colors.white);
        cartController.clearCart();
        Get.off(ProductPage());
      } else {
        print('Erreur lors de l\'envoi de la commande: ${response.statusCode}');
        Get.back();
        Get.snackbar('Erreur', 'Erreur lors de l\'envoi de la commande',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print('Erreur lors de l\'envoi de la commande: $e');
      Get.back();
      Get.snackbar('Erreur', 'Erreur lors de l\'envoi de la commande',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

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
                  Text(
                      'Montant Total :${cartController.totalPrice.value.toStringAsFixed(2)} FCFA'),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Frais de livraison  :1000 FCFA"),
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
                  Text(
                      "Total :${(cartController.totalPrice.value + 1000).toStringAsFixed(2)} FCFA"),
                ],
              ),
            ),
          Padding(
  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
  child: TextField(
    controller: nomController,
    decoration: InputDecoration(labelText: 'Entrez votre nom'),
  ),
),
Padding(
  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
  child: TextField(
    controller: telController,
    decoration: InputDecoration(
        labelText: 'Entrez votre numéro de téléphone'),
  ),
),
Padding(
  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
  child: TextField(
    controller: adresseController,
    decoration: InputDecoration(labelText: 'Entrez votre adresse'),
  ),
),
Padding(
  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
  child: ElevatedButton(
    onPressed: () {
      if (nomController.text.isNotEmpty &&
          telController.text.isNotEmpty &&
          adresseController.text.isNotEmpty) {
        // Tous les champs sont remplis, on peut envoyer la commande à l'API
        sendOrderToAPI();
      } else {
         Get.snackbar('Erreur', 'Tous les champs sont obligatoires',
            backgroundColor: Colors.red, colorText: Colors.white);   }
    },
    style: ElevatedButton.styleFrom(
      primary: Colors.red, // Couleur rouge pour le bouton
    ),
    child: Text('Envoyer la commande'),
  ),
),

          ],
        ),
      ),
    ));
  }
}
