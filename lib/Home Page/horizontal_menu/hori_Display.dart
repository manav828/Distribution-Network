import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../fetch_from_firebase/provaider/homeItemProvaider.dart';
import '../../fetch_from_firebase/provaider/horiItemProvaider.dart';
import 'horiItems.dart';

class HoriDisplay extends StatefulWidget {
  String? id;
  Column? returnColumn;
  HoriDisplay({this.id, this.returnColumn});
  @override
  State<HoriDisplay> createState() => _HoriDisplayState();
}

class _HoriDisplayState extends State<HoriDisplay> {
  @override
  void initState() {
    // TODO: implement initState
    HoriItemProvaider horiItemProvaider = Provider.of(context, listen: false);
    horiItemProvaider.fatchMilkProductData();
    horiItemProvaider.fatchChhasProductData();
    horiItemProvaider.fatchDahiProductData();
    horiItemProvaider.fatchGheeProductData();
    horiItemProvaider.fatchShikhandProductData();
    super.initState();
    // Provider.of<HoriItemProvaider>(context, listen: false)
    //     .fatchMilkProductData();
  }

  Column? returnColumn() {
    print(":::::::::::::::::::::::::::");
    print(widget.id);
    if (widget.id == "1") {
      return Column(
        children: horiItemProvaider!.getMilkDataList.map((e) {
          return HoriItems(
            itemId: e.itemId,
            itemName: e.itemName,
            imageLink: e.imageLink,
            itemQuantity: e.itemQuantity,
            itemPrice: e.itemPrice,
            isBool: false,
          );
        }).toList(),
        // children: [
        //   HoriItems(),
        // ],
      );
    } else if (widget.id == "2") {
      return Column(
        children: horiItemProvaider!.getChhasDataList.map((e) {
          // print(e.itemPrice);

          return HoriItems(
            itemId: e.itemId,
            itemName: e.itemName,
            imageLink: e.imageLink,
            itemQuantity: e.itemQuantity,
            itemPrice: e.itemPrice,
            isBool: false,
          );
        }).toList(),
        // children: [
        //   HoriItems(),
        // ],
      );
    } else if (widget.id == "3") {
      return Column(
        children: horiItemProvaider!.getDahiDataList.map((e) {
          // print(e.itemPrice);

          return HoriItems(
            itemId: e.itemId,
            itemName: e.itemName,
            imageLink: e.imageLink,
            itemQuantity: e.itemQuantity,
            itemPrice: e.itemPrice,
            isBool: false,
          );
        }).toList(),
        // children: [
        //   HoriItems(),
        // ],
      );
    } else if (widget.id == "4") {
      return Column(
        children: horiItemProvaider!.getShikhandDataList.map((e) {
          // print(e.itemPrice);

          return HoriItems(
            itemId: e.itemId,
            itemName: e.itemName,
            imageLink: e.imageLink,
            itemQuantity: e.itemQuantity,
            itemPrice: e.itemPrice,
            isBool: false,
          );
        }).toList(),
        // children: [
        //   HoriItems(),
        // ],
      );
    } else {
      return Column(
        children: horiItemProvaider!.getGheeDataList.map((e) {
          // print(e.itemPrice);

          return HoriItems(
            itemId: e.itemId,
            itemName: e.itemName,
            imageLink: e.imageLink,
            itemQuantity: e.itemQuantity,
            itemPrice: e.itemPrice,
            isBool: false,
          );
        }).toList(),
        // children: [
        //   HoriItems(),
        // ],
      );
    }
    return null;
  }

  HoriItemProvaider? horiItemProvaider;
  @override
  Widget build(BuildContext context) {
    horiItemProvaider = Provider.of<HoriItemProvaider>(context);
    if (true) {
      double height = MediaQuery.of(context).size.height;
    }
    // double height = MediaQuery.of(context).size.height;

    return Scaffold(
      // appBar: AppBar(
      //   // leading: null,
      //
      //   title: Text(
      //     'Select Items',
      //     style: TextStyle(fontSize: 20, color: Colors.black),
      //   ),
      //   backgroundColor: Colors.white,
      // ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  Text(
                    'All Items',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                      fontSize: 35,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
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
                  child: returnColumn()),
            ),
          ),
        ],
      ),
    );
  }
}
