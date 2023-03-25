import 'package:ami_milk/Bottom_Navigation_Display/cart.dart';
import 'package:ami_milk/fetch_from_firebase/provaider/cartProvaider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import '../../fetch_from_firebase/models/horiItemModel.dart';

List<HoriItemsModel> cartList = [];
List<String> cartIds = [];
double Price = 0.0;

class HoriItems extends StatefulWidget {
  String? itemName;
  String? imageLink;
  String? itemId;
  String? itemQuantity;
  double? itemPrice;
  double? finalTotal;
  int? itemCount = 0;
  bool? isBool = false;
  Function()? onDelete;
  HoriItems(
      {this.itemId,
      this.itemName,
      this.imageLink,
      this.itemQuantity,
      this.itemPrice,
      this.isBool,
      this.onDelete,
      this.finalTotal = 0,
      this.itemCount = 0});

  @override
  State<HoriItems> createState() => _HoriItemsState();
}

class _HoriItemsState extends State<HoriItems> {
  int itemCount = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Provider.of<CartProvaider>(context, listen: false);
  }

  // update cart value
  // void updateCart(String? itemId, int? itemCount) async {
  //   double localPriceTotal = 0.0;
  //
  //   final firebaseUser = (FirebaseAuth.instance.currentUser!).uid;
  //   localPriceTotal += widget.finalTotal!;
  //   print("????????/////////");
  //   print(widget.itemName);
  //   print(localPriceTotal);
  //   await FirebaseFirestore.instance
  //       .collection('UserData')
  //       .doc(firebaseUser)
  //       .collection('cart')
  //       .doc('${itemId}')
  //       .update({
  //     "itemCount": itemCount,
  //     "totalPrice": widget.finalTotal,
  //   });
  //   Price += localPriceTotal;
  //   // totalPrice = totalPrice + itemQuantity! * price!;
  // }

  /////dailog box delete cart///////
  CartProvider? cartProvider;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of(context);
    return Container(
      height: 120,
      width: 400,
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              // height: 270,
              // width: 190,
              // color: Colors.grey,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: NetworkImage(widget.imageLink.toString()),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          // ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        widget.itemName.toString(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        '(${widget.itemPrice}₹/${widget.itemQuantity})',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Roboto',
                          fontSize: 14,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (itemCount > 0) {
                                itemCount--;

                                widget.itemCount = itemCount;
                                widget.finalTotal =
                                    itemCount * (widget.itemPrice)!;
                                // print(widget.finalTotal);
                                cartProvider.updateCart(widget.itemId,
                                    itemCount, widget.finalTotal!);
                                cartProvider.fatchCartData();

                                cartProvider.getTotalPrice();

                                // cartTotal();
                              }
                            });
                          },
                          icon: Icon(
                            Icons.remove,
                          ),
                        ),
                        Text("${widget.itemCount}"),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              itemCount++;

                              widget.itemCount = itemCount;
                              widget.finalTotal =
                                  itemCount * (widget.itemPrice)!;

                              // cartTotal();
                              // print(widget.finalTotal);
                            });
                            cartProvider.updateCart(
                                widget.itemId, itemCount, widget.finalTotal!);
                            cartProvider.fatchCartData();

                            cartProvider.getTotalPrice();
                          },
                          icon: Icon(
                            Icons.add,
                          ),
                        ),
                        SizedBox(
                          width: 50.0,
                          height: 25.0,
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                itemCount += 10;
                                widget.itemCount = itemCount;
                                widget.finalTotal =
                                    itemCount * (widget.itemPrice)!;
                                // updateCart(widget.itemId, itemCount);
                                cartProvider.updateCart(widget.itemId,
                                    itemCount, widget.finalTotal!);
                                cartProvider.fatchCartData();

                                cartProvider.getTotalPrice();
                                // cartTotal();

                                // print(widget.finalTotal);
                              });
                            },
                            textColor: Colors.black,
                            color: Colors.white,
                            child: Text(
                              '+10',
                              style: TextStyle(fontSize: 9),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                widget.isBool == false
                    ? IconButton(
                        onPressed: () {
                          if (cartIds.contains(widget.itemId.toString())) {
                            print(widget.isBool.toString());

                            print("item alrady exist in your cart");
                          } else {
                            cartIds.add(widget.itemId.toString());

                            cartProvider.setDataOfCart(
                                widget.itemName,
                                widget.imageLink,
                                widget.itemPrice,
                                widget.itemId,
                                widget.itemQuantity,
                                widget.finalTotal,
                                itemCount);
                          }
                        },
                        icon: Icon(Icons.add_shopping_cart),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              cartProvider.reviewCartDataDelete(widget.itemId!);
                              cartIds.remove(widget.itemId);
                              cartProvider.fatchCartData();
                              print("removed");
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
