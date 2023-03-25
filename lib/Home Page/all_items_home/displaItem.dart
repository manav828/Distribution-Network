import 'package:ami_milk/fetch_from_firebase/provaider/homeItemProvaider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'oneItemDesign.dart';

class DisplayItem extends StatefulWidget {
  const DisplayItem({Key? key}) : super(key: key);

  @override
  State<DisplayItem> createState() => _DisplayItemState();
}

class _DisplayItemState extends State<DisplayItem> {
  HomeItemProvaider? homeItemProvaider;

  @override
  void initState() {
    // TODO: implement initState
    // HomeItemProvaider homeItemProvaider = Provider.of(context, listen: false);
    // homeItemProvaider.fatchItemsData();
    super.initState();
    Provider.of<HomeItemProvaider>(context, listen: false).fatchItemsData();
  }

  // List<HomeItemProvaider> List = homeItemProvaider!.getItemsDataList;
  @override
  Widget build(BuildContext context) {
    homeItemProvaider = Provider.of<HomeItemProvaider>(context);
    final itemList = homeItemProvaider?.getItemsDataList;
    return Consumer<HomeItemProvaider>(
      builder: (context, homeItemProvaider, child) {
        return GridView.builder(
          // physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 11,
            mainAxisSpacing: 11,
          ),
          itemBuilder: (context, index) {
            return OneItemDesign(
              id: homeItemProvaider.getItemsDataList[index].itemId,
              itemName: homeItemProvaider.getItemsDataList[index].itemName,
              imageLink: homeItemProvaider.getItemsDataList[index].imageLink,
            );
          },
          itemCount: homeItemProvaider.getItemsDataList.length,
        );
      },
    );
  }
}

// OneItemDesign(
//   id: ,
//   itemName: 'Milk',
//   imageLink:
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlbssnDu4nunnWIByUFrsWiUFAjNTRwbf4OA&usqp=CAU',
// ),
// children: [
// OneItemDesign(
// id: 1,
// itemName: 'Milk',
// imageLink:
// 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlbssnDu4nunnWIByUFrsWiUFAjNTRwbf4OA&usqp=CAU',
// ),
// ],

//     child: GridView.builder(
//   itemCount: itemList?.length,
//   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//     crossAxisCount: 2,
//     crossAxisSpacing: 11,
//     mainAxisSpacing: 11,
//   ),
//   itemBuilder: (context, index) {
//     final item = itemList![index];
//     return OneItemDesign(
//       itemName: item.itemName,
//       imageLink: item.imageLink,
//     );
//   },
// )
// height: 400,
// child: GridView.count(
//   crossAxisCount: 2,
//   physics: NeverScrollableScrollPhysics(),
//   crossAxisSpacing: 11,
//   mainAxisSpacing: 11,
//   shrinkWrap: true,
//   children: homeItemProvaider!.getItemsDataList.map((e) {
//     return OneItemDesign(
//         id: e.itemId, itemName: e.itemName, imageLink: e.imageLink);
//   }).toList(),
// ),
