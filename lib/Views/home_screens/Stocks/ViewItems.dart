import 'package:easy_bill/Controllers/API_Controllers/Stock/GetMyStockService.dart';
import 'package:easy_bill/Controllers/API_Controllers/Stock/RemoveItemService.dart';
import 'package:easy_bill/Controllers/API_Controllers/Stock/UpdateItemService.dart';
import 'package:easy_bill/Modals/StockItem.dart';
import 'package:flutter/material.dart';
import 'package:easy_bill/Views/home_screens/Common/AppBar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewItemPage extends StatefulWidget {
  ViewItemPage({Key key}) : super(key: key);

  @override
  _ViewItemPageState createState() => _ViewItemPageState();
}

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

  callAPI() {
    GetMyStockService.getStock().then((stockItemFromServer) {
      setState(() {
        stockItem = stockItemFromServer;
        filteredStockItem = stockItem;
        print("Item list updated");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Container(
            // color: Colors.amber,
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
                tooltip: "New Sale",
                icon: Icon(
                  FontAwesomeIcons.plusCircle,
                  color: Colors.black,
                ),
                onPressed: null),
          ],
        )),
      ),
      appBar: appBar(),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      // print(widget.filteredSaleItem.length);

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 3 / 5,
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
                                    Text(filteredStockItem[index].description),
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
                                        filteredStockItem[index].description;
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
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text("Edit"),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(4.0),
                                                        child: TextFormField(
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
                                                                  new BorderRadius
                                                                          .circular(
                                                                      25.0),
                                                              borderSide:
                                                                  new BorderSide(),
                                                            ),
                                                            //fillColor: Colors.green
                                                          ),
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          style: new TextStyle(
                                                            fontFamily:
                                                                "Poppins",
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(4.0),
                                                        child: TextFormField(
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
                                                                  new BorderRadius
                                                                          .circular(
                                                                      25.0),
                                                              borderSide:
                                                                  new BorderSide(),
                                                            ),
                                                            //fillColor: Colors.green
                                                          ),
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          style: new TextStyle(
                                                            fontFamily:
                                                                "Poppins",
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(4.0),
                                                        child: TextFormField(
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
                                                                  new BorderRadius
                                                                          .circular(
                                                                      25.0),
                                                              borderSide:
                                                                  new BorderSide(),
                                                            ),
                                                            //fillColor: Colors.green
                                                          ),
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          style: new TextStyle(
                                                            fontFamily:
                                                                "Poppins",
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(4.0),
                                                        child: TextFormField(
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
                                                                  new BorderRadius
                                                                          .circular(
                                                                      25.0),
                                                              borderSide:
                                                                  new BorderSide(),
                                                            ),
                                                            //fillColor: Colors.green
                                                          ),
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          style: new TextStyle(
                                                            fontFamily:
                                                                "Poppins",
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              InkWell(
                                                                onTap: () {
                                                                  final body = {
                                                                    "itemid":
                                                                        stockIDController
                                                                            .text
                                                                  };

                                                                  RemoveItemService
                                                                          .removeItem(
                                                                              body)
                                                                      .then(
                                                                          (success) {
                                                                    if (success) {
                                                                      print(
                                                                          "saved");
                                                                      callAPI();
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    } else {
                                                                      print(
                                                                          "failed");
                                                                    }
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 40,
                                                                  width: 100,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    borderRadius:
                                                                        new BorderRadius.circular(
                                                                            25.0),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .grey,
                                                                        style: BorderStyle
                                                                            .solid,
                                                                        width:
                                                                            0.80),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            20.0,
                                                                        top:
                                                                            10),
                                                                    child: Text(
                                                                        "Delete"),
                                                                  ),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  final body = {
                                                                    "name":
                                                                        nameController
                                                                            .text,
                                                                    "price":
                                                                        priceController
                                                                            .text,
                                                                    "description":
                                                                        descriptionController
                                                                            .text,
                                                                    "stock":
                                                                        stockController
                                                                            .text,
                                                                    "itemid":
                                                                        stockIDController
                                                                            .text
                                                                  };

                                                                  UpdateItemService
                                                                          .updateItem(
                                                                              body)
                                                                      .then(
                                                                          (success) {
                                                                    if (success) {
                                                                      print(
                                                                          "saved");
                                                                      callAPI();
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    } else {
                                                                      print(
                                                                          "failed");
                                                                    }
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 40,
                                                                  width: 100,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .greenAccent,
                                                                    borderRadius:
                                                                        new BorderRadius.circular(
                                                                            25.0),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .grey,
                                                                        style: BorderStyle
                                                                            .solid,
                                                                        width:
                                                                            0.80),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            20.0,
                                                                        top:
                                                                            10),
                                                                    child: Text(
                                                                        "Update"),
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
}
