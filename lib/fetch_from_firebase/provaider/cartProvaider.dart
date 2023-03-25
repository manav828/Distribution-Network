import 'package:ami_milk/fetch_from_firebase/models/horiItemModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../Home Page/all_items_home/homePage.dart';

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(now);
String currentDate = DateFormat('dd-MM-yyyy').format(now);
// DateTime tomorrow = DateTime.now().add(Duration(days: 1));
// DateTime tomorrowDate = DateTime(tomorrow.year, tomorrow.month, tomorrow.day);

class CartProvider with ChangeNotifier {
  late HoriItemsModel cartModel;
  List<HoriItemsModel> cartList = [];

  //set cart items
  void setDataOfCart(
      String? itemName,
      String? imageLink,
      double? itemPrice,
      String? itemId,
      String? itemQuantity,
      double? totalPrice,
      int? itemCount) async {
    final firebaseUser = (await FirebaseAuth.instance.currentUser!).uid;

    await FirebaseFirestore.instance
        .collection('Admin')
        .doc('PG2lndSUQG3e3ju13VEm')
        .collection('Agents')
        .doc(agentId)
        .collection('Distributor')
        .doc(firebaseUser)
        .collection('cartDetails')
        .doc(currentDate)
        .collection('cartItems')
        .doc('$itemId')
        .set({
      "itemName": itemName,
      "itemImage": imageLink,
      "itemPrice": itemPrice,
      "itemId": itemId,
      "itemQuantity": itemQuantity,
      "itemCount": itemCount,
      "totalPrice": totalPrice,
    });
    await FirebaseFirestore.instance
        .collection('Admin')
        .doc('PG2lndSUQG3e3ju13VEm')
        .collection('Agents')
        .doc(agentId)
        .collection('Distributor')
        .doc(firebaseUser)
        .collection('cartDetails')
        .doc(currentDate)
        .set({
      "Date": currentDate,
    });
  }

  fatchCartData() async {
    List<HoriItemsModel> newList = [];
    final firebaseUser = (await FirebaseAuth.instance.currentUser!).uid;

    final QuerySnapshot Items = await FirebaseFirestore.instance
        .collection('Admin')
        .doc('PG2lndSUQG3e3ju13VEm')
        .collection('Agents')
        .doc(agentId)
        .collection('Distributor')
        .doc(firebaseUser)
        .collection('cartDetails')
        .doc(currentDate)
        .collection('cartItems')
        .get();

    for (var e in Items.docs) {
      cartModel = HoriItemsModel(
        itemId: e.get('itemId'),
        imageLink: e.get('itemImage'),
        itemName: e.get('itemName'),
        itemPrice: e.get('itemPrice'),
        itemCount: e.get('itemCount'),
        itemQuantity: e.get('itemQuantity'),
        totalPrice: e.get('totalPrice'),
      );

      newList.add(cartModel);
    }

    cartList = newList;
    notifyListeners();
  }

  List<HoriItemsModel> get getCartDataList {
    return cartList;
  }

  /////////////////update cart data///////////
  void updateCart(String? itemId, int? itemCount, double totalPrice) async {
    final firebaseUser = (FirebaseAuth.instance.currentUser!).uid;

    await FirebaseFirestore.instance
        .collection('Admin')
        .doc('PG2lndSUQG3e3ju13VEm')
        .collection('Agents')
        .doc(agentId)
        .collection('Distributor')
        .doc(firebaseUser)
        .collection('cartDetails')
        .doc(currentDate)
        .collection('cartItems')
        .doc('$itemId')
        .update({
      "itemCount": itemCount,
      "totalPrice": totalPrice,
    });
    // getTotalPrice();
  }

  ////////////////total price////////
  getTotalPrice() {
    double total = 0.0;
    cartList.forEach((element) {
      total += element.totalPrice!;
    });
    notifyListeners();

    return total;
  }

  //////////////delete cart item//////////////////
  Future<void> reviewCartDataDelete(String id) async {
    final firebaseUser = (await FirebaseAuth.instance.currentUser!).uid;

    FirebaseFirestore.instance
        .collection('Admin')
        .doc('PG2lndSUQG3e3ju13VEm')
        .collection('Agents')
        .doc(agentId)
        .collection('Distributor')
        .doc(firebaseUser)
        .collection('cartDetails')
        .doc(currentDate)
        .collection('cartItems')
        .doc('${id}')
        .delete();
    notifyListeners();
  }
}
