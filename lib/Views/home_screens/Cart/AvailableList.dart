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

List<ReturnItem> returnItem = List();
List<ReturnItem> filteredReturnItem = List();

class _AvailableListPageState extends State<AvailableListPage> {
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
                    itemCount: filteredReturnItem.length,
                    itemBuilder: (context, index) {
                      return Text("card");
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
