import 'package:ami_milk/Bottom_Navigation_Display/listofcart.dart';
import 'package:ami_milk/Home%20Page/horizontal_menu/horiItems.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Home Page/horizontal_menu/horiItems.dart';
import '../fetch_from_firebase/models/horiItemModel.dart';
import '../fetch_from_firebase/provaider/cartProvaider.dart';

class Cart extends StatefulWidget {
  // const Cart({Key? key}) : super(key: key);
  // Cart({ this.cartList});
  // List<HoriItemsModel> cartList;

  @override
  State<Cart> createState() => _CartState();
}

HoriItems? horiItems;
HoriItemsModel? itemModel;

class _CartState extends State<Cart> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(widget.cartList);
    CartProvider cartProvider = Provider.of(context, listen: false);
    cartProvider.fatchCartData();
  }

  CartProvider? cartProvider;

  List<HoriItemsModel> cartOfList = cartList;

  String? itemName;
  String? imageLink;
  String? itemId;
  String? itemQuantity;
  double? itemPrice;
  bool? forCartPage = false;

  @override
  Widget build(BuildContext context) {
    // print(cartOfList[0].finalTotal);
    // print(cartOfList[1].finalTotal);
    cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            )),
        // color: Colors.transparent,
        child: Column(
          children: [
            Expanded(child: ListCart()),
            Container(
              height: 60,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Cart Total : ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration
                          .underline, // add an underline decoration
                    ),
                  ),
                  Text(
                    "${cartProvider?.getTotalPrice()}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration
                          .underline, // add an underline decoration
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.grey.shade800,
                          Colors.grey.shade600,
                          // Colors.grey,
                        ],
                      ),
                    ),
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          // do something when the button is pressed
                        },
                        child: Text('Place Order'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .transparent, // make the button background transparent
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ListView(
// children: [
// Container(
//
// child:
// ),
// ],
// ),
