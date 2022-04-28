import 'package:flutter/cupertino.dart';
import 'package:zupay_ecom/api/api.dart';
import 'package:zupay_ecom/model/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> products = [];
  bool loading = false;
  void getProduct() {
    if (products.isEmpty) {
      loading = true;
      notifyListeners();
      Api.getProducts().then((value) {
        loading = false;
        notifyListeners();
        products = value;
        notifyListeners();
      });
    }
  }
}
