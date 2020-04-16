class StockItem {
  String itemID;
  String name;
  String price;
  String description;
  int stock;
  int cart;

  StockItem(
      {this.itemID,
      this.name,
      this.price,
      this.description,
      this.stock,
      this.cart});

  factory StockItem.fromJson(Map<String, dynamic> json) {
    return StockItem(
        itemID: json["_id"] as String,
        name: json["name"] as String,
        price: json["price"] as String,
        description: json["description"] as String,
        stock: json["stock"] as int,
        cart: 0);
  }
}
