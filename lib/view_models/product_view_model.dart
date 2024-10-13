import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model.dart';
import 'dart:convert';

class ProductViewModel {
  List<Product> products = [];
  List<Product> filteredProducts = [];

  void searchProducts(String query) {
    filteredProducts = products
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<String?> addProduct(String name, String price) async {
    if (name.isEmpty || price.isEmpty) {
      return 'Name and price are required';
    }

    bool exists = products.any((product) => product.name == name);
    if (exists) {
      return 'Product already exists';
    }

    Product newProduct = Product(name: name, price: price);
    products.add(newProduct);

    await saveProducts();

    return null;
  }

  Future<void> getProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? productData = prefs.getString('products');
    if (productData != null) {
      List<dynamic> productList = jsonDecode(productData);
      products = productList.map((e) => Product.fromJson(e)).toList();
      filteredProducts = products;
    } else {
      products = [];
      filteredProducts = [];
    }
  }

  Future<void> deleteProduct(int index) async {
    products.removeAt(index);
    await saveProducts();
  }

  Future<void> saveProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('products', jsonEncode(products));
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn'); // Clear the login state

    // Navigate back to the LoginPage
    Navigator.pushReplacementNamed(context, '/login');
  }
}
