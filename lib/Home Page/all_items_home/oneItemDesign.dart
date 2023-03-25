import 'package:flutter/material.dart';

import '../horizontal_menu/hori_Display.dart';

class OneItemDesign extends StatefulWidget {
  OneItemDesign(
      {required this.id, required this.itemName, required this.imageLink});

  String? imageLink;
  // Future? onTap;
  String? itemName;
  String? id;

  @override
  State<OneItemDesign> createState() => _OneItemDesignState();
}

String? returnId;

class _OneItemDesignState extends State<OneItemDesign> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HoriDisplay(id: widget.id),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              // height: 170,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(widget.imageLink.toString()),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    widget.itemName.toString(),
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Roboto',
                    ),
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
