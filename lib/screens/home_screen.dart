import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:zupay_ecom/provider/cart.dart';
import 'package:zupay_ecom/provider/products.dart';
import 'package:provider/provider.dart';
import 'package:zupay_ecom/screens/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    productProvider.getProduct();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            NestedScrollView(
              headerSliverBuilder: ((context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    toolbarHeight: 60,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    actions: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 26,
                        ),
                      )
                    ],
                    leading: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset('assets/icons/menu.svg'),
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(10),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Text(
                            'New Arrival',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF1C1C19),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ];
              }),
              body: Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 10, right: 10, bottom: 65),
                child: Consumer<ProductProvider>(builder: (_, instance, child) {
                  if (instance.loading) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Color(0xFF1C1C19),
                    ));
                  }
                  return GridView.builder(
                      itemCount: instance.products.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 / 5,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (context, ind) {
                        return Material(
                          elevation: 2,
                          child: Column(
                            children: [
                              Image.network(
                                instance.products[ind].image!,
                                height: 150,
                                width: 150,
                                fit: BoxFit.fill,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: 130,
                                      child: Text(
                                        instance.products[ind].description!,
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF7154B8),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      instance.products[ind].title!,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF4B4A5A),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "\$ ${instance.products[ind].price!.toString()}",
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6, horizontal: 13),
                                          child: GestureDetector(
                                            onTap: () {
                                              Fluttertoast.showToast(
                                                  msg: "Item Added To Cart",
                                                  gravity: ToastGravity.BOTTOM);
                                              cartProvider.addToCart(
                                                  instance.products[ind]);
                                            },
                                            child: SvgPicture.asset(
                                                'assets/icons/cart.svg'),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                height: 60,
                width: 360.w,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              LineIcon.home(
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text('Home',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CartScreen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LineIcon.shoppingBag(
                            color: const Color(0xFFAFBEC4),
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
