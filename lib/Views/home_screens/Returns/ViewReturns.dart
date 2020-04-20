import 'dart:async';

import 'package:easy_bill/Controllers/API_Controllers/Returns/GetMyReturnsService.dart';
import 'package:easy_bill/Controllers/API_Controllers/Returns/RemoveReturnService.dart';
import 'package:easy_bill/Controllers/API_Controllers/Stock/GetMyStockService.dart';
import 'package:easy_bill/Controllers/API_Controllers/Stock/RemoveItemService.dart';
import 'package:easy_bill/Controllers/API_Controllers/Stock/UpdateItemService.dart';
import 'package:easy_bill/Modals/ReturnItem.dart';
import 'package:easy_bill/Modals/StockItem.dart';
import 'package:easy_bill/Views/home_screens/Common/FloatingButton.dart';
import 'package:flutter/material.dart';
import 'package:easy_bill/Views/home_screens/Common/AppBar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewReturnsPage extends StatefulWidget {
  ViewReturnsPage({Key key}) : super(key: key);

  @override
  _ViewReturnsPageState createState() => _ViewReturnsPageState();
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

List<ReturnItem> returnItem = List();
List<ReturnItem> filteredReturnItem = List();

class _ViewReturnsPageState extends State<ViewReturnsPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    callAPI();
    super.initState();
  }

  ReturnItem selectedItem;

  callAPI() {
    GetMyReturnsService.getRturns().then((returnItemFromServer) {
      setState(() {
        returnItem = returnItemFromServer;
        filteredReturnItem = returnItem;
        print("Item list updated");
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
                "VIEW RETURNS",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              //SerachBar Related content---//////////////////////////////////////////////////////////////////////
              _buildSearchBar(context),
              //SerachBar Related content---//////////////////////////////////////////////////////////////////////
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
                                  children: <Widget>[
                                    Text(filteredReturnItem[index].name),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(filteredReturnItem[index].description),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      filteredReturnItem[index].returnDate,
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
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    final body = {
                                      "returnID": filteredReturnItem[index].returnID
                                    };
                                    print(body);

                                    RemoveReturnService.removeReturn(body)
                                        .then((success) {
                                      if (success) {
                                        print("deleted");
                                        callAPI();
                                        // Navigator.of(context).pop();
                                      } else {
                                        print("failed");
                                      }
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
                    itemCount: filteredReturnItem.length),
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
              filteredReturnItem = returnItem
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
