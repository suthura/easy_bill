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

class ViewReturnsPage extends StatefulWidget {
  ViewReturnsPage({Key key}) : super(key: key);

  @override
  _ViewReturnsPageState createState() => _ViewReturnsPageState();
}

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
}
