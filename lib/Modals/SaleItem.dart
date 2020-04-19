class SaleItem {
  String total;
  String saletime;
  List<SaleData> saleData;

  SaleItem({this.total, this.saletime, this.saleData});

  factory SaleItem.fromJson(Map<String, dynamic> json) {
    return SaleItem(
      total: json["total"] as String,
      saletime: json["saletime"] as String,
      saleData: (json['saledata'] as List)
          ?.map((i) => SaleData.fromJson(i))
          ?.toList(),
    );
  }
}

class SaleData {
  String itemName;
  String quantity;
  String itemTotal;

  SaleData({this.itemName, this.quantity, this.itemTotal});

  SaleData.fromJson(Map<String, dynamic> json) {
    itemName = json['itemName'];
    quantity = json['quantity'];
    itemTotal = json['itemTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemName'] = this.itemName;
    data['quantity'] = this.quantity;
    data['itemTotal'] = this.itemTotal;
    return data;
  }
}
