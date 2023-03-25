import 'package:ami_milk/Home%20Page/horizontal_menu/horiItems.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Home Page/horizontal_menu/horiItems.dart';
import '../fetch_from_firebase/models/horiItemModel.dart';
import '../fetch_from_firebase/provaider/cartProvaider.dart';

class ListCart extends StatefulWidget {
  // const Cart({Key? key}) : super(key: key);
  List<double>? totalPrice;

  ListCart({this.totalPrice});

  @override
  State<ListCart> createState() => _ListCartState();
}

HoriItems? horiItems;
HoriItemsModel? itemModel;

class _ListCartState extends State<ListCart> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CartProvider cartProvider = Provider.of(context, listen: false);
    cartProvider.fatchCartData();
  }

  List<HoriItemsModel> cartOfList = cartList;

  String? itemName;
  String? imageLink;
  String? itemId;
  String? itemQuantity;
  double? itemPrice;
  bool? forCartPage = false;

  CartProvider? cartProvider;

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Cart Items',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                        fontSize: 35,
                      ),
                    ),
                  ),
                ]),
          ),
          Container(
// color: Color(0xffececec),
// height: height,
            child: Container(
              margin: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                  color: Color(0xffececec),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Container(
                  margin: EdgeInsets.only(top: 30.0, left: 25, right: 25),
                  child: cartProvider!.getCartDataList.isEmpty
                      ? Container(
                          height: MediaQuery.of(context).size.height - 300,
                          child: Center(
                            child: Text("No Data"),
                          ),
                        )
                      : Column(
                          children: cartProvider!.getCartDataList.map((e) {
                            // int index = cartProvider!.getItemsDataList.indexOf(e);

                            // sum = sum + ((e.itemQuantity)! * (e.itemPrice)!);
                            return HoriItems(
                              itemId: e.itemId,
                              itemName: e.itemName,
                              imageLink: e.imageLink,
                              itemQuantity: e.itemQuantity,
                              itemPrice: e.itemPrice,
                              itemCount: e.itemCount,
                            );
                          }).toList(),
                        )),
            ),
          ),
        ],
      ),
    );
  }
}

// Column(
// children: cartList.map((e) {
// return HoriItems(
// itemId: e.itemId,
// itemName: e.itemName,
// imageLink: e.imageLink,
// itemQuantity: e.itemQuantity,
// itemPrice: e.itemPrice,
// itemCount: e.itemCount,
// // isBool: true,
// );
// }).toList(),
// ),
