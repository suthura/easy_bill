import 'package:easy_bill/Controllers/API_Controllers/Returns/GetMyReturnsService.dart';
import 'package:easy_bill/Controllers/API_Controllers/Returns/RemoveReturnService.dart';
import 'package:easy_bill/Controllers/API_Controllers/Sales/AddNewSaleService.dart';
import 'package:easy_bill/Controllers/API_Controllers/Stock/GetMyStockService.dart';
import 'package:easy_bill/Controllers/API_Controllers/Stock/RemoveItemService.dart';
import 'package:easy_bill/Controllers/API_Controllers/Stock/UpdateItemService.dart';
import 'package:easy_bill/Controllers/API_Controllers/Stock/UpdateStockService.dart';
import 'package:easy_bill/Modals/ReturnItem.dart';
import 'package:easy_bill/Modals/StockItem.dart';
import 'package:flutter/material.dart';
import 'package:easy_bill/Views/home_screens/Common/AppBar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AvailableListPage extends StatefulWidget {
  AvailableListPage({Key key}) : super(key: key);

  @override
  _AvailableListPageState createState() => _AvailableListPageState();
}

List<StockItem> stockItem = List();
List<StockItem> filteredStockItem = List();

List<StockItem> _cartList = List();

double total = 0.0;

class _AvailableListPageState extends State<AvailableListPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    callAPI();
    super.initState();
  }

  ReturnItem selectedItem;

  callAPI() {
    GetMyStockService.getStock().then((stockItemFromServer) {
      setState(() {
        stockItem = stockItemFromServer;
        filteredStockItem = stockItem;
        print("Item list updated");
        _cartList.clear();

        _cartList = filteredStockItem;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width * 2 / 3,
                height: 50,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Total (Rs) : $total",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              height: 50,
              color: Colors.greenAccent,
              child: IconButton(
                  tooltip: "Save",
                  icon: Icon(
                    FontAwesomeIcons.print,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    if (total > 0.0) {
                      List _cartIndexs = [];
                      double priceForItems = 0.0;

                      ///Do something here OnSlide
                      for (var i = 0; i < _cartList.length; i++) {
                        if (_cartList[i].cart > 0) {
                          int newStock =
                              (_cartList[i].stock) - (_cartList[i].cart);

                          final body = {
                            "itemid": _cartList[i].itemID,
                            "newStock": newStock
                          };

                          UpdateStockService.updateStock(body).then((success) {
                            if (success) {
                              print("stock updated");
                              callAPI();
                              // clearContollers();
                            } else {
                              print("failed");
                            }
                          });

                          priceForItems = (_cartList[i].cart.toDouble()) *
                              double.parse(_cartList[i].price);

                          final saleItem = {
                            "itemName": _cartList[i].name,
                            "quantity": _cartList[i].cart,
                            "itemTotal": priceForItems.toString()
                          };
                          _cartIndexs.add(saleItem);
                        }
                      }
                      DateTime now = DateTime.now();

                      final salesList = {
                        "token":
                            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZTkzMWU0NjYxYzVjMDAwMTcwYmNkYzUiLCJpYXQiOjE1ODY4NjU5MDB9.5rMJBsgdlMQZVqoFPU3iCHoLm44gn7v_HPPDc90F1DA",
                        "saledata": _cartIndexs,
                        "total": total,
                        "saletime": now.toString()
                      };

                      AddNewSaleService.newSale(salesList).then((success) {
                        if (success) {
                          print("Sale Success");
                          callAPI();
                          // clearContollers();
                        } else {
                          print("failed");
                        }
                      });

                      print(salesList);
                      // initState();
                    } else {
                      print("no items in cart");
                    }
                  }),
            ),
          ],
        ),
      ),
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
                child: GridView.builder(
                    padding: const EdgeInsets.all(4.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: filteredStockItem.length,
                    itemBuilder: (context, index) {
                      return Card(
                          elevation: 4.0,
                          child: Stack(
                            fit: StackFit.loose,
                            alignment: Alignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  // Icon(Icons.add_comment),
                                  Text(
                                    filteredStockItem[index].name,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
                                  Text(
                                    filteredStockItem[index].description,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.subhead,
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 8.0,
                                  bottom: 8.0,
                                ),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  // child: GestureDetector(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () {
                                          if (_cartList[index].cart > 0) {
                                            setState(() {
                                              _cartList[index].cart -= 1;
                                              total -= double.parse(
                                                  _cartList[index].price);

                                              print(_cartList[index]
                                                  .cart
                                                  .toString());
                                            });
                                          }
                                        },
                                        icon: Icon(Icons.remove_circle),
                                        color: Colors.red,
                                      ),
                                      Text(_cartList[index].cart.toString()),
                                      IconButton(
                                        onPressed: () {
                                          if (_cartList[index].cart <
                                              filteredStockItem[index].stock) {
                                            setState(() {
                                              _cartList[index].cart += 1;
                                              total += double.parse(
                                                  _cartList[index].price);
                                              print(_cartList[index]
                                                  .cart
                                                  .toString());
                                            });
                                          } else {
                                            print("limit exceededd");
                                          }
                                        },
                                        icon: Icon(Icons.add_circle),
                                        color: Colors.green,
                                      )
                                    ],
                                  ),
                                  // onTap: () {
                                  // setState(() {
                                  //   if (_cartList
                                  //       .contains(filteredStockItem[index]))
                                  //     _cartList
                                  //         .remove(filteredStockItem[index]);
                                  //   else
                                  //     _cartList
                                  //         .add(filteredStockItem[index]);
                                  // });
                                  // },
                                  // ),
                                ),
                              ),
                            ],
                          ));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
