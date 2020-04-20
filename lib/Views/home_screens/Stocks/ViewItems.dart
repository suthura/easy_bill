import 'dart:async';

import 'package:easy_bill/Controllers/API_Controllers/Stock/GetMyStockService.dart';
import 'package:easy_bill/Controllers/API_Controllers/Stock/RemoveItemService.dart';
import 'package:easy_bill/Controllers/API_Controllers/Stock/UpdateItemService.dart';
import 'package:easy_bill/Modals/StockItem.dart';
import 'package:easy_bill/Views/auth_screens/loginPage.dart';
import 'package:easy_bill/Views/home_screens/Common/FloatingButton.dart';
import 'package:flutter/material.dart';
import 'package:easy_bill/Views/home_screens/Common/AppBar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ViewItemPage extends StatefulWidget {
  ViewItemPage({Key key}) : super(key: key);

  @override
  _ViewItemPageState createState() => _ViewItemPageState();
}

//SerachBar Related content---//////////////////////////////////////////////////////////////////////
class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

final _debouncer = Debouncer(milliseconds: 500);
final _search = TextEditingController();
bool isSearchFocused = false;
//SerachBar Related content---//////////////////////////////////////////////////////////////////////

List<StockItem> stockItem = List();
List<StockItem> filteredStockItem = List();

class _ViewItemPageState extends State<ViewItemPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    callAPI();
    super.initState();
  }

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final stockController = TextEditingController();
  final stockIDController = TextEditingController();

  StockItem selectedItem;
  bool isLoading = true;
  bool isProcessing = false;

  callAPI() {
    GetMyStockService.getStock().then((stockItemFromServer) {
      setState(() {
        stockItem = stockItemFromServer;
        filteredStockItem = stockItem;
        print("Item list updated");
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: floatingButton(context),
      appBar: appBar(),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "VIEW ITEMS",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              //SerachBar Related content---//////////////////////////////////////////////////////////////////////
              _buildSearchBar(context),
              //SerachBar Related content---//////////////////////////////////////////////////////////////////////
              SizedBox(
                height: 30,
              ),
              isLoading
                  ? Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          LinearProgressIndicator(),
                          Text("Loading Data...")
                        ],
                      ),
                    )
                  : Expanded(
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            // print(widget.filteredSaleItem.length);

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 3 / 5,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(filteredStockItem[index].name),
                                          Text("Rs: " +
                                              filteredStockItem[index].price),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(filteredStockItem[index]
                                              .description),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            filteredStockItem[index]
                                                    .stock
                                                    .toString() +
                                                " Available",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          nameController.text =
                                              filteredStockItem[index].name;
                                          priceController.text =
                                              filteredStockItem[index].price;
                                          descriptionController.text =
                                              filteredStockItem[index]
                                                  .description;
                                          stockController.text =
                                              filteredStockItem[index]
                                                  .stock
                                                  .toString();
                                          stockIDController.text =
                                              filteredStockItem[index].itemID;
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content: Form(
                                                    key: _formKey,
                                                    child: Expanded(
                                                      child:
                                                          SingleChildScrollView(
                                                        child: isProcessing
                                                            ? LinearProgressIndicator()
                                                            : Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                        "Edit"),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            4.0),
                                                                    child:
                                                                        TextFormField(
                                                                      controller:
                                                                          nameController,
                                                                      decoration:
                                                                          new InputDecoration(
                                                                        labelText:
                                                                            "Item Name",
                                                                        fillColor:
                                                                            Colors.white,
                                                                        border:
                                                                            new OutlineInputBorder(
                                                                          borderRadius:
                                                                              new BorderRadius.circular(25.0),
                                                                          borderSide:
                                                                              new BorderSide(),
                                                                        ),
                                                                        //fillColor: Colors.green
                                                                      ),
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .text,
                                                                      style:
                                                                          new TextStyle(
                                                                        fontFamily:
                                                                            "Poppins",
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            4.0),
                                                                    child:
                                                                        TextFormField(
                                                                      controller:
                                                                          priceController,
                                                                      decoration:
                                                                          new InputDecoration(
                                                                        labelText:
                                                                            "Item Price",
                                                                        fillColor:
                                                                            Colors.white,
                                                                        border:
                                                                            new OutlineInputBorder(
                                                                          borderRadius:
                                                                              new BorderRadius.circular(25.0),
                                                                          borderSide:
                                                                              new BorderSide(),
                                                                        ),
                                                                        //fillColor: Colors.green
                                                                      ),
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .text,
                                                                      style:
                                                                          new TextStyle(
                                                                        fontFamily:
                                                                            "Poppins",
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            4.0),
                                                                    child:
                                                                        TextFormField(
                                                                      controller:
                                                                          descriptionController,
                                                                      decoration:
                                                                          new InputDecoration(
                                                                        labelText:
                                                                            "Item Description",
                                                                        fillColor:
                                                                            Colors.white,
                                                                        border:
                                                                            new OutlineInputBorder(
                                                                          borderRadius:
                                                                              new BorderRadius.circular(25.0),
                                                                          borderSide:
                                                                              new BorderSide(),
                                                                        ),
                                                                        //fillColor: Colors.green
                                                                      ),
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .text,
                                                                      style:
                                                                          new TextStyle(
                                                                        fontFamily:
                                                                            "Poppins",
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            4.0),
                                                                    child:
                                                                        TextFormField(
                                                                      controller:
                                                                          stockController,
                                                                      decoration:
                                                                          new InputDecoration(
                                                                        labelText:
                                                                            "Available Stock",
                                                                        fillColor:
                                                                            Colors.white,
                                                                        border:
                                                                            new OutlineInputBorder(
                                                                          borderRadius:
                                                                              new BorderRadius.circular(25.0),
                                                                          borderSide:
                                                                              new BorderSide(),
                                                                        ),
                                                                        //fillColor: Colors.green
                                                                      ),
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .text,
                                                                      style:
                                                                          new TextStyle(
                                                                        fontFamily:
                                                                            "Poppins",
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: <
                                                                            Widget>[
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                isProcessing = true;
                                                                              });
                                                                              final body = {
                                                                                "itemid": stockIDController.text
                                                                              };

                                                                              RemoveItemService.removeItem(body).then((success) {
                                                                                if (success) {
                                                                                  print("saved");
                                                                                  callAPI();
                                                                                  setState(() {
                                                                                    isProcessing = false;
                                                                                  });

                                                                                  // Navigator.of(context).pop();
                                                                                  Alert(
                                                                                    style: AlertStyle(
                                                                                      animationType: AnimationType.fromTop,
                                                                                      isCloseButton: false,
                                                                                      isOverlayTapDismiss: false,
                                                                                      descStyle: TextStyle(fontWeight: FontWeight.bold),
                                                                                      animationDuration: Duration(milliseconds: 400),
                                                                                      alertBorder: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(0.0),
                                                                                        side: BorderSide(
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                      ),
                                                                                      titleStyle: TextStyle(
                                                                                        color: Colors.red,
                                                                                      ),
                                                                                    ),
                                                                                    context: context,
                                                                                    type: AlertType.success,
                                                                                    title: "Item Removed",
                                                                                    desc: "Item has been deleted",
                                                                                    buttons: [
                                                                                      DialogButton(
                                                                                        child: Text(
                                                                                          "OK",
                                                                                          style: TextStyle(color: Colors.white, fontSize: 20),
                                                                                        ),
                                                                                        onPressed: () {
                                                                                          Navigator.pop(context);
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        width: 120,
                                                                                      )
                                                                                    ],
                                                                                  ).show();
                                                                                } else {
                                                                                  print("failed");
                                                                                  setState(() {
                                                                                    isProcessing = false;
                                                                                  });
                                                                                  Alert(
                                                                                    style: AlertStyle(
                                                                                      animationType: AnimationType.fromTop,
                                                                                      isCloseButton: false,
                                                                                      isOverlayTapDismiss: false,
                                                                                      descStyle: TextStyle(fontWeight: FontWeight.bold),
                                                                                      animationDuration: Duration(milliseconds: 400),
                                                                                      alertBorder: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(0.0),
                                                                                        side: BorderSide(
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                      ),
                                                                                      titleStyle: TextStyle(
                                                                                        color: Colors.red,
                                                                                      ),
                                                                                    ),
                                                                                    context: context,
                                                                                    type: AlertType.error,
                                                                                    title: "Deletion Failed",
                                                                                    desc: "Check Again",
                                                                                    buttons: [
                                                                                      DialogButton(
                                                                                        child: Text(
                                                                                          "OK",
                                                                                          style: TextStyle(color: Colors.white, fontSize: 20),
                                                                                        ),
                                                                                        onPressed: () => Navigator.pop(context),
                                                                                        width: 120,
                                                                                      )
                                                                                    ],
                                                                                  ).show();
                                                                                }
                                                                              });
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              height: 40,
                                                                              width: 100,
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.red,
                                                                                borderRadius: new BorderRadius.circular(25.0),
                                                                                border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 20.0, top: 10),
                                                                                child: Text("Delete"),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                isProcessing = true;
                                                                              });
                                                                              final body = {
                                                                                "name": nameController.text,
                                                                                "price": priceController.text,
                                                                                "description": descriptionController.text,
                                                                                "stock": stockController.text,
                                                                                "itemid": stockIDController.text
                                                                              };

                                                                              UpdateItemService.updateItem(body).then((success) {
                                                                                if (success) {
                                                                                  print("saved");
                                                                                  callAPI();
                                                                                  setState(() {
                                                                                    isProcessing = false;
                                                                                  });
                                                                                  // Navigator.of(context).pop();
                                                                                  Alert(
                                                                                    style: AlertStyle(
                                                                                      animationType: AnimationType.fromTop,
                                                                                      isCloseButton: false,
                                                                                      isOverlayTapDismiss: false,
                                                                                      descStyle: TextStyle(fontWeight: FontWeight.bold),
                                                                                      animationDuration: Duration(milliseconds: 400),
                                                                                      alertBorder: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(0.0),
                                                                                        side: BorderSide(
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                      ),
                                                                                      titleStyle: TextStyle(
                                                                                        color: Colors.red,
                                                                                      ),
                                                                                    ),
                                                                                    context: context,
                                                                                    type: AlertType.success,
                                                                                    title: "Success",
                                                                                    desc: "Stock Updated",
                                                                                    buttons: [
                                                                                      DialogButton(
                                                                                        child: Text(
                                                                                          "OK",
                                                                                          style: TextStyle(color: Colors.white, fontSize: 20),
                                                                                        ),
                                                                                        onPressed: () {
                                                                                          Navigator.pop(context);
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        width: 120,
                                                                                      )
                                                                                    ],
                                                                                  ).show();
                                                                                } else {
                                                                                  setState(() {
                                                                                    isProcessing = false;
                                                                                  });
                                                                                  print("failed");
                                                                                  Alert(
                                                                                    style: AlertStyle(
                                                                                      animationType: AnimationType.fromTop,
                                                                                      isCloseButton: false,
                                                                                      isOverlayTapDismiss: false,
                                                                                      descStyle: TextStyle(fontWeight: FontWeight.bold),
                                                                                      animationDuration: Duration(milliseconds: 400),
                                                                                      alertBorder: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(0.0),
                                                                                        side: BorderSide(
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                      ),
                                                                                      titleStyle: TextStyle(
                                                                                        color: Colors.red,
                                                                                      ),
                                                                                    ),
                                                                                    context: context,
                                                                                    type: AlertType.error,
                                                                                    title: "Update Failed",
                                                                                    desc: "Check Again",
                                                                                    buttons: [
                                                                                      DialogButton(
                                                                                        child: Text(
                                                                                          "OK",
                                                                                          style: TextStyle(color: Colors.white, fontSize: 20),
                                                                                        ),
                                                                                        onPressed: () => Navigator.pop(context),
                                                                                        width: 120,
                                                                                      )
                                                                                    ],
                                                                                  ).show();
                                                                                }
                                                                              });
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              height: 40,
                                                                              width: 100,
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.greenAccent,
                                                                                borderRadius: new BorderRadius.circular(25.0),
                                                                                border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 20.0, top: 10),
                                                                                child: Text("Update"),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ))
                                                                ],
                                                              ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                        })
                                  ],
                                )
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(height: 16);
                          },
                          itemCount: filteredStockItem.length),
                    )
            ],
          ),
        ),
      ),
    );
  }

//SerachBar Related content---//////////////////////////////////////////////////////////////////////
  Widget _buildSearchBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      width: MediaQuery.of(context).size.width / 1.2,
      height: 45,
      // margin: EdgeInsets.only(top: 32),
      padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: TextField(
        keyboardType: TextInputType.text,
        // controller: _search,
        onTap: () {
          setState(() {
            isSearchFocused = true;
          });
        },
        onChanged: (string) {
          _debouncer.run(() {
            setState(() {
              filteredStockItem = stockItem
                  .where((u) =>
                      (u.name.toLowerCase().contains(string.toLowerCase())))
                  .toList();
            });
          });
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
            size: 30,
          ),
          hintText: 'search',
        ),
      ),
    );
  }
  //SerachBar Related content---//////////////////////////////////////////////////////////////////////
}
