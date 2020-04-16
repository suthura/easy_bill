class ReturnItem {
  String returnID;
  String name;
  String description;
  String returnDate;

  ReturnItem(
      {this.returnID, this.name,  this.description, this.returnDate});

  factory ReturnItem.fromJson(Map<String, dynamic> json) {
    return ReturnItem(
        returnID: json["_id"] as String,
        name: json["name"] as String,
        description: json["description"] as String,
        returnDate: json["returnDate"] as String);
  }
}
