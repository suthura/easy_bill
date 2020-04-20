import 'package:easy_bill/Controllers/API_Controllers/Sales/GetAllSalesService.dart';
import 'package:easy_bill/Controllers/API_Controllers/Returns/RemoveReturnService.dart';

import 'package:easy_bill/Controllers/API_Controllers/Sales/GetWeeklySalesService.dart';
import 'package:easy_bill/Controllers/API_Controllers/Stock/GetMyStockService.dart';
import 'package:easy_bill/Controllers/API_Controllers/Stock/RemoveItemService.dart';
import 'package:easy_bill/Controllers/API_Controllers/Stock/UpdateItemService.dart';
import 'package:easy_bill/Modals/SaleItem.dart';
import 'package:easy_bill/Modals/StockItem.dart';
import 'package:easy_bill/Views/home_screens/Common/FloatingButton.dart';
import 'package:flutter/material.dart';
import 'package:easy_bill/Views/home_screens/Common/AppBar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ViewWeeklylSalesPage extends StatefulWidget {
  ViewWeeklylSalesPage({Key key}) : super(key: key);

  @override
  _ViewWeeklylSalesPageState createState() => _ViewWeeklylSalesPageState();
}

List<SaleItem> saleItem = List();
List<SaleItem> filteredSaleItem = List();

class _ViewWeeklylSalesPageState extends State<ViewWeeklylSalesPage> {
  final _formKey = GlobalKey<FormState>();
  var formatter = new DateFormat('yyyy-MM-dd kk:mm:ss');
  @override
  void initState() {
    callAPI();
    super.initState();
  }

  SaleItem selectedItem;

  callAPI() {
    GetWeeklySalesService.getSales().then((saleItemFromServer) {
      setState(() {
        saleItem = saleItemFromServer;
        filteredSaleItem = saleItem;
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
            children: <Widget>[ Text(
                "WEEKLY SALES",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        title: Padding(
                          padding: const EdgeInsets.all(0.1),
                          child: Container(
                            decoration: new BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              gradient: new LinearGradient(
                                  colors: [
                                    Color(0xFFF6BDC0),
                                    Color(0xFFEA4C46)
                                  ],
                                  begin: const FractionalOffset(0.0, 0.0),
                                  end: const FractionalOffset(1.0, 1.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, left: 8.0),
                              child: ListTile(
                                subtitle: Text(formatter
                                    .format(DateTime.parse(
                                        filteredSaleItem[index].saletime))
                                    .toString()),
                                title: Text(
                                    filteredSaleItem[index]
                                            .saleData
                                            .length
                                            .toString() +
                                        " Items Sold",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)),
                                trailing: Text(
                                    "Rs : " + filteredSaleItem[index].total,
                                    // + filteredSaleItem[index].total,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                        ),
                        children: <Widget>[
                          ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context2, index2) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(filteredSaleItem[index]
                                          .saleData[index2]
                                          .itemName),
                                      Text(" * " +
                                          filteredSaleItem[index]
                                              .saleData[index2]
                                              .quantity),
                                    ],
                                  )),
                                  Text("Rs: " +
                                      filteredSaleItem[index]
                                          .saleData[index2]
                                          .itemTotal)
                                ],
                              );
                            },
                            itemCount: filteredSaleItem[index].saleData.length,
                          )
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(height: 16);
                    },
                    itemCount: filteredSaleItem.length),
              )
            ],
          ),
        ),
      ),
    );
  }
}
