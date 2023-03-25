class HoriItemsModel {
  String? itemName;
  String? imageLink;
  String? itemId;
  String? itemQuantity;
  double? itemPrice;
  double? totalPrice;
  int? itemCount;
  bool? isBool;
  Function()? onDelete;
  HoriItemsModel(
      {this.itemId,
      this.itemName,
      this.imageLink,
      this.itemQuantity,
      this.itemPrice,
      this.itemCount,
      this.totalPrice,
      this.onDelete,
      this.isBool});
}
