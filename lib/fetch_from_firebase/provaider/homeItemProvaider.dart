import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/homePage_Item_Model.dart';
// import 'package:loginuicolors/models/product_model.dart';

class HomeItemProvaider with ChangeNotifier {
  late HomePageItems homePageItems;
  List<HomePageItems> itemsList = [];
  fatchItemsData() async {
    List<HomePageItems> newList = [];

    final QuerySnapshot HomeItems =
        await FirebaseFirestore.instance.collection("Products").get();

    HomeItems.docs.forEach((e) {
      homePageItems = HomePageItems(
        itemId: e.get('id'),
        imageLink: e.get('imageLink'),
        itemName: e.get('itemName'),
      );

      newList.add(homePageItems);
      // print(newList);
    });
    itemsList = newList;
    notifyListeners();
  }

  List<HomePageItems> get getItemsDataList {
    return itemsList;
  }
}
