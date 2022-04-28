import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zupay_ecom/bottom_nav.dart';
import 'package:zupay_ecom/provider/cart.dart';
import 'package:zupay_ecom/provider/products.dart';
import 'package:zupay_ecom/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 705),
      builder: (_) => MultiProvider(
        providers: [
          ChangeNotifierProvider<ProductProvider>(
              create: (_) => ProductProvider()),
          ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
        ],
        child: MaterialApp(
          title: 'Ecom',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const BottomNavBar(),
        ),
      ),
    );
  }
}
