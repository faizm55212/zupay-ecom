import 'package:flutter/cupertino.dart';
import 'package:zupay_ecom/model/cart.dart';
import 'package:zupay_ecom/model/product.dart';

class CartProvider with ChangeNotifier {
  List<Cart> carts = [];
  double cartPrice = 0;
  bool loading = false;
  void addToCart(Product product) {
    if (carts.any((element) => element.product == product)) {
      for (var element in carts) {
        if (element.product == product) {
          element.quantity++;
        }
      }
    } else {
      carts.add(Cart(product: product));
    }
    cartPrice += product.price!;

    notifyListeners();
  }

  void removeFromCart(Product product) {
    if (carts.isNotEmpty) {
      for (var element in carts) {
        if (element.product == product) {
          if (element.quantity > 1) {
            element.quantity--;
            cartPrice -= product.price!;
            if (cartPrice < 0) {
              cartPrice = 0;
            }
            notifyListeners();
          } else {
            carts.removeWhere((element) => element.product == product);
            cartPrice -= product.price!;
            if (cartPrice < 0) {
              cartPrice = 0;
            }
            notifyListeners();
          }
        }
      }
    }
  }
}
