import 'package:flutter/cupertino.dart';
import 'package:zupay_ecom/model/product.dart';

class CartProvider with ChangeNotifier {
  List<Product> carts = [];
  bool loading = false;
  void addToCart(Product product) {
    carts.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    carts.remove(product);
  }
}
