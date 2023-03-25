import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../models/horiItemModel.dart';

class HoriItemProvaider with ChangeNotifier {
  late HoriItemsModel horiItemsModel;

  List<HoriItemsModel> search = [];

  void horiItemsModels(QueryDocumentSnapshot element) {
    Map<String, dynamic>? data = element.data() as Map<String, dynamic>?;
    if (data != null) {
      horiItemsModel = HoriItemsModel(
        // imageLink: element.get("imageLink"),
        // itemName: element.get("itemName"),
        // itemPrice: element.get("itemPrice"),
        // itemId: element.get("id"),
        // itemQuantity: element.get("itemQuantity"),
        imageLink: data['imageLink'],
        itemName: data['itemName'],
        itemPrice:
            data['itemPrice']?.toDouble(), // convert to double if it's not null
        itemId: data['id'],
        itemQuantity: data['itemQuantity'],
      );
      search.add(horiItemsModel);
    }
  }

  /////////////// MilkProduct ///////////////////////////////
  List<HoriItemsModel> milkProductList = [];

  fatchMilkProductData() async {
    List<HoriItemsModel> newList = [];

    QuerySnapshot<Map<String, dynamic>> value = await FirebaseFirestore.instance
        .collection("Products")
        .doc("n5iIbah0FPEgLyMFZEm7")
        .collection("MilkItems")
        .get();

    value.docs.forEach(
      (element) {
        horiItemsModels(element);

        newList.add(horiItemsModel);
      },
    );
    milkProductList = newList;
    notifyListeners();
  }

  List<HoriItemsModel> get getMilkDataList {
    return milkProductList;
  }

  /////////////// DahiProduct ///////////////////////////////
  List<HoriItemsModel> dahiProductList = [];

  fatchDahiProductData() async {
    List<HoriItemsModel> newList = [];

    QuerySnapshot<Map<String, dynamic>> value = await FirebaseFirestore.instance
        .collection("Products")
        .doc("CIC6vU2Wq6HzqZLCIfNn")
        .collection("DahiItems")
        .get();

    value.docs.forEach(
      (element) {
        horiItemsModels(element);

        newList.add(horiItemsModel);
      },
    );
    dahiProductList = newList;
    notifyListeners();
  }

  List<HoriItemsModel> get getDahiDataList {
    return dahiProductList;
  }

  /////////////// chhasProduct ///////////////////////////////
  List<HoriItemsModel> chhasProductList = [];

  fatchChhasProductData() async {
    List<HoriItemsModel> newList = [];

    QuerySnapshot<Map<String, dynamic>> value = await FirebaseFirestore.instance
        .collection("Products")
        .doc("65za1vUXvSxEqF0HHtT6")
        .collection("ChhasItems")
        .get();

    value.docs.forEach(
      (element) {
        horiItemsModels(element);

        newList.add(horiItemsModel);
      },
    );
    chhasProductList = newList;
    notifyListeners();
  }

  List<HoriItemsModel> get getChhasDataList {
    return chhasProductList;
  }

/////////////// ShikhandProduct ///////////////////////////////
  List<HoriItemsModel> shikhandProductList = [];

  fatchShikhandProductData() async {
    List<HoriItemsModel> newList = [];

    QuerySnapshot<Map<String, dynamic>> value = await FirebaseFirestore.instance
        .collection("Products")
        .doc("vxOYUDXt1cmMwQuluuhF")
        .collection("ShikhandItem")
        .get();

    value.docs.forEach(
      (element) {
        horiItemsModels(element);

        newList.add(horiItemsModel);
      },
    );
    shikhandProductList = newList;
    notifyListeners();
  }

  List<HoriItemsModel> get getShikhandDataList {
    return shikhandProductList;
  }

  /////////////// GheeProduct ///////////////////////////////
  List<HoriItemsModel> gheeProductList = [];

  fatchGheeProductData() async {
    List<HoriItemsModel> newList = [];

    QuerySnapshot<Map<String, dynamic>> value = await FirebaseFirestore.instance
        .collection("Products")
        .doc("ob2b7ztLKwQVkleb3n7u")
        .collection("GheeItems")
        .get();

    value.docs.forEach(
      (element) {
        horiItemsModels(element);

        newList.add(horiItemsModel);
      },
    );
    gheeProductList = newList;
    notifyListeners();
  }

  List<HoriItemsModel> get getGheeDataList {
    return gheeProductList;
  }
}
