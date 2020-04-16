import 'package:easy_bill/Controllers/API_Controllers/Returns/GetMyReturnsService.dart';
import 'package:easy_bill/Controllers/API_Controllers/Returns/RemoveReturnService.dart';
import 'package:easy_bill/Controllers/API_Controllers/Stock/GetMyStockService.dart';
import 'package:easy_bill/Controllers/API_Controllers/Stock/RemoveItemService.dart';
import 'package:easy_bill/Controllers/API_Controllers/Stock/UpdateItemService.dart';
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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(
                                        Icons.remove_circle,
                                        color: Colors.red,
                                      ),
                                      Text(_cartList[index].cart.toString()),
                                      IconButton(
                                        onPressed: () {
                                          if (_cartList.contains(
                                              filteredStockItem[index])) {
                                            setState(() {
                                              _cartList[index].cart+=1;
                                            });
                                            print(_cartList[index].cart);
                                          } else {
                                            setState(() {
                                              _cartList
                                                .add(filteredStockItem[index]);
                                            });
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
