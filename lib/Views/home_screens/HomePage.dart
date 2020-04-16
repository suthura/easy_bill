import 'package:easy_bill/Views/home_screens/Common/FloatingButton.dart';
import 'package:easy_bill/Views/home_screens/Returns/AddReturn.dart';
import 'package:easy_bill/Views/home_screens/Returns/ViewReturns.dart';
import 'package:easy_bill/Views/home_screens/Stocks/AddItem.dart';
import 'package:easy_bill/Views/home_screens/Stocks/ViewItems.dart';
import 'package:flutter/material.dart';
import 'package:easy_bill/Views/home_screens/Common/AppBar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: floatingButton(context),
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            _buildCard(
              "Stocks",
              'assets/images/stock.png',
              PopupMenuButton<int>(
                  icon: Icon(FontAwesomeIcons.chevronCircleDown),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                            child: InkWell(
                          onTap: () {
                            print("add item");
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddItemPage()));
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.add_circle,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Add Items")
                            ],
                          ),
                        )),
                        PopupMenuItem(
                            child: InkWell(
                          onTap: () {
                            print("view item");
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ViewItemPage()));
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.assignment,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("View Items")
                            ],
                          ),
                        ))
                      ]),
            ),
            _buildCard(
              "Sales",
              'assets/images/cart.png',
              PopupMenuButton<int>(
                  icon: Icon(FontAwesomeIcons.chevronCircleDown),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                            child: Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.solidArrowAltCircleRight,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("View Sales")
                          ],
                        )),
                      ]),
            ),
            _buildCard(
              "Returns",
              'assets/images/return.png',
              PopupMenuButton<int>(
                  icon: Icon(FontAwesomeIcons.chevronCircleDown),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                            child: InkWell(
                          onTap: () {
                            print("add return");
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddReturnPage()));
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.add_circle,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Add Return")
                            ],
                          ),
                        )),
                        PopupMenuItem(
                            child: InkWell(
                          onTap: () {
                            print("view return");
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ViewReturnsPage()));
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.assignment,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("View Returns")
                            ],
                          ),
                        ))
                      ]),
            ),
          ],
        ),
      ),
    );
  }
}

final baseTextStyle = const TextStyle();

final headerTextStyle = baseTextStyle.copyWith(
    color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.w600);

final regularTextStyle = baseTextStyle.copyWith(
    color: const Color(0xffb6b2df), fontSize: 9.0, fontWeight: FontWeight.w400);

final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 12.0);

Widget _buildCard(cardName, imagePath, Widget dropDownData) {
  return new Container(
      height: 170.0,
      margin: const EdgeInsets.symmetric(
        vertical: 0.0,
        horizontal: 0.0,
      ),
      child: new Stack(
        children: <Widget>[
          Container(
            margin: new EdgeInsets.fromLTRB(50.0, 16.0, 16.0, 16.0),
            constraints: new BoxConstraints.expand(),
            decoration: new BoxDecoration(
              color: new Color(0xFF333366),
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0),
                ),
              ],
            ),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // new Container(height: 25.0),
                new Text(
                  cardName,
                  style: headerTextStyle,
                ),
                // new Container(height: 20.0),
                // new Text("vdsvsdv",
                //     style: subHeaderTextStyle),
                // new Container(
                //     // margin: new EdgeInsets.symmetric(vertical: 8.0),
                //     height: 2.0,
                //     width: 18.0,
                //     color: new Color(0xff00c6ff)),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 105,
              width: 105,
              margin: EdgeInsets.only(left: 0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFFE0E0E0), width: 5),
                color: Color(0xFF81C784),
              ),
              // margin: new EdgeInsets.symmetric(vertical: 16.0),
              // alignment: FractionalOffset.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(imagePath,
                      // width: 100.0, height: 100.0,
                      fit: BoxFit.contain)
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.only(right: 15),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25)),
              ),
              child: Container(
                child: dropDownData,
                // alignment: FractionalOffset.centerRight,
                // child: IconButton(
                //   icon: Icon(
                //     FontAwesomeIcons.chevronCircleDown,
                //     size: 20,
                //     color: Color(0xFFf44336),
                //   ),
                //   onPressed: () {},
                // ),
              ),
            ),
          )
        ],
      ));
}
