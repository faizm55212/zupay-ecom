import 'package:zupay_ecom/model/product.dart';

import 'package:flutter/material.dart';

class Cart {
  int quantity;
  Product product;
  String size;
  Color color;
  Cart(
      {required this.product,
      this.quantity = 1,
      this.size = 'S',
      this.color = Colors.black});
}
