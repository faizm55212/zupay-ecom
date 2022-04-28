import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:zupay_ecom/model/product.dart';
import 'package:http/http.dart' as http;

class Api {
  static Future<List<Product>> getProducts() async {
    List<Product> products = <Product>[];

    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;

        for (var value in data) {
          products.add(Product.fromJson(value));
        }
      } else {
        if (kDebugMode) {
          print("Something went wrong");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    return products;
  }
}
