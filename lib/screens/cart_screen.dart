import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:zupay_ecom/provider/cart.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: 20,
        ),
        title: Text(
          'Your Cart',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Consumer<CartProvider>(builder: (_, instance, child) {
          if (instance.loading) {
            return const Center(
                child: CircularProgressIndicator(
              color: Color(0xFF1C1C19),
            ));
          }
          return ListView.builder(
              itemCount: instance.carts.length,
              itemBuilder: (context, ind) {
                return Padding(
                  padding: EdgeInsets.only(top: ind == 0 ? 0 : 15),
                  child: Material(
                    elevation: 1,
                    child: SizedBox(
                      height: 120.h,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              instance.carts[ind].image!,
                              height: 90.h,
                              width: 90.h,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              height: 90.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 220.w,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 100.w,
                                          child: Text(
                                            instance.carts[ind].title!,
                                            maxLines: 2,
                                            overflow: TextOverflow.clip,
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xFF4B4A5A),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "\$ ${instance.carts[ind].price!.toString()}",
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 220.w,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Size: ',
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              'S',
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Color  ',
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Container(
                                              height: 13,
                                              width: 13,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(3)),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                cartProvider.removeFromCart(
                                                    instance.carts[ind]);
                                              },
                                              child: const Icon(
                                                LineIcons.minusSquare,
                                                size: 25,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              '1',
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            const Icon(
                                              LineIcons.plusSquare,
                                              size: 25,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        }),
      ),
    );
  }
}
